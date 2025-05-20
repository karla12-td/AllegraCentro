import React from 'react';
import Header from '../layout/Header.jsx';
import Footer from '../layout/Footer.jsx';
import "../css/Contacto.css";

function Contacto({ setVista }) {
  return (
    <div className="d-flex flex-column min-vh-100">
      <Header setVista={setVista} />
      <section className="fondo hero-section py-5 text-center">
        <div className="row py-lg-5">
          <div className="col-lg-6 col-md-8 mx-auto">
            <h1 className="fw-bold">Contacto</h1>
            <p className="lead text-body-secondary">Estamos aquí para ayudarte.</p>
            
          </div>
        </div>
      </section>
      <main className="flex-grow-1">
        <section className="precios-section">
          <div className="container">
            <div className="paquetes-fila">
              {/* Información  */}
              <div className="info-card destacado">
                <div className="card-content">
                  <div className="cabecera-destacada">Información</div><br/>
                  <div className="info-container">
                    <div className="info-item">
                      <i className="bi bi-geo-alt-fill text-purple"></i>
                      <div>
                        <h4>Dirección</h4>
                        <p>Calle Allegra 189, Sm 45 Mz. 89 Lt. 3, Cancún<br />contacto@allegra.com</p>
                      </div>
                    </div>
                    
                    <div className="info-item">
                      <i className="bi bi-clock-fill text-purple"></i>
                      <div>
                        <h4>Horario</h4>
                        <p>Lunes a Viernes: 7:00 - 21:00 hrs</p>
                      </div>
                    </div>

                    <div className="info-item">
                      <i className="bi bi-telephone-fill text-purple"></i>
                      <div>
                        <h4>Teléfono</h4>
                        <p>+52 998 1234 5678</p>
                      </div>
                    </div>

                    <div className="mapa-container">
                      <iframe
                        title="Ubicación del estudio"
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3762.888244477083!2d-99.1698386845336!3d19.42702074620239!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x85d1ff35f5bd1563%3A0x6c366f0e2de02ff7!2sEl%20%C3%81ngel%2C%20Centro%2C%2006000%20Ciudad%20de%20M%C3%A9xico%2C%20CDMX!5e0!3m2!1ses-419!2smx!4v1620000000000!5m2!1ses-419!2smx"
                        width="100%"
                        height="200"
                        style={{ border: 0 }}
                        allowFullScreen
                        loading="lazy">
                      </iframe>
                    </div>
                  </div>
                </div>
              </div>

              {/* Formulario contacto  */}
              <div className="info-card destacado">
                <div className="card-content">
                  <div className="cabecera-destacada">Escríbenos</div>
                  <form className="form-container">
                    <div className="row g-3">
                      <div className="col-12">
                        <label htmlFor="nombre" className="form-label">Nombre</label>
                        <input type="text" className="form-control" id="nombre" required />
                      </div>
                      <div className="col-12">
                        <label htmlFor="email" className="form-label">Email</label>
                        <input type="email" className="form-control" id="email" required />
                      </div>
                      <div className="col-12">
                        <label htmlFor="asunto" className="form-label">Asunto</label>
                        <input type="text" className="form-control" id="asunto" required />
                      </div>
                      <div className="col-12">
                        <label htmlFor="mensaje" className="form-label">Mensaje</label>
                        <textarea className="form-control" id="mensaje" rows="5" required></textarea>
                      </div>
                      <div className="col-12 mt-3">
                        <button type="submit" className="btn btn-purple w-100 py-2">
                          <i className="bi me-2"></i> Enviar Mensaje
                        </button>
                      </div>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </section>
      </main>
      <Footer />
    </div>
  );
}

export default Contacto;
