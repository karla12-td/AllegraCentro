import React from 'react';
import { useState } from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import axios from 'axios';
import "../css/Registrarse.css";
import Header from '../layout/Header.jsx';
import Footer from '../layout/Footer.jsx';
import 'bootstrap/dist/js/bootstrap.min.js'

function Registro({ setVista }) {
  const [formData, setFormData] = useState({
    nombre: '',
    appPaterno: '',
    appMaterno: '',
    fecha: '',
    telefono: '',
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

    const requiredFields = ['nombre', 'appPaterno', 'fecha', 'email', 'contraseña'];
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
      const response = await axios.post('http://localhost:3000/registro', formData);
      mostrarNotificacion('Formulario enviado correctamente!', 'success');

      setFormData({
        nombre: '',
        appPaterno: '',
        appMaterno: '',
        fecha: '',
        telefono: '',
        email: '',
        contraseña: '',
      });

      setTimeout(() => {
        setVista('servicios');
      }, 2000);
    } catch (error) {
      mostrarNotificacion('Error al registrar: ' + error.message, 'danger');
    }
  };

  const mostrarNotificacion = (mensaje, tipo) => {
    const notificacion = document.createElement('div');
    notificacion.className = `alert alert-${tipo} fixed-top mt-3`;
    notificacion.style.width = '50%';
    notificacion.style.margin = 'auto';
    notificacion.textContent = mensaje;

    document.body.appendChild(notificacion);

    setTimeout(() => {
      notificacion.remove();
    }, 3000);
  };

  return (
    <div>
      <Header setVista={setVista} />
      <main>
        <div className="formulario">
          <div className="py-5 text-center">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="100px"
              height="80px"
              fill="currentColor"
              className="bi bi-wind"
              viewBox="0 0 16 16"
            >
              <path d="M12.5 2A2.5 2.5 0 0 0 10 4.5a.5.5 0 0 1-1 0A3.5 3.5 0 1 1 12.5 8H.5a.5.5 0 0 1 0-1h12a2.5 2.5 0 0 0 0-5m-7 1a1 1 0 0 0-1 1 .5.5 0 0 1-1 0 2 2 0 1 1 2 2h-5a.5.5 0 0 1 0-1h5a1 1 0 0 0 0-2M0 9.5A.5.5 0 0 1 .5 9h10.042a3 3 0 1 1-3 3 .5.5 0 0 1 1 0 2 2 0 1 0 2-2H.5a.5.5 0 0 1-.5-.5" />
            </svg>
            <h2>Formato de Registro</h2>
            <p className="lead">Ingrese los datos solicitados para su registro.</p>
          </div>

          <div className="row g-5">
            <div className="col-md-7 col-lg-8">
              <form className="needs-validation" noValidate onSubmit={handleSubmit}>
                <div className="row g-3">
                  <div className="col-12">
                    <label htmlFor="nombre" className="form-label">
                      Nombre(s)
                    </label>
                    <input
                      type="text"
                      className={`form-control ${errors.nombre ? 'is-invalid' : ''}`}
                      id="nombre"
                      name="nombre"
                      placeholder="Nombre(s)"
                      value={formData.nombre}
                      onChange={handleChange}
                      required
                    />
                    <div className="invalid-feedback">{errors.nombre}</div>
                  </div>

                  <div className="col-12">
                    <label htmlFor="appPaterno" className="form-label">
                      Apellido Paterno
                    </label>
                    <input
                      type="text"
                      className={`form-control ${errors.appPaterno ? 'is-invalid' : ''}`}
                      id="appPaterno"
                      name="appPaterno"
                      placeholder="Apellido Paterno"
                      value={formData.appPaterno}
                      onChange={handleChange}
                      required
                    />
                    <div className="invalid-feedback">{errors.appPaterno}</div>
                  </div>

                  <div className="col-12">
                    <label htmlFor="appMaterno" className="form-label">
                      Apellido Materno
                    </label>
                    <input
                      type="text"
                      className="form-control"
                      id="appMaterno"
                      name="appMaterno"
                      placeholder="Apellido Materno"
                      value={formData.appMaterno}
                      onChange={handleChange}
                    />
                  </div>

                  <div className="col-12">
                    <label htmlFor="fecha" className="form-label">
                      Fecha de nacimiento
                    </label>
                    <input
                      type="date"
                      className={`form-control ${errors.fecha ? 'is-invalid' : ''}`}
                      id="fecha"
                      name="fecha"
                      value={formData.fecha}
                      onChange={handleChange}
                      required
                    />
                    <div className="invalid-feedback">{errors.fecha}</div>
                  </div>

                  <div className="col-12">
                    <label htmlFor="telefono" className="form-label">
                      Teléfono
                    </label>
                    <input
                      type="number"
                      className="form-control"
                      id="telefono"
                      name="telefono"
                      placeholder="998 123 45 67"
                      value={formData.telefono}
                      onChange={handleChange}
                    />
                  </div>

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
                      placeholder="Mínimo 8 caracteres"
                      value={formData.contraseña}
                      onChange={handleChange}
                      required
                    />
                    <div className="invalid-feedback">{errors.contraseña}</div>
                  </div>
                </div>

                <hr className="my-4" />

                <button className="w-100 btn btn-purple btn-lg" type="submit">
                  Crear cuenta
                </button>
              </form>
            </div>
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
}

export default Registro;
