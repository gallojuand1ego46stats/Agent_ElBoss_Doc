# Alcance y calibración del proyecto

## Visión

**ElBoss** se plantea como un agente estadístico extensible, con una arquitectura basada en un agente principal y subagentes especializados.

## MVP actual

El primer subagente implementado es **`reportero-estadistico`**.

Su responsabilidad es recibir una base de datos estructurada y coordinar la generación de un reporte estadístico en PDF mediante el pipeline especializado disponible en el proyecto.

El alcance actual contempla formatos de datos como:

- CSV;
- XLS;
- XLSX.

## Razón de la delimitación

Se decidió iniciar con el reporte estadístico porque permite cerrar un flujo de extremo a extremo: entrada de datos, procesamiento estadístico, visualizaciones, inferencia básica según el alcance implementado y generación de un documento final.

Esta delimitación permite dedicar tiempo a la verificación matemática, pruebas, documentación y reproducibilidad antes de incorporar capacidades que requieren decisiones estadísticas más complejas.

## Capacidades consideradas para futuras etapas

Entre las capacidades que pueden incorporarse posteriormente se encuentran:

- tratamiento especializado de datos faltantes;
- evaluación de supuestos;
- selección y aplicación de pruebas estadísticas según contexto;
- nuevos subagentes estadísticos especializados.

Estas capacidades no deben considerarse parte del alcance actual hasta que estén implementadas, verificadas y documentadas.

## Criterio de control del alcance

Una nueva capacidad debe incorporarse únicamente cuando pueda:

1. definirse con precisión;
2. implementarse de forma reproducible;
3. validarse estadísticamente;
4. probarse con casos normales y casos límite;
5. documentarse dentro de la arquitectura del agente.

## Estado

**MVP:** reportero estadístico.

**Visión futura:** ecosistema de subagentes estadísticos especializados coordinados por ElBoss.
