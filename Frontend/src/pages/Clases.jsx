import React from 'react';
import { useEffect, useState } from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import { Calendar, momentLocalizer } from 'react-big-calendar';
import moment from 'moment';
import 'react-big-calendar/lib/css/react-big-calendar.css';
import axios from 'axios';
import Header from '../layout/Header.jsx';
import Footer from '../layout/Footer.jsx';

moment.locale('es', {
  week: {
    dow: 1,
  }
});
const localizer = momentLocalizer(moment);

function Clases({ usuarioLogueado, setVista, setUsuarioLogueado }) {
  const [clases, setClases] = useState([]);
  const [error, setError] = useState('');

  useEffect(() => {
    if (!usuarioLogueado || usuarioLogueado.tipo !== 4) {
      setVista('inicio');
      return;
    }

    const fetchData = async () => {
      try {
        // carga clases disponibles
        const clasesRes = await axios.get('http://localhost:3000/clases/disponibles');
        
        // Intentar cargar reservas del usuario
        let reservas = [];
        try {
          const reservasRes = await axios.get(`http://localhost:3000/clases/${usuarioLogueado.id_usuario}`);
          reservas = reservasRes.data;
        } catch (reservaError) {
          console.warn('No se pudieron cargar las reservas:', reservaError.message);
          
        }

        // Extraer ids de clases reservadas
        const clasesReservadasIds = new Set(
          reservas.map(clase => clase.IdClaseProgramada || clase.id_clase_programada)
        );

        // formato calendaario se mapea
        const eventos = clasesRes.data.map((clase) => ({
          id: clase.IdClaseProgramada,
          title: `${clase.NombreClase}\n${clase.NombreCoach}`,
          start: new Date(clase.FechaHora),
          end: new Date(new Date(clase.FechaHora).getTime() + 60 * 60 * 1000),
          allDay: false,
          data: { 
            ...clase, 
            reservada: clasesReservadasIds.has(clase.IdClaseProgramada) 
          },
        }));

        setClases(eventos);
      } catch (err) {
        console.error('Error al cargar datos:', err);
        setError('Error al cargar las clases. Por favor intenta más tarde.');
      }
    };

    fetchData();
  }, [usuarioLogueado, setVista]);

  const handleReservar = async (clase) => {
    try {
      await axios.post('http://localhost:3000/reservas', {
        idClaseProgramada: clase.id,
        idUsuario: usuarioLogueado.id_usuario,
      });
      
      // actualizar para marcar como resrvado
      setClases(clases.map(c => 
        c.id === clase.id ? { ...c, data: { ...c.data, reservada: true } } : c
      ));
      
      alert('¡Clase reservada con éxito!');
    } catch (error) {
      console.error('Error al reservar:', error);
      setError(error.response?.data?.error || 'Error al reservar clase');
    }
  };

  const eventPropGetter = (event) => ({
    style: {
      backgroundColor: event.data.reservada ? '#4CAF50' : '#A559ED',
      color: 'white',
      borderRadius: '4px',
      border: 'none',
      fontSize: '0.85rem',
      padding: '2px 5px',
      whiteSpace: 'normal'
    },
  });

  return (
    <div className="d-flex flex-column min-vh-100">
      <Header setVista={setVista} usuarioLogueado={usuarioLogueado} />
      <main className="flex-grow-1">
        <div className="container py-4">
          <div className="d-flex justify-content-between align-items-center mb-3">
            <h2 className="mb-0">Clases Disponibles</h2>
            <div className="d-flex">
              <span className="badge bg-primary mx-2">
                <i className="bi bi-square-fill me-1"></i> Disponible
              </span>
              <span className="badge bg-success">
                <i className="bi bi-square-fill me-1"></i> Reservada
              </span>
            </div>
          </div>

          {error && <div className="alert alert-danger">{error}</div>}

          <div style={{ height: '75vh' }}>
            <Calendar
              localizer={localizer}
              events={clases}
              startAccessor="start"
              endAccessor="end"
              defaultView="week"
              views={['week']}
              min={new Date(0, 0, 0, 7, 0, 0)}
              max={new Date(0, 0, 0, 22, 0, 0)}
              step={30}
              timeslots={2}
              defaultDate={new Date()}
              eventPropGetter={eventPropGetter}
              onSelectEvent={(event) => {
                if (event.data.reservada) {
                  alert('Ya has reservado esta clase');
                  return;
                }
                if (window.confirm(
                  `Reservar ${event.data.NombreClase} con ${event.data.NombreCoach}\n` +
                  `El ${moment(event.start).format('dddd D [de] MMMM')}\n` +
                  `De ${moment(event.start).format('HH:mm')} a ${moment(event.end).format('HH:mm')}\n` +
                  `En ${event.data.NombreSalon}?`
                )) {
                  handleReservar(event);
                }
              }}
              messages={{
                today: 'Hoy',
                previous: 'Anterior',
                next: 'Siguiente',
                week: 'Semana',
              }}
            />
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
}

export default Clases;
