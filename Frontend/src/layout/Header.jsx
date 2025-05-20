import React from 'react';
import '../css/Header.css';

function Header({ setVista }) {
  return (
    <header className="py-3 mb-4 border-bottom">
      <div className="container d-flex justify-content-between align-items-center">
        <div></div>
        <nav className="nav">
          <a href="#" className="nav-link" onClick={() => setVista('inicio')}>
            Inicio
          </a>
          <a href="#" className="nav-link" onClick={() => setVista('servicios')}>
            Servicios
          </a>
          <a href="#" className="nav-link" onClick={() => setVista('contacto')}>
            Contacto
          </a>
        </nav>
        <div>
          <button
            className="btn btn-outline-primary me-2"
            onClick={() => setVista('login')}
          >
            Iniciar Sesión
          </button>
          <button
            className="btn btn-outline-primary me-2"
            onClick={() => setVista('registro')}
          >
            Registro Cliente
          </button>
          <button
            className="btn btn-outline-primary"
            onClick={() => setVista('registro-admin-coach')}
          >
            Registro Admin/Coach
          </button>
        </div>
      </div>
    </header>
  );
}

export default Header;
