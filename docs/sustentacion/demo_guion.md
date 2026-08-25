# Guion de demostración (~10 minutos)

Demostración en vivo de ElBoss ante el profesor.

---

## Preparación previa (antes de la demo)

1. Verificar que opencode esté funcionando y autenticado.
2. Tener un dataset de prueba listo: `C:\Users\juand\Projects\reportes-estadisticos\datos\iris.csv` (o cualquier CSV).
3. Abrir una terminal en la raíz del proyecto.
4. Verificar que pdflatex (MiKTeX) esté instalado.

---

## Secuencia de demostración

### Minuto 0-1: Presentación del problema (2 min)

> "ElBoss es un agente de IA para análisis estadístico. El problema que resuelve es la generación manual de reportes estadísticos, que requiere cargar datos, verificar estructura, tipificar, explorar, calcular descriptivos, hacer inferencia, generar visualizaciones y estructurar un reporte PDF. Esto toma aproximadamente 30-45 minutos de manera manual."

Mostrar la pantalla con el `docs/justificacion/problema.md` o simplemente describir los 10 pasos.

---

### Minuto 1-3: Arquitectura del sistema (2 min)

> "La arquitectura separa tres componentes:"

Mostrar `docs/arquitectura.md` con el diagrama Mermaid.

> "ElBoss recibe la solicitud del usuario, delega al subagente reportero-estadistico, que ejecuta un pipeline Python con 7 pasos: carga, tipificación, exploración, descriptivos, inferencia, visualizaciones y reporte LaTeX/PDF."

---

### Minuto 3-7: Demo en vivo (4 min)

Abrir terminal y ejecutar:

```powershell
cd C:\Users\juand\Projects\reportes-estadisticos
& ".venv\Scripts\python.exe" scripts\main.py "datos\iris.csv"
```

**Mientras se ejecuta, narrar:**

> "El pipeline está procesando iris.csv — un dataset de 150 filas, 5 columnas, con variables numéricas y categóricas."

Mostrar en pantalla:
- Paso 1: carga → "Filas: 150 | Columnas: 5"
- Paso 2: tipificación → numéricas vs categóricas
- Paso 3: exploración → estructura, tipos, nulos
- Paso 4: descriptivos → media, mediana, desviación, cuartiles
- Paso 5: inferencia → intervalos de confianza, outliers, advertencias
- Paso 6: visualizaciones → "9 figura(s) generada(s)"
- Paso 7: reporte LaTeX → compilación a PDF

**Verificar el PDF generado:**

```powershell
explorer "latex\iris.pdf"
```

> "En menos de 1 minuto, ElBoss generó un reporte estadístico completo con exploración, estadística descriptiva, inferencia básica y visualizaciones."

---

### Minuto 7-9: Evidencia de robustez (2 min)

Mostrar la carpeta `latex/`:

> "Aquí hay 5 reportes generados con diferentes datasets."

Mostrar brevemente:
- `BI_Estadistica_Descriptiva.pdf` — dataset real de 3,998 filas
- `clientes_datos_faltantes.pdf` — dataset con datos faltantes
- `Drug_Price.pdf` — formato Excel

> "El pipeline maneja datos faltantes, diferentes formatos y datasets de distintos tamaños."

Mostrar `tests/`:

> "Existen 40+ tests que verifican la corrección matemática de los cálculos contra fórmulas manuales independientes."

---

### Minuto 9-10: Cierre (1 min)

> "ElBoss demuestra: separación de responsabilidades (agente/pipeline), verificación matemática (tests), manejo de errores (sin resultados falsos), protección de datos (.gitignore) y un MVP funcional que resuelve un problema real de análisis estadístico."

> "Las limitaciones están documentadas: no procesa datasets enormes, no incluye pruebas de supuestos, y la capa de agente depende del servicio de IA."

---

## Puntos de contingencia

Si **falla la ejecución en vivo:**
- Mostrar los PDFs ya generados como evidencia de ejecuciones anteriores.
- Explicar que el pipeline es determinista: mismo dataset → mismo resultado.

Si **preguntan sobre el modelo de IA:**
- "Utiliza opencode como plataforma. El modelo es el proporcionado por defecto. Los cálculos estadísticos son deterministas y no dependen del modelo."

Si **preguntan por qué no es solo un script:**
- "Un script requiere que el usuario adapte la entrada. ElBoss interpreta la solicitud y adapta el procesamiento. Además, la arquitectura permite agregar nuevos subagentes sin reconstruir el sistema."

---

## Materiales de apoyo

- `docs/justificacion/` — justificación completa del proyecto
- `docs/arquitectura.md` — diagrama del sistema
- `AUDITORIA_MEGA_CHECKLIST.md` — evidencia de verificación de cada requisito
- `latex/*.pdf` — reportes generados como evidencia
- `tests/` — 40+ tests de verificación matemática
