# Alternativas consideradas

## Propósito

Registrar decisiones de alcance tomadas durante el desarrollo y mostrar por qué el proyecto se concentró inicialmente en el subagente `reportero-estadistico`.

## Alternativa 1 — Tratamiento automatizado de datos faltantes

### Valor potencial

Un subagente dedicado podría identificar patrones de datos faltantes y proponer o ejecutar estrategias de tratamiento.

### Motivo para posponerlo

El tratamiento de faltantes requiere decisiones metodológicas que dependen del contexto de los datos y deben verificarse con rigor estadístico. Implementarlo como capacidad general habría aumentado el alcance y la necesidad de validación.

### Decisión

**Pospuesta para una etapa posterior.**

## Alternativa 2 — Pruebas de supuestos y selección de pruebas estadísticas

### Valor potencial

Un subagente podría evaluar supuestos y apoyar la selección de técnicas inferenciales según las características de los datos.

### Motivo para posponerlo

Esta funcionalidad implica una mayor complejidad metodológica y requiere una validación estadística rigurosa para evitar recomendaciones incorrectas.

### Decisión

**Pospuesta para una etapa posterior.**

## Alternativa 3 — Reportero estadístico

### Valor potencial

Permite integrar un flujo completo y verificable que parte de una base de datos y termina en un reporte estadístico en PDF.

### Motivo para seleccionarlo

El alcance puede delimitarse de forma clara y permite validar el pipeline estadístico mediante pruebas, cálculos reproducibles y generación de una salida concreta.

### Decisión

**Seleccionada como primer subagente de ElBoss.**

## Criterio de selección

La selección no se basa únicamente en facilidad de implementación. Se priorizó una capacidad con utilidad directa, alcance controlable y posibilidad de verificar sus resultados estadísticos antes de ampliar ElBoss hacia capacidades inferenciales o de tratamiento de datos más complejas.
