import React from 'react';
import Header from '../layout/Header.jsx';
import Footer from '../layout/Footer.jsx';
import "../css/Servicios.css";

function Servicios({ setVista, setPaqueteSeleccionado }) {
  const clases = [
    {
      img: "reformer3.jpg",
      title: "Pilates Reformer",
      text: "Fortalece tu núcleo y mejora tu postura, con la ayuda de una máquina especializada."
    },
    {
      img: "yoga.jpg",
      title: "Yoga",
      text: "Conéctate contigo mismo a través de posturas, respiración y meditación. Encuentra equilibrio y bienestar en nuestros diversos estilos."
    },
    {
      img: "mat1.jpg",
      title: "Pilates Mat",
      text: "Entrena con tu propio peso corporal en colchonetas. Mejora el control, la alineación y la flexibilidad en cada sesión."
    },
    {
      img: "spring1.jpg",
      title: "Pilates Springboard",
      text: "Desafía tu cuerpo, con una tabla y resortes. Trabaja fuerza y estabilidad a través de ejercicios dinámicos y variados."
    },
    {
      img: "barre.jpg",
      title: "Barre",
      text: "Tonifica y fortalece con movimientos inspirados en el ballet. Utiliza barras para mejorar tu postura y flexibilidad mientras te diviertes."
    },
    {
      img: "Bici2.jpg",
      title: "Spinning",
      text: "Siente la energía del ciclismo en interiores. Mejora tu condición cardiovascular y tonifica tus piernas con música motivadora y un instructor que te guía."
    }
  ];

  const handleComprar = (paquete) => {
    setPaqueteSeleccionado(paquete);
    setVista('pago');
  };

  return (
    <div className="d-flex flex-column min-vh-100">
      <Header setVista={setVista} />

      <main className="flex-grow-1">
        <section className="fondo hero-section py-5 text-center">
          <div className="row py-lg-5">
            <div className="col-lg-6 col-md-8 mx-auto">
              <h1 className="fw-bold">Servicios</h1>
              <p className="lead text-body-secondary">Movimiento. Fuerza. Equilibrio</p>

            </div>
          </div>
        </section>

        {/* Clases Section */}
        <section className="clases-section py-5">
          <div className="container">
            <h2 className="text-center mb-4">Clases</h2>
            <p className="text-center mb-5">
              Explora nuestra variedad de clases diseñadas para todos los niveles. Desde entrenamientos de alta intensidad hasta sesiones de relajación, ¡encuentra la que mejor se adapte a ti
            </p>

            <div className="clases-grid">
              {clases.map((clase, index) => (
                <div key={index} className="clase-card">
                  <div className="card-image">
                    <img src={`/images/${clase.img}`} alt={clase.title} />
                  </div>
                  <div className="card-content">
                    <h3>{clase.title}</h3>
                    <p>{clase.text}</p>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>




        {/* SALONES */}
        <section className="aesthetic-salones">
          <div className="container">
            <div className="salon-header">
              <h2>Nuestros Espacios</h2>
              <p>Cada salón ha sido diseñado meticulosamente para crear la atmósfera perfecta para tu práctica.</p>
            </div>

            {/* Salón Flex */}
            <div className="salon-card">
              <div className="salon-image">
                <img src="images/reformer2.jpg" alt="Salón Flex" />
              </div>
              <div className="salon-content">
                <span className="salon-number">01</span>
                <h3>Salón Flex</h3>
                <span className="salon-capacity">CAPACIDAD: 12 PERSONAS</span>
                <p>
                  Un santuario para la práctica de pilates donde la luz natural y los detalles minimalistas
                  crean un ambiente sereno. Diseñado para cultivar la flexibilidad y el control corporal
                  a través de movimientos precisos.
                </p>
              </div>
            </div>

            <div className="salon-divider"></div>

            {/* Barre Flow */}
            <div className="salon-card reverse">
              <div className="salon-image">
                <img src="images/mat1.jpg" alt="Barre Flow" />
              </div>
              <div className="salon-content">
                <span className="salon-number">02</span>
                <h3>Barre Flow</h3>
                <span className="salon-capacity">CAPACIDAD: 20 PERSONAS</span>
                <p>
                  Espacio luminoso con espejos estratégicamente colocados para perfeccionar la postura.
                  La combinación de elementos de ballet y yoga crea una experiencia fluida que tonifica
                  mientras promueve la gracia en el movimiento.
                </p>
              </div>
            </div>

            <div className="salon-divider"></div>

            {/* Cycle Beat */}
            <div className="salon-card">
              <div className="salon-image">
                <img src="images/Bici.jpg" alt="Cycle Beat" />
              </div>
              <div className="salon-content">
                <span className="salon-number">03</span>
                <h3>Cycle Beat</h3>
                <span className="salon-capacity">CAPACIDAD: 30 PERSONAS</span>
                <p>
                  Ambiente energético con iluminación adaptable y sistema de sonido envolvente.
                  Diseñado para sincronizar movimiento y música, transformando cada sesión en
                  una experiencia cardiovascular estimulante.
                </p>
              </div>
            </div>
          </div>
        </section>





        {/* Precios Section */}
        <section className="precios-section">
          <div className="container">
            <h2>Paquetes de Clases</h2>
            <p className="subtitle">¡Invierte en tu bienestar!</p>

            <div className="paquetes-fila">
              {/* Clase suelta */}
              <div className="paquete-card destacado">
                <div className="cabecera-destacada">Clase suelta</div>
                <p className="precio">$230<span>/mxn</span></p>
                <ul>
                  <li>Válido en todas las clases</li>
                  <li>Vigencia: 15 días</li>
                </ul>
                <button
                  className="btn-comprar destacado"
                  onClick={() => handleComprar({
                    nombre: "Clase suelta",
                    precio: 150,
                    detalles: ["Válido en todas las clases", "Vigencia: 15 días"]
                  })}
                >
                  Comprar
                </button>
              </div>

              {/* 8 clases */}
              <div className="paquete-card destacado">
                <div className="cabecera-destacada">8 clases</div>
                <p className="precio">$1,080<span>/mxn</span></p>
                <ul>
                  <li>Válido en todas las clases</li>
                  <li>Vigencia: 45 días</li>
                </ul>
                <button
                  className="btn-comprar destacado"
                  onClick={() => handleComprar({
                    nombre: "8 clases",
                    precio: 1080,
                    detalles: ["Válido en todas las clases", "Vigencia: 45 días"]
                  })}
                >
                  Comprar
                </button>
              </div>

              {/* 12 clases */}
              <div className="paquete-card destacado">
                <div className="cabecera-destacada">12 clases</div>
                <p className="precio">$1,620<span>/mxn</span></p>
                <ul>
                  <li>Válido en todas las clases</li>
                  <li>Vigencia: 45 días</li>
                </ul>
                <button
                  className="btn-comprar destacado"
                  onClick={() => handleComprar({
                    nombre: "12 clases",
                    precio: 1620,
                    detalles: ["Válido en todas las clases", "Vigencia: 45 días"]
                  })}
                >
                  Comprar
                </button>
              </div>
            </div>

            <div className="paquetes-fila">
              {/* 1 mes */}
              <div className="paquete-card destacado">
                <div className="cabecera-destacada">1 mes</div>
                <div className="contenido-paquete">
                  <p className="precio">$3,000<span>/mxn</span></p>
                  <ul>
                    <li>Válido en todas las clases</li>
                    <li>Máximo 2 clases por día</li>
                    <li>Vigencia: 30 días</li>
                  </ul>
                  <button
                    className="btn-comprar destacado"
                    onClick={() => handleComprar({
                      nombre: "1 mes",
                      precio: 3000,
                      detalles: [
                        "Válido en todas las clases",
                        "Máximo 2 clases por día",
                        "Vigencia: 30 días"
                      ]
                    })}
                  >
                    Comprar
                  </button>
                </div>
              </div>

              {/* 6 meses */}
              <div className="paquete-card destacado">
                <div className="cabecera-destacada">6 meses</div>
                <div className="contenido-paquete">
                  <p className="precio">$18,000<span>/mxn</span></p>
                  <ul>
                    <li>Válido en todas las clases</li>
                    <li>Máximo 2 clases por día</li>
                    <li>Vigencia: 180 días</li>
                  </ul>
                  <button
                    className="btn-comprar destacado"
                    onClick={() => handleComprar({
                      nombre: "6 meses",
                      precio: 18000,
                      detalles: [
                        "Válido en todas las clases",
                        "Máximo 2 clases por día",
                        "Vigencia: 180 días"
                      ]
                    })}
                  >
                    Comprar
                  </button>
                </div>
              </div>

              {/* 1 año */}
              <div className="paquete-card destacado">
                <div className="cabecera-destacada">1 año</div>
                <div className="contenido-paquete">
                  <p className="precio">$35,000<span>/mxn</span></p>
                  <ul>
                    <li>Válido en todas las clases</li>
                    <li>Máximo 2 clases por día</li>
                    <li>Vigencia: 365 días</li>
                  </ul>
                  <button
                    className="btn-comprar destacado"
                    onClick={() => handleComprar({
                      nombre: "1 año",
                      precio: 35000,
                      detalles: [
                        "Válido en todas las clases",
                        "Máximo 2 clases por día",
                        "Vigencia: 365 días"
                      ]
                    })}
                  >
                    Comprar
                  </button>
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

export default Servicios;
