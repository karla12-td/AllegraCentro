import React from 'react';
import Header from '../layout/Header.jsx';
import Footer from '../layout/Footer.jsx';
import "../css/Pago.css";

function Pago({ setVista, paquete }) {
  const [datosPago, setDatosPago] = React.useState({
    nombre: '',
    tarjeta: '',
    vencimiento: '',
    cvv: '',
    email: '',
    telefono: ''
  });
  const [pagoExitoso, setPagoExitoso] = React.useState(false);
  const [isLoading, setIsLoading] = React.useState(false);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setDatosPago(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    setIsLoading(true);
    
    // simulacion de  procesamiento de pago
    setTimeout(() => {
      setIsLoading(false);
      setPagoExitoso(true);
    }, 2000);
  };

  if (pagoExitoso) {
    return (
      <div className="d-flex flex-column min-vh-100">
        <Header setVista={setVista} />
        <main className="flex-grow-1 d-flex align-items-center justify-content-center">
          <div className="text-center p-5 bg-light rounded-3 confirmation-box">
            <div className="mb-4">
              <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="#28a745" viewBox="0 0 16 16">
                <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
              </svg>
            </div>
            <h1 className="text-success mb-4">¡Pago Exitoso!</h1>
            <div className="receipt-details">
              <h3 className="mb-3">Resumen de tu compra</h3>
              <p><strong>Paquete:</strong> {paquete.nombre}</p>
              <p><strong>Monto:</strong> ${paquete.precio.toLocaleString()} MXN</p>
              <p><strong>Beneficios:</strong></p>
              <ul className="benefits-list">
                {paquete.detalles.map((detalle, index) => (
                  <li key={index}>{detalle}</li>
                ))}
              </ul>
              <p className="mt-3">Hemos enviado los detalles a tu correo: <strong>{datosPago.email}</strong></p>
            </div>
            <button 
              onClick={() => setVista('servicios')}
              className="btn btn-primary mt-4 btn-back"
            >
              Volver a Servicios
            </button>
          </div>
        </main>
        <Footer />
      </div>
    );
  }

  return (
    <div className="d-flex flex-column min-vh-100">
      <Header setVista={setVista} />
      <main className="flex-grow-1">
        <section className="container my-5">
          <div className="row justify-content-center">
            <div className="col-lg-8">
              <div className="card shadow payment-card">
                <div className="card-header bg-primary text-white">
                  <div className="d-flex justify-content-between align-items-center">
                    <div>
                      <h2 className="mb-0">Proceso de Pago</h2>
                      <h4 className="mt-2">{paquete.nombre} - ${paquete.precio.toLocaleString()} MXN</h4>
                    </div>
                    <div className="package-badge">
                      {paquete.nombre.includes('mes') || paquete.nombre.includes('año') ? 'PLAN' : 'PAQUETE'}
                    </div>
                  </div>
                </div>
                
                <div className="card-body p-4">
                  <form onSubmit={handleSubmit}>
                    <div className="row">
                      <div className="col-md-6">
                        <h4 className="mb-4">Información Personal</h4>
                        
                        <div className="mb-3">
                          <label htmlFor="nombre" className="form-label">Nombre completo</label>
                          <input
                            type="text"
                            className="form-control"
                            id="nombre"
                            name="nombre"
                            value={datosPago.nombre}
                            onChange={handleChange}
                            required
                          />
                        </div>
                        
                        <div className="mb-3">
                          <label htmlFor="email" className="form-label">Correo electrónico</label>
                          <input
                            type="email"
                            className="form-control"
                            id="email"
                            name="email"
                            value={datosPago.email}
                            onChange={handleChange}
                            required
                          />
                        </div>
                        
                        <div className="mb-3">
                          <label htmlFor="telefono" className="form-label">Teléfono</label>
                          <input
                            type="tel"
                            className="form-control"
                            id="telefono"
                            name="telefono"
                            value={datosPago.telefono}
                            onChange={handleChange}
                            required
                          />
                        </div>
                      </div>
                      
                      <div className="col-md-6">
                        <h4 className="mb-4">Información de Pago</h4>
                        
                        <div className="mb-3">
                          <label htmlFor="tarjeta" className="form-label">Número de tarjeta</label>
                          <input
                            type="text"
                            className="form-control"
                            id="tarjeta"
                            name="tarjeta"
                            value={datosPago.tarjeta}
                            onChange={handleChange}
                            placeholder="1234 5678 9012 3456"
                            maxLength="16"
                            required
                          />
                        </div>
                        
                        <div className="row mb-3">
                          <div className="col-md-6">
                            <label htmlFor="vencimiento" className="form-label">Fecha de vencimiento</label>
                            <input
                              type="text"
                              className="form-control"
                              id="vencimiento"
                              name="vencimiento"
                              value={datosPago.vencimiento}
                              onChange={handleChange}
                              placeholder="MM/AA"
                              maxLength="5"
                              required
                            />
                          </div>
                          <div className="col-md-6">
                            <label htmlFor="cvv" className="form-label">CVV</label>
                            <input
                              type="text"
                              className="form-control"
                              id="cvv"
                              name="cvv"
                              value={datosPago.cvv}
                              onChange={handleChange}
                              placeholder="123"
                              maxLength="3"
                              required
                            />
                          </div>
                        </div>
                    
                      </div>
                    </div>
                    
                    <div className="package-summary p-3 mb-4">
                      <h5>Resumen del paquete</h5>
                      <div className="d-flex justify-content-between">
                        <span>{paquete.nombre}</span>
                        <span>${paquete.precio.toLocaleString()} MXN</span>
                      </div>
                      <hr />
                      <div className="d-flex justify-content-between total-amount">
                        <span>Total a pagar:</span>
                        <span>${paquete.precio.toLocaleString()} MXN</span>
                      </div>
                    </div>
                    
                    <div className="d-grid">
                      <button 
                        type="submit" 
                        className="btn btn-primary btn-lg btn-pay"
                        disabled={isLoading}
                      >
                        {isLoading ? (
                          <>
                            <span className="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>
                            Procesando...
                          </>
                        ) : (
                          `Pagar ahora $${paquete.precio.toLocaleString()} MXN`
                        )}
                      </button>
                    </div>
                    
                    <div className="mt-3 text-center">
                      <small className="text-muted">Tu información está protegida con encriptación SSL</small>
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

export default Pago;