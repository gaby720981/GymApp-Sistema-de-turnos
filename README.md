# Sistema de Gestión de Turnos


Sistema de gestión de turnos para gimnasios desarrollado con **Node.js + Express** (backend) y **HTML + CSS + JavaScript** (frontend). Permite a los socios reservar, cancelar y gestionar sus turnos de manera ágil y desde cualquier dispositivo.

---

## Tabla de Contenidos

- [Características Principales](#-características-principales)
- [Tecnologías Utilizadas](#-tecnologías-utilizadas)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Requisitos Previos](#-requisitos-previos)
- [Instalación y Configuración](#-instalación-y-configuración)
- [Uso del Sistema](#-uso-del-sistema)
- [Documentación Técnica](#-documentación-técnica)
- [Próximos Pasos](#-próximos-pasos)

---

## Características Principales

### Para Socios
- ✅ **Registro e inicio de sesión** con autenticación JWT.
- ✅ **Reserva de turnos** con disponibilidad en tiempo real (solo días y horarios con cupo).
- ✅ **Cancelación de turnos** hasta 2 horas antes de la clase.
- ✅ **Lista de espera** con notificación automática al liberarse un cupo.
- ✅ **Visualización de turnos** activos e historial completo.
- ✅ **Notificaciones** por correo electrónico y/o WhatsApp.

### Para Recepcionistas y Entrenadores
- ✅ **Marcado de asistencia** a las clases.
- ✅ **Gestión de lista de espera** manual (para casos de emergencia).
- ✅ **Visualización de turnos del día**.

### Para Administradores
- ✅ **Gestión de clases**: crear, modificar, activar/desactivar.
- ✅ **Control de capacidad** máxima por clase.
- ✅ **Reportes** de ocupación y asistencia.
- ✅ **Gestión de entrenadores** y asignación a clases.

---

## Tecnologías Utilizadas

| Capa | Tecnología | Versión |
|------|------------|---------|
| **Frontend** | HTML5, CSS3, JavaScript | - |
| **Backend** | Node.js + Express | 18.x |
| **Base de Datos** | PostgreSQL | 14.x |
| **Autenticación** | JWT (JSON Web Tokens) | - |
| **ORM** | Sequelize (opcional) | - |
| **Control de Versiones** | Git + GitHub | - |

---

## Estructura del Proyecto
CORREGIR!------------------------------------------------------
GymFit-SistemaTurnos/
│
├── diseno/ # Diseño del sistema
│ ├── DER_GymFit.sql # Script de base de datos
│ └── DiagramaClases_GymFit.md # Diagrama de clases (UML)
│
├── backend/ # Código del servidor
│ ├── src/
│ │ ├── controllers/ # Lógica de negocio
│ │ ├── models/ # Modelos de datos (base de datos)
│ │ ├── routes/ # Rutas de la API
│ │ ├── config/ # Configuración (DB, JWT)
│ │ └── utils/ # Utilidades (helpers, validaciones)
│ ├── package.json # Dependencias del backend
│ ├── .env # Variables de entorno
│ └── server.js # Punto de entrada del servidor
│
├── frontend/ # Código del cliente
│ ├── public/
│ │ ├── index.html # Página principal
│ │ └── favicon.ico
│ ├── src/
│ │ ├── css/ # Estilos
│ │ ├── js/ # Lógica del frontend
│ │ └── img/ # Imágenes
│ └── package.json # Dependencias del frontend
│
└── README.md # Presentación del proyecto


---

## Requisitos Previos

Antes de comenzar, asegúrate de tener instalado:

- [Node.js](https://nodejs.org/) (versión 18 o superior)
- [PostgreSQL](https://www.postgresql.org/) (versión 14 o superior)
- [Git](https://git-scm.com/) (para clonar el repositorio)
- Un editor de código (recomendado: [VS Code](https://code.visualstudio.com/))

---

## Instalación y Configuración

### 1. Clonar el repositorio 
```bash
git clone https://github.com/tu-usuario/GymFit-SistemaTurnos.git
cd GymFit-SistemaTurnos

### 2. Configurar la Base de Datos

Crear la base de datos en PostgreSQL:
sql
CREATE DATABASE gymfit_db;

Ejecutar el script de creación de tablas:
bash
psql -U postgres -d gymfit_db -f diseno/DER_GymFit.sql

### 3. Configurar el Backend
bash
cd backend
npm install

Crear archivo .env con las siguientes variables:
env
# Configuración del Servidor
PORT=3000

# Configuración de la Base de Datos
DB_HOST=localhost
DB_PORT=5432
DB_USER=postgres
DB_PASSWORD=tu_contraseña
DB_NAME=gymfit_db

# Configuración de JWT
JWT_SECRET=tu_clave_secreta
JWT_EXPIRES_IN=7d

# Configuración de Notificaciones (Opcional)
EMAIL_USER=tu_email@gmail.com
EMAIL_PASS=tu_contraseña_app
WHATSAPP_API_KEY=tu_api_key


### 4. Ejecutar el Backend
bash
# Modo desarrollo (con nodemon)
npm run dev
# Modo producción
npm start

### 5. Configurar el Frontend
bash
cd frontend
npm install

### 6. Ejecutar el Frontend
bash
# Servir los archivos estáticos
npm start

El frontend estará disponible en http://localhost:8080.

 Uso del Sistema
Flujo Principal (Socio)

graph LR
    A[Inicio] --> B[Registro/Login]
    B --> C[Reservar Turno]
    C --> D[Seleccionar Clase]
    D --> E[Seleccionar Día]
    E --> F[Seleccionar Horario]
    F --> G[Confirmar Reserva]
    G --> H[Ver Mis Turnos]

Endpoints Principales de la API
Método	Endpoint	Descripción
POST	/api/registro	Registrar un nuevo socio
POST	/api/login	Iniciar sesión
GET	/api/clases	Listar clases disponibles
POST	/api/turnos	Reservar un turno
DELETE	/api/turnos/:id	Cancelar un turno
GET	/api/turnos/mis-turnos	Ver turnos del socio
POST	/api/lista-espera	Unirse a lista de espera
GET	/api/lista-espera/posicion	Ver posición en lista

🗺️ Próximos Pasos

Implementar integración con pasarela de pagos (MercadoPago).

Desarrollar aplicación móvil (Android/iOS).

Implementar notificaciones push.

Mejorar la accesibilidad (WCAG 2.1).

Realizar pruebas de carga y optimización.

