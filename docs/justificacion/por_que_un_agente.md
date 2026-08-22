# ¿Por qué un agente?

## Problema que debe resolver la arquitectura

El problema no consiste solamente en ejecutar una secuencia fija de cálculos estadísticos. El usuario puede entregar diferentes bases de datos y formular solicitudes que requieren interpretar la tarea, identificar el procesamiento apropiado y coordinar la generación del resultado.

## Arquitectura actual

El proyecto utiliza una arquitectura en la que **ElBoss** actúa como agente principal y delega la tarea de generación del reporte al subagente **`reportero-estadistico`**. Este subagente utiliza una skill especializada y un pipeline Python para ejecutar el procesamiento estadístico y producir el reporte.

El flujo conceptual actual es:

```text
Usuario
   ↓
ElBoss
   ↓
Delegación al subagente
   ↓
reportero-estadistico
   ↓
Skill especializada
   ↓
Pipeline estadístico Python
   ↓
Exploración / descriptivos / visualizaciones / inferencia / reporte
   ↓
PDF
   ↓
Resultado al usuario
```

## ¿Por qué no solamente un script?

Un script determinista puede ejecutar un conjunto fijo de instrucciones sobre una entrada conocida. La arquitectura de ElBoss incorpora una capa de agente para coordinar la solicitud y delegar la tarea a un componente especializado.

El pipeline Python conserva el carácter determinista de los cálculos estadísticos, mientras que la capa de agente permite organizar y orquestar el uso de ese pipeline dentro de una arquitectura extensible.

Esto permite separar responsabilidades:

- **Agente principal:** coordinación de la solicitud.
- **Subagente:** especialización en reportes estadísticos.
- **Skill:** instrucciones y criterios operativos de la tarea.
- **Pipeline Python:** procesamiento estadístico reproducible.
- **Salida:** reporte estadístico en PDF.

## Por qué esta arquitectura es apropiada para el MVP

El diseño permite comenzar con una capacidad estadística concreta y verificable y, posteriormente, incorporar otros subagentes especializados sin reconstruir la arquitectura principal.

## Límite de la afirmación

No se afirma que todos los cálculos estadísticos requieran inteligencia artificial. Los cálculos que pueden resolverse de manera determinista permanecen en Python. El valor del agente se encuentra en la coordinación, delegación y extensibilidad del sistema.
