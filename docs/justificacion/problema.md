# Problema

## Situación actual

La generación de un reporte estadístico a partir de una base de datos requiere una secuencia de actividades que, sin una automatización integrada, debe realizarse manualmente en un entorno de programación.

El proceso incluye, como mínimo:

1. cargar los datos;
2. verificar la estructura y los tipos de variables;
3. revisar la calidad de los datos;
4. identificar y tratar, cuando corresponda, datos faltantes;
5. realizar el análisis exploratorio;
6. calcular estadísticos descriptivos;
7. seleccionar y aplicar técnicas estadísticas según el objetivo del análisis;
8. generar visualizaciones;
9. interpretar los resultados;
10. estructurar y generar el reporte final.

## Problema identificado

El problema no consiste únicamente en generar un archivo PDF. El trabajo previo requiere coordinar múltiples etapas de análisis estadístico y posteriormente convertir sus resultados en un documento coherente y reproducible.

Para un usuario que repite este proceso sobre diferentes bases de datos, las tareas de preparación, cálculo, visualización, interpretación y documentación pueden representar una carga considerable de trabajo manual y aumentar la posibilidad de errores de ejecución o de presentación.

## Necesidad

La necesidad identificada es disponer de un sistema que permita recibir diferentes bases de datos estructuradas y coordinar un pipeline estadístico capaz de producir un reporte PDF de manera más eficiente y reproducible.

El alcance actual de ElBoss aborda esta necesidad mediante el subagente `reportero-estadistico`, que delega el procesamiento a un pipeline especializado.

## Delimitación

El proyecto no pretende automatizar de manera general toda la labor de un estadístico. El alcance inicial se concentra en la generación de reportes estadísticos a partir de bases de datos y deja otras capacidades estadísticas más avanzadas para futuras etapas.

## Línea base pendiente

La estimación inicial del proceso manual es de aproximadamente 30–45 minutos por reporte. Este intervalo proviene de la experiencia de uso y se considera únicamente una referencia preliminar.

La línea base cuantitativa se establecerá mediante una prueba controlada y se documentará en [`linea_base.md`](linea_base.md).
