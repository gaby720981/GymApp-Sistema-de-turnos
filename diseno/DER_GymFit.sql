-- ============================================
-- BASE DE DATOS: GymFit - Sistema de Turnos
-- ============================================

-- ============================================
-- 1. TABLA: usuarios
-- ============================================
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(20) NULL,
    password VARCHAR(255) NOT NULL,
    rol ENUM('socio', 'recepcionista', 'entrenador', 'admin') NOT NULL DEFAULT 'socio',
    membresia_activa BOOLEAN DEFAULT TRUE,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 2. TABLA: clases
-- ============================================
CREATE TABLE clases (
    id_clase INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT NULL,
    nivel ENUM('principiante', 'intermedio', 'avanzado', 'todos') NOT NULL DEFAULT 'todos',
    capacidad_max INT NOT NULL,
    duracion INT NOT NULL COMMENT 'Duración en minutos',
    activo BOOLEAN DEFAULT TRUE,
    id_entrenador INT NULL,
    FOREIGN KEY (id_entrenador) REFERENCES usuarios(id_usuario) ON DELETE SET NULL
);

-- ============================================
-- 3. TABLA: turnos
-- ============================================
CREATE TABLE turnos (
    id_turno INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_clase INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    estado ENUM('reservado', 'cancelado', 'completado', 'no_asistio') NOT NULL DEFAULT 'reservado',
    codigo_confirmacion VARCHAR(20) NOT NULL UNIQUE,
    fecha_reserva DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_cancelacion DATETIME NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_clase) REFERENCES clases(id_clase) ON DELETE CASCADE,
    UNIQUE KEY unique_reserva (id_clase, fecha, hora, estado)
);

-- ============================================
-- 4. TABLA: lista_espera
-- ============================================
CREATE TABLE lista_espera (
    id_lista INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_clase INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    fecha_solicitud DATETIME DEFAULT CURRENT_TIMESTAMP,
    posicion INT NULL,
    notificado BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_clase) REFERENCES clases(id_clase) ON DELETE CASCADE,
    UNIQUE KEY unique_espera (id_usuario, id_clase, fecha, hora)
);

-- ============================================
-- 5. TABLA: notificaciones
-- ============================================
CREATE TABLE notificaciones (
    id_notificacion INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    tipo ENUM('email', 'whatsapp') NOT NULL,
    mensaje TEXT NOT NULL,
    leido BOOLEAN DEFAULT FALSE,
    fecha_envio DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- ============================================
-- 6. TABLA: asistencias
-- ============================================
CREATE TABLE asistencias (
    id_asistencia INT PRIMARY KEY AUTO_INCREMENT,
    id_turno INT NOT NULL UNIQUE,
    presente BOOLEAN DEFAULT FALSE,
    fecha_marcacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_turno) REFERENCES turnos(id_turno) ON DELETE CASCADE
);

-- ============================================
-- DATOS INICIALES (Ejemplo)
-- ============================================

-- Insertar usuario administrador (contraseña: Admin123!)
INSERT INTO usuarios (nombre, email, password, rol) VALUES
('Admin', 'admin@gymfit.com', '$2b$10$EjemploHashDeAdmin', 'admin');

-- Insertar clases de ejemplo
INSERT INTO clases (nombre, descripcion, nivel, capacidad_max, duracion) VALUES
('CrossFit', 'Entrenamiento funcional de alta intensidad', 'intermedio', 15, 60),
('Yoga', 'Clase de yoga para todos los niveles', 'todos', 20, 90),
('Spinning', 'Ciclismo indoor con música', 'principiante', 25, 45),
('Pesas', 'Entrenamiento con pesas y barras', 'avanzado', 10, 60),
('Cardio', 'Máquinas cardiovasculares', 'todos', 8, 45);

-- ============================================
-- CONSULTAS ÚTILES (Ejemplos)
-- ============================================

-- Ver cupos disponibles para una clase en una fecha
SELECT 
    c.id_clase,
    c.nombre,
    c.capacidad_max,
    (c.capacidad_max - COUNT(t.id_turno)) AS cupos_disponibles
FROM clases c
LEFT JOIN turnos t ON c.id_clase = t.id_clase 
    AND t.fecha = '2024-06-24' 
    AND t.estado = 'reservado'
WHERE c.activo = TRUE
GROUP BY c.id_clase;

-- Ver lista de espera de una clase
SELECT 
    l.*,
    u.nombre,
    u.email
FROM lista_espera l
JOIN usuarios u ON l.id_usuario = u.id_usuario
WHERE l.id_clase = 1 AND l.fecha = '2024-06-24'
ORDER BY l.posicion ASC;