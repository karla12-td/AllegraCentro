const express = require('express');
const swaggerJsDocs = require("swagger-jsdoc");
const swaggerUI = require("swagger-ui-express");
const app = express();
const port = 3000;
const mysql = require("mysql2");

const cors = require('cors');
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// definicion de la conexión a MySQL
const bd = mysql.createConnection({
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: '',
    database: 'CentroEjercicio',
});

// Conectar a MySQL
bd.connect((err) => {
    if (err) {
        console.log("Error al conectarse a mysql: " + err.stack);
        return;
    }
    console.log("Conectado a mysql");
});

// Ruta principal
app.get('/', (req, res) => {
    res.send("Bienvenidos al servicio del Centro de Ejercicio");
});

// Configuración de Swagger
const swaggerOptions = {
    swaggerDefinition: {
        openapi: "3.1.0",
        info: {
            title: "API del Centro de Ejercicio",
            version: "1.0.0",
            description: "API para gestionar los usuarios, coaches, clientes, clases y pagos del centro de ejercicio",
        },
    },
    apis: ['*.js'],
};

const swaggerDocs = swaggerJsDocs(swaggerOptions);
app.use('/apis-docs', swaggerUI.serve, swaggerUI.setup(swaggerDocs));

/*=========================
    RUTAS PARA USUARIOS
=========================*/

/**
 * @swagger
 * tags:
 *   name: Usuarios
 *   description: API para gestionar los usuarios del centro de ejercicio
 */

/**
 * @swagger
 * /usuarios:
 *   get:
 *     summary: Listar todos los usuarios
 *     tags: [Usuarios]
 *     responses:
 *       200:
 *         description: Lista de usuarios
 */
app.get('/usuarios', (req, res) => {
    bd.query('SELECT * FROM Usuarios', (err, results) => {
        if (err) {
            console.log('Error al ejecutar la consulta');
            return res.status(500).json({ error: 'Error en el servidor' });
        }
        res.json(results);
    });
});

/**
 * @swagger
 * /login:
 *   post:
 *     summary: Iniciar sesión con correo y contraseña
 *     tags: [Usuarios]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - email
 *               - contraseña
 *             properties:
 *               email:
 *                 type: string
 *               contraseña:
 *                 type: string
 *     responses:
 *       200:
 *         description: Inicio de sesión exitoso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id_usuario:
 *                   type: integer
 *                 nombre:
 *                   type: string
 *                 email:
 *                   type: string
 *                 tipo:
 *                   type: integer
 *       401:
 *         description: Correo o contraseña incorrectos
 *       500:
 *         description: Error en el servidor
 */
app.post('/login', (req, res) => {
    const { email, contraseña } = req.body;
  
    if (!email || !contraseña) {
      return res.status(400).json({ message: 'Correo y contraseña son obligatorios' });
    }
  
    const query = `
      SELECT u.IdUsuario AS id_usuario, 
             COALESCE(c.NombreCliente, a.NombreAdmin, co.NombreCoach, e.NombreEncargado) AS nombre,
             u.Usuario AS email, u.Contraseña AS contraseña, u.Tipo AS tipo
      FROM Usuarios u
      LEFT JOIN Clientes c ON u.IdUsuario = c.IdUsuario
      LEFT JOIN Administrador a ON u.IdUsuario = a.IdUsuario
      LEFT JOIN Coach co ON u.IdUsuario = co.IdUsuario
      LEFT JOIN Encargado e ON u.IdUsuario = e.IdUsuario
      WHERE u.Usuario = ?
    `;
    bd.query(query, [email], (err, results) => {
      if (err) {
        console.error('Error en la consulta SQL:', err);
        return res.status(500).json({ message: 'Error en el servidor' });
      }
  
      if (results.length === 0) {
        return res.status(401).json({ message: 'Correo o contraseña incorrectos' });
      }
  
      const usuario = results[0];
  
      if (contraseña !== usuario.contraseña) {
        return res.status(401).json({ message: 'Correo o contraseña incorrectos' });
      }
  
      res.json({
        id_usuario: usuario.id_usuario,
        nombre: usuario.nombre || 'Usuario',
        email: usuario.email,
        tipo: usuario.tipo,
      });
    });
  });

/*=========================
    RUTAS PARA REGISTRO
=========================*/

/**
 * @swagger
 * /registro:
 *   post:
 *     summary: Registrar un nuevo cliente
 *     tags: [Clientes]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - nombre
 *               - appPaterno
 *               - fecha
 *               - email
 *               - contraseña
 *             properties:
 *               nombre:
 *                 type: string
 *               appPaterno:
 *                 type: string
 *               appMaterno:
 *                 type: string
 *               fecha:
 *                 type: string
 *                 format: date
 *               telefono:
 *                 type: string
 *               email:
 *                 type: string
 *               contraseña:
 *                 type: string
 *     responses:
 *       201:
 *         description: Cliente registrado correctamente
 *       400:
 *         description: Datos incompletos o inválidos
 *       500:
 *         description: Error en el servidor
 */
app.post('/registro', (req, res) => {
    const { nombre, appPaterno, appMaterno, fecha, telefono, email, contraseña } = req.body;

    if (!nombre || !appPaterno || !fecha || !email || !contraseña) {
        return res.status(400).json({ error: 'Faltan campos requeridos' });
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        return res.status(400).json({ error: 'Email inválido' });
    }

    bd.beginTransaction((err) => {
        if (err) {
            console.error('Error al iniciar transacción:', err);
            return res.status(500).json({ error: 'Error en el servidor' });
        }

        const usuarioQuery = 'INSERT INTO Usuarios (Usuario, Contraseña, Tipo) VALUES (?, ?, ?)';
        bd.query(usuarioQuery, [email, contraseña, 4], (err, usuarioResult) => {
            if (err) {
                console.error('Error al crear usuario:', err);
                return bd.rollback(() => {
                    res.status(500).json({ error: 'Error al crear usuario', details: err.message });
                });
            }

            const idUsuario = usuarioResult.insertId;

            const clienteQuery =
                'INSERT INTO Clientes (NombreCliente, ApellidoPaterno, ApellidoMaterno, FechaNacimiento, Telefono, Email, IdUsuario, FechaRegistro) VALUES (?, ?, ?, ?, ?, ?, ?, CURDATE())';
            bd.query(
                clienteQuery,
                [nombre, appPaterno, appMaterno || null, fecha, telefono || null, email, idUsuario],
                (err) => {
                    if (err) {
                        console.error('Error al crear cliente:', err);
                        return bd.rollback(() => {
                            res.status(500).json({ error: 'Error al crear cliente', details: err.message });
                        });
                    }

                    bd.commit((err) => {
                        if (err) {
                            console.error('Error al confirmar transacción:', err);
                            return bd.rollback(() => {
                                res.status(500).json({ error: 'Error en el servidor' });
                            });
                        }
                        res.status(201).json({ message: 'Cliente registrado correctamente' });
                    });
                }
            );
        });
    });
});

/**
 * @swagger
 * /registro-admin-coach:
 *   post:
 *     summary: Registrar un administrador o coach
 *     tags: [Usuarios]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - nombre
 *               - appPaterno
 *               - email
 *               - contraseña
 *               - tipo
 *             properties:
 *               nombre:
 *                 type: string
 *               appPaterno:
 *                 type: string
 *               appMaterno:
 *                 type: string
 *               fecha:
 *                 type: string
 *                 format: date
 *               telefono:
 *                 type: string
 *               email:
 *                 type: string
 *               contraseña:
 *                 type: string
 *               tipo:
 *                 type: integer
 *                 description: 1 para Admin, 3 para Coach
 *     responses:
 *       201:
 *         description: Admin o coach registrado correctamente
 *       400:
 *         description: Datos incompletos o inválidos
 *       500:
 *         description: Error en el servidor
 */
app.post('/registro-admin-coach', (req, res) => {
    const { nombre, appPaterno, appMaterno, fecha, telefono, email, contraseña, tipo } = req.body;

    if (!nombre || !appPaterno || !email || !contraseña || !tipo) {
        return res.status(400).json({ error: 'Faltan campos requeridos' });
    }

    if (tipo !== 1 && tipo !== 3) {
        return res.status(400).json({ error: 'Tipo de usuario inválido' });
    }

    bd.beginTransaction((err) => {
        if (err) {
            console.error('Error al iniciar transacción:', err);
            return res.status(500).json({ error: 'Error en el servidor' });
        }

        const usuarioQuery = 'INSERT INTO Usuarios (Usuario, Contraseña, Tipo) VALUES (?, ?, ?)';
        bd.query(usuarioQuery, [email, contraseña, tipo], (err, usuarioResult) => {
            if (err) {
                console.error('Error al crear usuario:', err);
                return bd.rollback(() => {
                    res.status(500).json({ error: 'Error al crear usuario', details: err.message });
                });
            }

            const idUsuario = usuarioResult.insertId;

            const table = tipo === 1 ? 'Administrador' : 'Coach';
            const query = `
                INSERT INTO ${table} (
                    ${tipo === 1 ? 'NombreAdmin' : 'NombreCoach'},
                    ApellidoPaterno, ApellidoMaterno, FechaNacimiento, Telefono, Email, IdUsuario, 
                    ${tipo === 1 ? 'FechaContratacion' : 'FechaContratacion'}
                ) VALUES (?, ?, ?, ?, ?, ?, ?, CURDATE())
            `;
            bd.query(
                query,
                [nombre, appPaterno, appMaterno || null, fecha || null, telefono || null, email, idUsuario],
                (err) => {
                    if (err) {
                        console.error(`Error al crear ${tipo === 1 ? 'administrador' : 'coach'}:`, err);
                        return bd.rollback(() => {
                            res.status(500).json({ error: `Error al crear ${tipo === 1 ? 'administrador' : 'coach'}`, details: err.message });
                        });
                    }

                    bd.commit((err) => {
                        if (err) {
                            console.error('Error al confirmar transacción:', err);
                            return bd.rollback(() => {
                                res.status(500).json({ error: 'Error en el servidor' });
                            });
                        }
                        res.status(201).json({ message: `${tipo === 1 ? 'Administrador' : 'Coach'} registrado correctamente` });
                    });
                }
            );
        });
    });
});

/*=========================
    RUTAS PARA CLASES
=========================*/

/**
 * @swagger
 * tags:
 *   name: Clases
 *   description: API para gestionar las clases del centro de ejercicio
 */

/**
 * @swagger
 * /catalogo-clases:
 *   get:
 *     summary: Listar el catálogo de clases
 *     tags: [Clases]
 *     responses:
 *       200:
 *         description: Lista de clases en el catálogo
 */
app.get('/catalogo-clases', (req, res) => {
    bd.query('SELECT * FROM CatalogoClases', (err, results) => {
        if (err) {
            console.error('Error al obtener catálogo:', err);
            return res.status(500).json({ error: 'Error en el servidor' });
        }
        res.json(results);
    });
});

/**
 * @swagger
 * /clases:
 *   post:
 *     summary: Crear una clase programada
 *     tags: [Clases]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - idClase
 *               - idCoach
 *               - fechaHora
 *               - capacidad
 *               - idSalon
 *             properties:
 *               idClase:
 *                 type: integer
 *               idCoach:
 *                 type: integer
 *               fechaHora:
 *                 type: string
 *                 format: date-time
 *               capacidad:
 *                 type: integer
 *               idSalon:
 *                 type: integer
 *     responses:
 *       201:
 *         description: Clase programada creada correctamente
 *       400:
 *         description: Datos incompletos o inválidos
 *       403:
 *         description: No autorizado
 *       500:
 *         description: Error en el servidor
 */
app.post('/clases', (req, res) => {
    const { idClase, idCoach, fechaHora, capacidad, idSalon } = req.body;

    if (!idClase || !idCoach || !fechaHora || !capacidad || !idSalon) {
        return res.status(400).json({ error: 'Faltan campos requeridos' });
    }

    bd.query('SELECT u.Tipo FROM Usuarios u JOIN Coach c ON u.IdUsuario = c.IdUsuario WHERE c.IdCoach = ?', [idCoach], (err, results) => {
        if (err) {
            console.error('Error al verificar coach:', err);
            return res.status(500).json({ error: 'Error en el servidor' });
        }

        if (results.length === 0 || results[0].Tipo !== 3) {
            return res.status(403).json({ error: 'No autorizado' });
        }

        const query = 'INSERT INTO Clases (IdClase, IdCoach, FechaHora, Capacidad, IdSalon) VALUES (?, ?, ?, ?, ?)';
        bd.query(query, [idClase, idCoach, fechaHora, capacidad, idSalon], (err, result) => {
            if (err) {
                console.error('Error al crear clase:', err);
                return res.status(500).json({ error: 'Error al crear clase', details: err.message });
            }
            res.status(201).json({ message: 'Clase programada creada correctamente', idClaseProgramada: result.insertId });
        });
    });
});

/**
 * @swagger
 * /clases/disponibles:
 *   get:
 *     summary: Listar clases programadas disponibles
 *     tags: [Clases]
 *     responses:
 *       200:
 *         description: Lista de clases disponibles
 *       500:
 *         description: Error en el servidor
 */
app.get('/clases/disponibles', (req, res) => {
    const query = `
        SELECT c.IdClaseProgramada, cc.NombreClase, c.FechaHora, c.Capacidad, 
               COUNT(cl.IdInscripcion) AS Inscritos, co.NombreCoach, s.NombreSalon
        FROM Clases c
        JOIN CatalogoClases cc ON c.IdClase = cc.IdClase
        JOIN Coach co ON c.IdCoach = co.IdCoach
        JOIN Salones s ON c.IdSalon = s.IdSalon
        LEFT JOIN ClaseCliente cl ON c.IdClaseProgramada = cl.IdClaseProgramada
        GROUP BY c.IdClaseProgramada
        HAVING Inscritos < c.Capacidad
    `;
    bd.query(query, (err, results) => {
        if (err) {
            console.error('Error al obtener clases disponibles:', err);
            return res.status(500).json({ error: 'Error en el servidor' });
        }
        res.json(results);
    });
});

/**
 * @swagger
 * /clases/{id_usuario}:
 *   get:
 *     summary: Obtener clases reservadas por un cliente
 *     tags: [Clases]
 *     parameters:
 *       - in: path
 *         name: id_usuario
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Lista de clases reservadas
 *       500:
 *         description: Error en el servidor
 */
app.get('/clases/:id_usuario', (req, res) => {
    const id_usuario = parseInt(req.params.id_usuario);
    const query = `
        SELECT c.IdClaseProgramada, cc.NombreClase, c.FechaHora, co.NombreCoach, s.NombreSalon
        FROM Clases c
        JOIN CatalogoClases cc ON c.IdClase = cc.IdClase
        JOIN Coach co ON c.IdCoach = co.IdCoach
        JOIN Salones s ON c.IdSalon = s.IdSalon
        JOIN ClaseCliente cl ON c.IdClaseProgramada = cl.IdClaseProgramada
        JOIN Clientes cli ON cl.IdCliente = cli.IdCliente
        WHERE cli.IdUsuario = ?
    `;
    bd.query(query, [id_usuario], (err, results) => {
        if (err) {
            console.error('Error al obtener clases:', err);
            return res.status(500).json({ error: 'Error en el servidor' });
        }
        res.json(results);
    });
});

/**
 * @swagger
 * /reservas:
 *   post:
 *     summary: Reservar una clase
 *     tags: [Clases]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - idClaseProgramada
 *               - idUsuario
 *             properties:
 *               idClaseProgramada:
 *                 type: integer
 *               idUsuario:
 *                 type: integer
 *     responses:
 *       201:
 *         description: Clase reservada correctamente
 *       400:
 *         description: Datos incompletos o clase llena
 *       403:
 *         description: No autorizado
 *       500:
 *         description: Error en el servidor
 */
app.post('/reservas', (req, res) => {
    const { idClaseProgramada, idUsuario } = req.body;

    if (!idClaseProgramada || !idUsuario) {
        return res.status(400).json({ error: 'Faltan campos requeridos' });
    }

    bd.query('SELECT Tipo FROM Usuarios WHERE IdUsuario = ?', [idUsuario], (err, userResults) => {
        if (err) {
            console.error('Error al verificar usuario:', err);
            return res.status(500).json({ error: 'Error en el servidor' });
        }

        if (userResults.length === 0 || userResults[0].Tipo !== 4) {
            return res.status(403).json({ error: 'No autorizado' });
        }

        bd.query(
            'SELECT c.Capacidad, COUNT(cl.IdInscripcion) AS Inscritos FROM Clases c LEFT JOIN ClaseCliente cl ON c.IdClaseProgramada = cl.IdClaseProgramada WHERE c.IdClaseProgramada = ? GROUP BY c.IdClaseProgramada',
            [idClaseProgramada],
            (err, claseResults) => {
                if (err) {
                    console.error('Error al verificar clase:', err);
                    return res.status(500).json({ error: 'Error en el servidor' });
                }

                if (claseResults.length === 0) {
                    return res.status(400).json({ error: 'Clase no encontrada' });
                }

                const { Capacidad, Inscritos } = claseResults[0];
                if (Inscritos >= Capacidad) {
                    return res.status(400).json({ error: 'Clase llena' });
                }

                bd.query('SELECT IdCliente FROM Clientes WHERE IdUsuario = ?', [idUsuario], (err, clienteResults) => {
                    if (err) {
                        console.error('Error al obtener cliente:', err);
                        return res.status(500).json({ error: 'Error en el servidor' });
                    }

                    if (clienteResults.length === 0) {
                        return res.status(400).json({ error: 'Cliente no encontrado' });
                    }

                    const idCliente = clienteResults[0].IdCliente;

                    bd.beginTransaction((err) => {
                        if (err) {
                            console.error('Error al iniciar transacción:', err);
                            return res.status(500).json({ error: 'Error en el servidor' });
                        }

                        const reservaQuery = 'INSERT INTO ClaseCliente (IdCliente, IdClaseProgramada, FechaInscripcion) VALUES (?, ?, CURDATE())';
                        bd.query(reservaQuery, [idCliente, idClaseProgramada], (err) => {
                            if (err) {
                                console.error('Error al crear reserva:', err);
                                return bd.rollback(() => {
                                    res.status(500).json({ error: 'Error al crear reserva', details: err.message });
                                });
                            }

                            bd.commit((err) => {
                                if (err) {
                                    console.error('Error al confirmar transacción:', err);
                                    return bd.rollback(() => {
                                        res.status(500).json({ error: 'Error en el servidor' });
                                    });
                                }
                                res.status(201).json({ message: 'Clase reservada correctamente' });
                            });
                        });
                    });
                });
            }
        );
    });
});

/*=========================
    RUTAS AUXILIARES
=========================*/

/**
 * @swagger
 * /salones:
 *   get:
 *     summary: Listar todos los salones
 *     tags: [Clases]
 *     responses:
 *       200:
 *         description: Lista de salones
 */
app.get('/salones', (req, res) => {
    bd.query('SELECT * FROM Salones', (err, results) => {
        if (err) {
            console.error('Error al obtener salones:', err);
            return res.status(500).json({ error: 'Error en el servidor' });
        }
        res.json(results);
    });
});

/**
 * @swagger
 * /coaches:
 *   get:
 *     summary: Listar todos los coaches
 *     tags: [Clases]
 *     responses:
 *       200:
 *         description: Lista de coaches
 */
app.get('/coaches', (req, res) => {
    bd.query('SELECT IdCoach, NombreCoach, ApellidoPaterno FROM Coach', (err, results) => {
        if (err) {
            console.error('Error al obtener coaches:', err);
            return res.status(500).json({ error: 'Error en el servidor' });
        }
        res.json(results);
    });
});

app.listen(port, () => {
    console.log("Servidor iniciado en puerto " + port);
});

/*=========================
    RUTAS DELETE PARA CLASES, COACHES Y SALONES
=========================*/

/**
 * @swagger
 * /clases/{id}:
 *   delete:
 *     summary: Eliminar una clase programada
 *     tags: [Clases]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID de la clase programada a eliminar
 *     responses:
 *       200:
 *         description: Clase eliminada correctamente
 *       404:
 *         description: Clase no encontrada
 *       500:
 *         description: Error en el servidor
 */
app.delete('/clases/:id', (req, res) => {
    const idClase = parseInt(req.params.id);

    // Primero verificar si existe la clase
    bd.query('SELECT * FROM Clases WHERE IdClaseProgramada = ?', [idClase], (err, results) => {
        if (err) {
            console.error('Error al verificar clase:', err);
            return res.status(500).json({ error: 'Error en el servidor' });
        }

        if (results.length === 0) {
            return res.status(404).json({ error: 'Clase no encontrada' });
        }

        // Eliminar primero las reservas asociadas (si las hay)
        bd.query('DELETE FROM ClaseCliente WHERE IdClaseProgramada = ?', [idClase], (err) => {
            if (err) {
                console.error('Error al eliminar reservas:', err);
                return res.status(500).json({ error: 'Error al eliminar reservas asociadas' });
            }

            // Luego eliminar la clase
            bd.query('DELETE FROM Clases WHERE IdClaseProgramada = ?', [idClase], (err) => {
                if (err) {
                    console.error('Error al eliminar clase:', err);
                    return res.status(500).json({ error: 'Error al eliminar clase' });
                }
                res.json({ message: 'Clase eliminada correctamente' });
            });
        });
    });
});

/**
 * @swagger
 * /coaches/{id}:
 *   delete:
 *     summary: Eliminar un coach
 *     tags: [Clases]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID del coach a eliminar
 *     responses:
 *       200:
 *         description: Coach eliminado correctamente
 *       400:
 *         description: No se puede eliminar el coach porque tiene clases asignadas
 *       404:
 *         description: Coach no encontrado
 *       500:
 *         description: Error en el servidor
 */
app.delete('/coaches/:id', (req, res) => {
    const idCoach = parseInt(req.params.id);

    // Primero verificar si existe el coach
    bd.query('SELECT * FROM Coach WHERE IdCoach = ?', [idCoach], (err, results) => {
        if (err) {
            console.error('Error al verificar coach:', err);
            return res.status(500).json({ error: 'Error en el servidor' });
        }

        if (results.length === 0) {
            return res.status(404).json({ error: 'Coach no encontrado' });
        }

        // Verificar si el coach tiene clases asignadas
        bd.query('SELECT * FROM Clases WHERE IdCoach = ?', [idCoach], (err, clasesResults) => {
            if (err) {
                console.error('Error al verificar clases del coach:', err);
                return res.status(500).json({ error: 'Error en el servidor' });
            }

            if (clasesResults.length > 0) {
                return res.status(400).json({ 
                    error: 'No se puede eliminar el coach porque tiene clases asignadas',
                    clasesAsignadas: clasesResults.map(c => c.IdClaseProgramada)
                });
            }

            // Obtener el IdUsuario para eliminar también el usuario asociado
            const idUsuario = results[0].IdUsuario;

            // Iniciar transacción para eliminar coach y usuario
            bd.beginTransaction((err) => {
                if (err) {
                    console.error('Error al iniciar transacción:', err);
                    return res.status(500).json({ error: 'Error en el servidor' });
                }

                // Eliminar el coach
                bd.query('DELETE FROM Coach WHERE IdCoach = ?', [idCoach], (err) => {
                    if (err) {
                        console.error('Error al eliminar coach:', err);
                        return bd.rollback(() => {
                            res.status(500).json({ error: 'Error al eliminar coach' });
                        });
                    }

                    // Eliminar el usuario asociado
                    bd.query('DELETE FROM Usuarios WHERE IdUsuario = ?', [idUsuario], (err) => {
                        if (err) {
                            console.error('Error al eliminar usuario:', err);
                            return bd.rollback(() => {
                                res.status(500).json({ error: 'Error al eliminar usuario asociado' });
                            });
                        }

                        // Confirmar transacción
                        bd.commit((err) => {
                            if (err) {
                                console.error('Error al confirmar transacción:', err);
                                return bd.rollback(() => {
                                    res.status(500).json({ error: 'Error en el servidor' });
                                });
                            }
                            res.json({ message: 'Coach eliminado correctamente' });
                        });
                    });
                });
            });
        });
    });
});

/**
 * @swagger
 * /salones/{id}:
 *   delete:
 *     summary: Eliminar un salón
 *     tags: [Clases]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID del salón a eliminar
 *     responses:
 *       200:
 *         description: Salón eliminado correctamente
 *       400:
 *         description: No se puede eliminar el salón porque tiene clases asignadas
 *       404:
 *         description: Salón no encontrado
 *       500:
 *         description: Error en el servidor
 */
app.delete('/salones/:id', (req, res) => {
    const idSalon = parseInt(req.params.id);

    // Primero verificar si existe el salón
    bd.query('SELECT * FROM Salones WHERE IdSalon = ?', [idSalon], (err, results) => {
        if (err) {
            console.error('Error al verificar salón:', err);
            return res.status(500).json({ error: 'Error en el servidor' });
        }

        if (results.length === 0) {
            return res.status(404).json({ error: 'Salón no encontrado' });
        }

        // Verificar si el salón tiene clases asignadas
        bd.query('SELECT * FROM Clases WHERE IdSalon = ?', [idSalon], (err, clasesResults) => {
            if (err) {
                console.error('Error al verificar clases del salón:', err);
                return res.status(500).json({ error: 'Error en el servidor' });
            }

            if (clasesResults.length > 0) {
                return res.status(400).json({ 
                    error: 'No se puede eliminar el salón porque tiene clases asignadas',
                    clasesAsignadas: clasesResults.map(c => c.IdClaseProgramada)
                });
            }

            // Eliminar el salón
            bd.query('DELETE FROM Salones WHERE IdSalon = ?', [idSalon], (err) => {
                if (err) {
                    console.error('Error al eliminar salón:', err);
                    return res.status(500).json({ error: 'Error al eliminar salón' });
                }
                res.json({ message: 'Salón eliminado correctamente' });
            });
        });
    });
});
