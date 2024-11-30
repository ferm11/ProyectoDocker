const mysql = require('mysql');

// Configuración del pool de conexiones
const db = mysql.createPool({
  host: 'mysql-db',
  port: 3306,
  user: 'admin',
  password: 'admin',
  database: 'bibliotecautng',
  waitForConnections: true,  // Esperar si no hay conexiones disponibles
  connectionLimit: 10,       // Número máximo de conexiones en db
  queueLimit: 0             // No hay límite en la cola de espera
});

// Función para conectar y hacer consultas usando el pool
function connectToDatabase() {
  db.getConnection((err, connection) => {
    if (err) {
      console.error('Error al obtener conexión del pool: ' + err.message);
      setTimeout(connectToDatabase, 5000);  // Reintenta la conexión cada 5 segundos
    } else {
      console.log('Conexión a la base de datos exitosa');
      
      // Usar la conexión para una consulta
      connection.query('SELECT 1 + 1 AS solution', (err, results) => {
        if (err) {
          console.error('Error en la consulta: ', err);
        } else {
          console.log('El resultado de la consulta es: ', results[0].solution);
        }
      });

      // Liberar la conexión después de usarla
      connection.release();
    }
  });

  // Manejar el cierre de conexiones por errores fatales
  db.on('error', (err) => {
    console.error('Error fatal de conexión en el pool: ', err);
    if (err.code === 'PROTOCOL_ENQUEUE_AFTER_FATAL_ERROR') {
      // Intentar reconectar después de un error fatal
      setTimeout(connectToDatabase, 5000);
    }
  });
}

connectToDatabase();

module.exports = db;
