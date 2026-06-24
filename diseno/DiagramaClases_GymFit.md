# Diagrama de Clases

El siguiente diagrama de clases muestra la estructura de datos del sistema, incluyendo las entidades principales, sus atributos, métodos y relaciones. Este diseño es la base para la construcción del backend y la base de datos.

---


```mermaid
classDiagram
    class Usuario {
        +int id
        +string nombre
        +string email
        +string telefono
        +string password
        +enum rol
        +boolean membresiaActiva
        +datetime fechaRegistro
        +registrar()
        +iniciarSesion()
        +cerrarSesion()
        +actualizarPerfil()
        +cambiarPassword()
        +tieneMembresiaActiva()
    }

    class Clase {
        +int id
        +string nombre
        +string descripcion
        +enum nivel
        +int capacidadMax
        +int duracion
        +boolean activo
        +int entrenadorId
        +crearClase()
        +actualizarClase()
        +activarClase()
        +desactivarClase()
        +obtenerCuposDisponibles()
    }

    class Turno {
        +int id
        +int usuarioId
        +int claseId
        +date fecha
        +time hora
        +enum estado
        +string codigoConfirmacion
        +datetime fechaReserva
        +reservar()
        +cancelar()
        +verificarCupo()
        +obtenerMisTurnos()
        +marcarAsistencia()
    }

    class ListaEspera {
        +int id
        +int usuarioId
        +int claseId
        +date fecha
        +time hora
        +datetime fechaSolicitud
        +int posicion
        +boolean notificado
        +agregar()
        +obtenerPosicion()
        +liberarCupo()
        +salirDeLista()
    }

    class Notificacion {
        +int id
        +int usuarioId
        +enum tipo
        +string mensaje
        +boolean leido
        +datetime fechaEnvio
        +enviar()
        +marcarComoLeido()
        +obtenerNoLeidas()
    }

    class Asistencia {
        +int id
        +int turnoId
        +boolean presente
        +datetime fechaMarcacion
        +marcarPresente()
        +marcarAusente()
        +obtenerAsistentes()
    }

    Usuario "1" --> "*" Turno
    Clase "1" --> "*" Turno
    Clase "1" --> "*" ListaEspera
    Usuario "1" --> "*" ListaEspera
    Turno "1" --> "1" Asistencia
    Usuario "1" --> "*" Notificacion
    Usuario "1" --> "*" Clase