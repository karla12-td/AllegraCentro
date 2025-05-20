import React from 'react';
import { useEffect, useState } from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import { Calendar, momentLocalizer } from 'react-big-calendar';
import moment from 'moment';
import 'react-big-calendar/lib/css/react-big-calendar.css';
import axios from 'axios';
import Header from '../layout/Header.jsx';
import Footer from '../layout/Footer.jsx';
import '../css/GestionClases.css';

// moment js
moment.locale('es', {
  months: 'Enero_Febrero_Marzo_Abril_Mayo_Junio_Julio_Agosto_Septiembre_Octubre_Noviembre_Diciembre'.split('_'),
  weekdays: 'Domingo_Lunes_Martes_Miércoles_Jueves_Viernes_Sábado'.split('_'),
  weekdaysShort: 'Dom_Lun_Mar_Mié_Jue_Vie_Sáb'.split('_')
});

const localizer = momentLocalizer(moment);


const EventComponent = ({ event, usuarioLogueado, handleDeleteClass }) => {
  return (
    <div className="rbc-event-content">
      <div className="d-flex justify-content-between">
        <strong>{event.title.split('\n')[0]}</strong>
        {usuarioLogueado.tipo === 1 && (
          <button 
            className="btn btn-sm btn-danger ms-2"
            onClick={(e) => {
              e.stopPropagation();
              handleDeleteClass(event.id);
            }}
          >
            ×
          </button>
        )}
      </div>
      <div className="event-details">
        {event.title.split('\n').slice(1).map((line, i) => (
          <div key={i} className="event-detail-line">{line}</div>
        ))}
      </div>
    </div>
  );
};

// tool bar de calendario
const CustomToolbar = (toolbar) => {
  const goToToday = () => toolbar.onNavigate('TODAY');
  const changeView = (view) => toolbar.onView(view);
  const navigate = (action) => toolbar.onNavigate(action);

  return (
    <div className="rbc-toolbar">
      <div className="rbc-btn-group">
        <button type="button" onClick={() => navigate('PREV')} className="btn-calendar-nav">
          &lt; Anterior
        </button>
        <button type="button" onClick={goToToday} className="btn-calendar-today">
          Hoy
        </button>
        <button type="button" onClick={() => navigate('NEXT')} className="btn-calendar-nav">
          Siguiente &gt;
        </button>
      </div>
      
      <div className="rbc-toolbar-label">
        <h4>{toolbar.label}</h4>
      </div>
      
      <div className="rbc-btn-group">
        {['month', 'week', 'day'].map((view) => (
          <button 
            key={view}
            type="button" 
            className={`btn-calendar-view ${toolbar.view === view ? 'active' : ''}`}
            onClick={() => changeView(view)}
          >
            {view === 'month' && 'Mes'}
            {view === 'week' && 'Semana'}
            {view === 'day' && 'Día'}
          </button>
        ))}
      </div>
    </div>
  );
};

function GestionClases({ usuarioLogueado, setVista, setUsuarioLogueado }) {
  const [clases, setClases] = useState([]);
  const [catalogoClases, setCatalogoClases] = useState([]);
  const [coaches, setCoaches] = useState([]);
  const [salones, setSalones] = useState([]);
  const [formData, setFormData] = useState({
    idClase: '',
    idCoach: '',
    fechaHora: '',
    capacidad: '',
    idSalon: '',
  });
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(true);

  // para tener fecha/ hora actual formateada
  const getCurrentDateTime = () => {
    const now = new Date();
    now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
    return now.toISOString().slice(0, 16);
  };

  useEffect(() => {
    if (!usuarioLogueado || (usuarioLogueado.tipo !== 1 && usuarioLogueado.tipo !== 3)) {
      setVista('inicio');
      return;
    }

    const fetchData = async () => {
      try {
        setLoading(true);
        setError('');
        
        const [clasesRes, catalogoRes, coachesRes, salonesRes] = await Promise.all([
          axios.get('http://localhost:3000/clases/disponibles'),
          axios.get('http://localhost:3000/catalogo-clases'),
          axios.get('http://localhost:3000/coaches'),
          axios.get('http://localhost:3000/salones')
        ]);

        const eventos = clasesRes.data.map((clase) => ({
          id: clase.IdClaseProgramada,
          title: `${clase.NombreClase}\nCoach: ${clase.NombreCoach}\nSalón: ${clase.NombreSalon}\nCapacidad: ${clase.Capacidad}`,
          start: new Date(clase.FechaHora),
          end: new Date(new Date(clase.FechaHora).getTime() + 60 * 60 * 1000),
          allDay: false,
          capacidad: clase.Capacidad,
          salon: clase.NombreSalon,
          coach: clase.NombreCoach,
          idCoach: clase.IdCoach 
        }));
        
        setClases(eventos);
        setCatalogoClases(catalogoRes.data);
        setCoaches(coachesRes.data);
        setSalones(salonesRes.data);
      } catch (err) {
        setError('Error al cargar datos: ' + (err.response?.data?.error || err.message));
        console.error("Error detallado:", err);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, [usuarioLogueado, setVista]);

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');

    // validar de campos obligatorios
    if (!formData.idClase || !formData.idCoach || !formData.fechaHora || !formData.capacidad || !formData.idSalon) {
      setError('Todos los campos son obligatorios');
      return;
    }

    // valdiar de fecha /hora
    const fechaSeleccionada = new Date(formData.fechaHora);
    const ahora = new Date();
    if (fechaSeleccionada <= ahora) {
      setError('No puedes programar clases en horarios pasados');
      return;
    }

    try {
      const response = await axios.post('http://localhost:3000/clases', {
        idClase: parseInt(formData.idClase),
        idCoach: parseInt(formData.idCoach),
        fechaHora: formData.fechaHora.replace('T', ' ') + ':00',
        capacidad: parseInt(formData.capacidad),
        idSalon: parseInt(formData.idSalon),
      });

      const claseSeleccionada = catalogoClases.find((c) => c.IdClase === parseInt(formData.idClase));
      const coachSeleccionado = coaches.find((c) => c.IdCoach === parseInt(formData.idCoach));
      const salonSeleccionado = salones.find((s) => s.IdSalon === parseInt(formData.idSalon));

      const nuevaClase = {
        id: response.data.idClaseProgramada,
        title: `${claseSeleccionada.NombreClase}\nCoach: ${coachSeleccionado.NombreCoach}\nSalón: ${salonSeleccionado.NombreSalon}\nCapacidad: ${formData.capacidad}`,
        start: new Date(formData.fechaHora),
        end: new Date(new Date(formData.fechaHora).getTime() + 60 * 60 * 1000),
        allDay: false,
        capacidad: formData.capacidad,
        salon: salonSeleccionado.NombreSalon,
        coach: coachSeleccionado.NombreCoach,
        idCoach: coachSeleccionado.IdCoach
      };

      setClases([...clases, nuevaClase]);
      setFormData({
        idClase: '',
        idCoach: '',
        fechaHora: '',
        capacidad: '',
        idSalon: '',
      });
      alert('Clase creada correctamente');
    } catch (error) {
      setError(error.response?.data?.error || 'Error al crear clase');
    }
  };

  const handleDeleteClass = async (claseId) => {
    if (!window.confirm('¿Estás seguro de eliminar esta clase?')) return;

    try {
      await axios.delete(`http://localhost:3000/clases/${claseId}`);
      setClases(clases.filter(c => c.id !== claseId));
      alert('Clase eliminada correctamente');
    } catch (error) {
      setError(error.response?.data?.error || 'Error al eliminar clase');
    }
  };

  if (loading) {
    return (
      <div className="d-flex flex-column min-vh-100">
        <Header setVista={setVista} usuarioLogueado={usuarioLogueado} />
        <main className="flex-grow-1 d-flex justify-content-center align-items-center">
          <div className="spinner-border text-allegra" role="status">
            <span className="visually-hidden">Cargando...</span>
          </div>
        </main>
        <Footer />
      </div>
    );
  }

  return (
    <div className="d-flex flex-column min-vh-100 gestion-clases-container">
      <Header setVista={setVista} usuarioLogueado={usuarioLogueado} />
      <main className="flex-grow-1">
        <div className="container py-5">
          <h1 className="text-center mb-4 titulo-principal">Gestión de Clases</h1>
          <p className="text-center subtitulo">Bienvenido, {usuarioLogueado?.nombre || 'Usuario'}!</p>
          
          {error && <div className="alert alert-danger">{error}</div>}

          <div className="card mb-4 shadow-sm form-container">
            <div className="card-header bg-allegra text-white">
              <h3 className="mb-0">Programar Nueva Clase</h3>
            </div>
            <div className="card-body">
              <form onSubmit={handleSubmit}>
                <div className="row g-3">
                  <div className="col-md-6">
                    <label htmlFor="idClase" className="form-label">
                      Clase
                    </label>
                    <select
                      className="form-control select-custom"
                      id="idClase"
                      name="idClase"
                      value={formData.idClase}
                      onChange={handleChange}
                      required
                    >
                      <option value="">Seleccione una clase</option>
                      {catalogoClases.map((clase) => (
                        <option key={clase.IdClase} value={clase.IdClase}>
                          {clase.NombreClase}
                        </option>
                      ))}
                    </select>
                  </div>
                  <div className="col-md-6">
                    <label htmlFor="idCoach" className="form-label">
                      Coach
                    </label>
                    <select
                      className="form-control select-custom"
                      id="idCoach"
                      name="idCoach"
                      value={formData.idCoach}
                      onChange={handleChange}
                      required
                    >
                      <option value="">Seleccione un coach</option>
                      {coaches.map((coach) => (
                        <option key={coach.IdCoach} value={coach.IdCoach}>
                          {coach.NombreCoach} {coach.ApellidoPaterno}
                        </option>
                      ))}
                    </select>
                  </div>
                  <div className="col-md-6">
                    <label htmlFor="fechaHora" className="form-label">
                      Fecha y Hora
                    </label>
                    <input
                      type="datetime-local"
                      className="form-control"
                      id="fechaHora"
                      name="fechaHora"
                      value={formData.fechaHora}
                      onChange={handleChange}
                      min={getCurrentDateTime()}
                      required
                    />
                  </div>
                  <div className="col-md-6">
                    <label htmlFor="capacidad" className="form-label">
                      Capacidad
                    </label>
                    <input
                      type="number"
                      className="form-control"
                      id="capacidad"
                      name="capacidad"
                      value={formData.capacidad}
                      onChange={handleChange}
                      required
                      min="1"
                    />
                  </div>
                  <div className="col-md-6">
                    <label htmlFor="idSalon" className="form-label">
                      Salón
                    </label>
                    <select
                      className="form-control select-custom"
                      id="idSalon"
                      name="idSalon"
                      value={formData.idSalon}
                      onChange={handleChange}
                      required
                    >
                      <option value="">Seleccione un salón</option>
                      {salones.map((salon) => (
                        <option key={salon.IdSalon} value={salon.IdSalon}>
                          {salon.NombreSalon}
                        </option>
                      ))}
                    </select>
                  </div>
                  <div className="col-12 text-end">
                    <button className="btn btn-allegra" type="submit">
                      <i className="bi bi-calendar-plus me-2"></i> Programar Clase
                    </button>
                  </div>
                </div>
              </form>
            </div>
          </div>

          <div className="card shadow-sm calendar-container">
            <div className="card-header bg-allegra text-white">
              <h3 className="mb-0">Calendario de Clases</h3>
            </div>
            <div className="card-body">
              <Calendar
                localizer={localizer}
                events={clases}
                startAccessor="start"
                endAccessor="end"
                style={{ height: 700 }}
                views={{
                  month: true,
                  week: true,
                  day: true
                }}
                defaultView="week"
                min={new Date(0, 0, 0, 7, 0, 0)}
                max={new Date(0, 0, 0, 22, 0, 0)}
                step={30}
                timeslots={2}
                components={{
                  event: (props) => (
                    <EventComponent 
                      {...props} 
                      usuarioLogueado={usuarioLogueado}
                      handleDeleteClass={handleDeleteClass}
                    />
                  ),
                  toolbar: CustomToolbar
                }}
                messages={{
                  next: 'Siguiente',
                  previous: 'Anterior',
                  today: 'Hoy',
                  month: 'Mes',
                  week: 'Semana',
                  day: 'Día',
                  noEventsInRange: 'No hay clases programadas en este período.'
                }}
                eventPropGetter={(event) => ({
                  style: {
                    backgroundColor: '#8a4fff',
                    borderColor: '#6a2ccc',
                    color: 'white',
                    borderRadius: '6px',
                    border: 'none',
                    boxShadow: '0 3px 6px rgba(0,0,0,0.16)',
                    padding: '5px',
                    fontSize: '0.85rem',
                  }
                })}
              />
            </div>
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
}

export default GestionClases;
