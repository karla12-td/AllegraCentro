import React from 'react';
import { useState } from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import axios from 'axios';
import '../css/Login.css';
import Header from '../layout/Header.jsx';
import Footer from '../layout/Footer.jsx';

function Login({ setVista, setUsuarioLogueado }) {
  const [formData, setFormData] = useState({
    email: '',
    contraseña: '',
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

    const requiredFields = ['email', 'contraseña'];
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

    try {
      console.log('Intentando login con:', formData);
      const response = await axios.post('http://localhost:3000/login', formData);
      const usuario = response.data;
      console.log('Usuario recibido:', usuario);

      if (!usuario || !usuario.tipo) {
        throw new Error('Respuesta del servidor inválida: falta tipo');
      }

      setUsuarioLogueado(usuario);
      console.log('Usuario establecido:', usuario);

      const tipo = parseInt(usuario.tipo, 10);
      console.log('Redirigiendo según tipo:', tipo);

      if (tipo === 1 || tipo === 3) {
        console.log('Redirigiendo a gestion-clases');
        setVista('gestion-clases');
      } else if (tipo === 4) {
        console.log('Redirigiendo a clases');
        setVista('clases');
      } else {
        console.log('Tipo desconocido, redirigiendo a inicio');
        setVista('inicio');
      }

      mostrarNotificacion('¡Inicio de sesión exitoso!', 'success');
    } catch (error) {
      console.error('Error en login:', error.response?.data || error.message);
      mostrarNotificacion(
        error.response?.data?.message || 'Error al iniciar sesión',
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
              <h2>Iniciar Sesión</h2>
              <p>Ingrese sus credenciales para acceder.</p>
            </div>

            <form onSubmit={handleSubmit}>
              <div className="row g-3">
                <div className="col-12">
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
                <div className="col-12">
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
                <div className="col-12">
                  <button className="btn btn-purple w-100" type="submit">
                    Iniciar Sesión
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

export default Login;
