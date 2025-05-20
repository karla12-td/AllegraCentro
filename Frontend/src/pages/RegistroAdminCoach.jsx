import React from 'react';
import { useState } from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import axios from 'axios';
import '../css/Login.css';
import Header from '../layout/Header.jsx';
import Footer from '../layout/Footer.jsx';

function RegistroAdminCoach({ setVista }) {
  const [formData, setFormData] = useState({
    nombre: '',
    appPaterno: '',
    appMaterno: '',
    fecha: '',
    telefono: '',
    email: '',
    contraseña: '',
    tipo: '1',
  });

  const [errors, setErrors] = useState({});

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
    if (errors[e.target.name]) {
      setErrors({ ...errors, [e.target.name]: '' });
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    const requiredFields = ['nombre', 'appPaterno', 'email', 'contraseña', 'tipo'];
    const newErrors = {};
    requiredFields.forEach((field) => {
      if (!formData[field].trim()) {
        newErrors[field] = 'Campo Obligatorio';
      }
    });

    if (Object.keys(newErrors).length > 0) {
      setErrors(newErrors);
      return;
    }

    const payload = {
      ...formData,
      tipo: parseInt(formData.tipo, 10), 
    };

    console.log('Enviando datos:', payload); 

    try {
      const response = await axios.post('http://localhost:3000/registro-admin-coach', payload);
      mostrarNotificacion('¡Registro exitoso!', 'success');
      setFormData({
        nombre: '',
        appPaterno: '',
        appMaterno: '',
        fecha: '',
        telefono: '',
        email: '',
        contraseña: '',
        tipo: '1',
      });
      setTimeout(() => {
        setVista('login');
      }, 2000);
    } catch (error) {
      console.error('Error en registro:', error.response?.data); 
      mostrarNotificacion(
        error.response?.data?.error || 'Error al registrar',
        'error'
      );
    }
  };

  const mostrarNotificacion = (mensaje, tipo) => {
    const notificacion = document.createElement('div');
    notificacion.className = `notificacion ${tipo}`;
    notificacion.textContent = mensaje;
    document.body.appendChild(notificacion);
    setTimeout(() => {
      notificacion.remove();
    }, 3000);
  };

  return (
    <div className="d-flex flex-column min-vh-100">
      <Header setVista={setVista} />
      <main className="flex-grow-1">
        <div className="container py-5">
          <div className="formulario mx-auto">
            <div className="text-center mb-4">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="100px"
                height="80px"
                fill="currentColor"
                className="bi bi-person-circle"
                viewBox="0 0 16 16"
              >
                <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z" />
                <path
                  fillRule="evenodd"
                  d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"
                />
              </svg>
              <h2>Registro de Admin/Coach</h2>
              <p>Complete el formulario para registrarse.</p>
            </div>

            <form onSubmit={handleSubmit}>
              <div className="row g-3">
                <div className="col-md-6">
                  <label htmlFor="nombre" className="form-label">
                    Nombre
                  </label>
                  <input
                    type="text"
                    className={`form-control ${errors.nombre ? 'is-invalid' : ''}`}
                    id="nombre"
                    name="nombre"
                    value={formData.nombre}
                    onChange={handleChange}
                    required
                  />
                  <div className="invalid-feedback">{errors.nombre}</div>
                </div>
                <div className="col-md-6">
                  <label htmlFor="appPaterno" className="form-label">
                    Apellido Paterno
                  </label>
                  <input
                    type="text"
                    className={`form-control ${errors.appPaterno ? 'is-invalid' : ''}`}
                    id="appPaterno"
                    name="appPaterno"
                    value={formData.appPaterno}
                    onChange={handleChange}
                    required
                  />
                  <div className="invalid-feedback">{errors.appPaterno}</div>
                </div>
                <div className="col-md-6">
                  <label htmlFor="appMaterno" className="form-label">
                    Apellido Materno
                  </label>
                  <input
                    type="text"
                    className="form-control"
                    id="appMaterno"
                    name="appMaterno"
                    value={formData.appMaterno}
                    onChange={handleChange}
                  />
                </div>
                <div className="col-md-6">
                  <label htmlFor="fecha" className="form-label">
                    Fecha de Nacimiento
                  </label>
                  <input
                    type="date"
                    className="form-control"
                    id="fecha"
                    name="fecha"
                    value={formData.fecha}
                    onChange={handleChange}
                  />
                </div>
                <div className="col-md-6">
                  <label htmlFor="telefono" className="form-label">
                    Teléfono
                  </label>
                  <input
                    type="text"
                    className="form-control"
                    id="telefono"
                    name="telefono"
                    value={formData.telefono}
                    onChange={handleChange}
                  />
                </div>
                <div className="col-md-6">
                  <label htmlFor="email" className="form-label">
                    E-mail
                  </label>
                  <input
                    type="email"
                    className={`form-control ${errors.email ? 'is-invalid' : ''}`}
                    id="email"
                    name="email"
                    placeholder="you@example.com"
                    value={formData.email}
                    onChange={handleChange}
                    required
                  />
                  <div className="invalid-feedback">{errors.email}</div>
                </div>
                <div className="col-md-6">
                  <label htmlFor="contraseña" className="form-label">
                    Contraseña
                  </label>
                  <input
                    type="password"
                    className={`form-control ${errors.contraseña ? 'is-invalid' : ''}`}
                    id="contraseña"
                    name="contraseña"
                    value={formData.contraseña}
                    onChange={handleChange}
                    required
                  />
                  <div className="invalid-feedback">{errors.contraseña}</div>
                </div>
                <div className="col-md-6">
                  <label htmlFor="tipo" className="form-label">
                    Tipo
                  </label>
                  <select
                    className={`form-control ${errors.tipo ? 'is-invalid' : ''}`}
                    id="tipo"
                    name="tipo"
                    value={formData.tipo}
                    onChange={handleChange}
                    required
                  >
                    <option value="1">Administrador</option>
                    <option value="3">Coach</option>
                  </select>
                  <div className="invalid-feedback">{errors.tipo}</div>
                </div>
                <div className="col-12">
                  <button className="btn btn-purple w-100" type="submit">
                    Registrarse
                  </button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
}

export default RegistroAdminCoach;
