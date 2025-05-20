import React from 'react';

import { useState } from 'react';
import './css/App.css';
import Registro from './pages/Registro';
import Inicio from './pages/Inicio';
import Servicios from './pages/Servicios';
import Contacto from './pages/Contacto';
import Login from './pages/Login';
import Clases from './pages/Clases';
import RegistroAdminCoach from './pages/RegistroAdminCoach';
import GestionClases from './pages/GestionClases';
import Pago from './pages/Pago'; // Asegúrate de crear este componente

function App() {
  const [vista, setVista] = useState('inicio');
  const [usuarioLogueado, setUsuarioLogueado] = useState(null);
  const [paqueteSeleccionado, setPaqueteSeleccionado] = useState(null);

  console.log('Vista actual:', vista, 'Usuario logueado:', usuarioLogueado);

  return (
    <div>
      {vista === 'registro' && <Registro setVista={setVista} />}
      {vista === 'inicio' && <Inicio setVista={setVista} />}
      {vista === 'servicios' && (
        <Servicios 
          setVista={setVista} 
          setPaqueteSeleccionado={setPaqueteSeleccionado} 
        />
      )}
      {vista === 'contacto' && <Contacto setVista={setVista} />}
      {vista === 'login' && (
        <Login setVista={setVista} setUsuarioLogueado={setUsuarioLogueado} />
      )}
      {vista === 'clases' && (
        <Clases
          usuarioLogueado={usuarioLogueado}
          setVista={setVista}
          setUsuarioLogueado={setUsuarioLogueado}
        />
      )}
      {vista === 'registro-admin-coach' && (
        <RegistroAdminCoach setVista={setVista} />
      )}
      {vista === 'gestion-clases' && (
        <GestionClases
          usuarioLogueado={usuarioLogueado}
          setVista={setVista}
          setUsuarioLogueado={setUsuarioLogueado}
        />
      )}
      {vista === 'pago' && (
        <Pago 
          setVista={setVista} 
          paquete={paqueteSeleccionado} 
        />
      )}
    </div>
  );
}

export default App;
