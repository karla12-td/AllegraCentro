import React from 'react';
import { useEffect } from 'react';
import Header from '../layout/Header.jsx';
import Footer from '../layout/Footer.jsx';
import "../css/Inicio.css";

function Inicio({ setVista }) {
  useEffect(() => {
    // config de  AllegrIA
    window.watsonAssistantChatOptions = {
      integrationID: "d9896988-5c1f-4beb-a777-e2842b63d5bf",
      region: "au-syd",
      serviceInstanceID: "1aed6629-c8e6-45b4-92fb-eeabe5ece830",
      onLoad: async (instance) => { await instance.render(); }
    };
    
    // cargar script de AllegrIA
    const script = document.createElement('script');
    script.src = "https://web-chat.global.assistant.watson.appdomain.cloud/versions/" + 
      (window.watsonAssistantChatOptions.clientVersion || 'latest') + 
      "/WatsonAssistantChatEntry.js";
    script.async = true;
    document.head.appendChild(script);

    return () => {
      document.head.removeChild(script);
    };
  }, []);

  return (
    <div className="d-flex flex-column min-vh-100">
      <Header setVista={setVista} />
      <main className="flex-grow-1">
  
        <section className="fondo hero-section py-5 text-center">
          <div className="row py-lg-5">
            <div className="col-lg-6 col-md-8 mx-auto">
              <h1 className="fw-bold">Allegra</h1>
              <p className="lead text-body-secondary">Movimiento. Fuerza. Equilibrio</p>
            </div>
          </div>
        </section>

        {/* Sobre Nosotros */}
        <section className="sobre-nosotros py-5">
          <div className="container">
            <div className="row align-items-center">
              <div className="col-lg-7 mb-4 mb-lg-0">
                <h2 className="mb-4">Sobre nosotros</h2>
                <p className="lead">
                  Somos un centro de entrenamiento dedicado a ayudarte a alcanzar tus objetivos de salud y bienestar. 
                </p>
                <p>
                  Con un equipo de profesionales y un ambiente motivador, ofrecemos clases diseñadas para todos los niveles.
                  Nuestra misión es inspirar y motivar a las personas a llevar un estilo de vida activo y saludable.
                </p>
                
                <div className="row mt-4">
                  <div className="col-md-6">
                    <h5 className="titulo-morado">Nuestros Valores</h5>
                    <ul className="valores-list">
                      <li>Compromiso con tu transformación</li>
                      <li>Diversión en cada clase</li>
                      <li>Enfoque personalizado</li>
                    </ul>
                  </div>
                  <div className="col-md-6">
                    <h5 className="titulo-morado">¿Por qué elegirnos?</h5>
                    <ul className="valores-list">
                      <li>Entrenadores certificados</li>
                      <li>Variedad de clases</li>
                      <li>Horarios flexibles</li>
                      <li>Instalaciones modernas</li>
                    </ul>
                  </div>
                </div>
              </div>
              
              <div className="col-lg-5">
                <img 
                  src="/images/reformer1.jpg" 
                  alt="Estudio Allegra" 
                  className="img-fluid rounded shadow"
                  style={{ maxHeight: "500px", objectFit: "cover" }}
                />
              </div>
            </div>
          </div>
        </section>

      </main>
    
      <Footer />
    </div>
  );
}

export default Inicio;
