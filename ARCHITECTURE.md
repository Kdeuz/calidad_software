# Arquitectura del Sistema de Torneos HIA-JEE

## Decisiones de Arquitectura (ADR)

### ADR 1: Patrón Modelo-Vista-Controlador (MVC)
- **Estatus:** Aceptado
- **Contexto:** Necesitamos separar la lógica de negocio de la interfaz de usuario.
- **Decisión:** Uso de Spring Boot con Controllers para el flujo, Services para la lógica y JPA para los datos.
- **Consecuencia:** Facilita el mantenimiento y permite que varios desarrolladores trabajen en capas distintas simultáneamente (Modelo Concurrente).

### ADR 2: Implementación del Sistema de Logros (Achievements)
- **Estatus:** Aceptado
- **Contexto:** Se requiere un sistema de recompensas que no afecte el rendimiento del motor de torneos.
- **Decisión:** Crear un `AchievementService` desacoplado. El desbloqueo de logros se dispara como un evento tras la persistencia del resultado de un partido.
- **Consecuencia:** Alta cohesión y bajo acoplamiento.

### ADR 3: Motor de Persistencia Relacional (JPA/Hibernate)
- **Estatus:** Aceptado
- **Decisión:** Uso de Hibernate para manejar la relación `ManyToMany` entre Usuarios y Logros.
- **Consecuencia:** Integridad referencial automática y facilidad para generar datos de prueba (Seed Data).
