# Preguntas difíciles de sustentación

Guía de preparación para la defensa oral del proyecto ElBoss.

---

## 1. ¿Por qué esto necesita un agente?

Un script determinista puede ejecutar una secuencia fija de cálculos sobre una entrada conocida. ElBoss incorpora una capa de agente para **coordinar solicitudes variables** del usuario (distintos datasets, distintos formatos, distintas peticiones) y delegar la tarea al subagente especializado.

El pipeline Python conserva el carácter determinista de los cálculos estadísticos. El agente aporta **coordinación, delegación y extensibilidad**.

---

## 2. ¿Por qué no solo un script?

Porque el usuario puede entregar diferentes bases de datos y formular solicitudes que requieren interpretar la tarea y seleccionar el procesamiento apropiado. Un script fijo requiere que el usuario adapte la entrada al formato esperado; un agente adapta el procesamiento a la entrada recibida.

---

## 3. ¿Por qué esta arquitectura (agente → subagente → skill → pipeline)?

Permite separar responsabilidades:

| Componente | Responsabilidad |
|---|---|
| ElBoss (agente principal) | Recibe la solicitud, delega, resume al usuario |
| reportero-estadistico (subagente) | Ejecuta el pipeline de reportes |
| Skill | Instrucciones y criterios operativos |
| Pipeline Python | Procesamiento estadístico determinista |

Esta separación permite agregar nuevos subagentes sin reconstruir la arquitectura principal.

---

## 4. ¿Qué modelo de IA utiliza ElBoss?

ElBoss se ejecuta sobre la plataforma **opencode**. El modelo de lenguaje es el proporcionado por defecto por la plataforma. La configuración actual (`opencode.jsonc`) no especifica un modelo particular.

**Limitación reconocida:** la capa de agente depende del proveedor de IA. Si el servicio de lenguaje cambia o falla, la coordinación se ve afectada, pero el pipeline Python puede ejecutarse directamente.

---

## 5. ¿Qué pasa si falla el modelo de IA?

Si el modelo de lenguaje no responde, ElBoss no puede procesar la solicitud. Sin embargo:

- El pipeline Python puede ejecutarse directamente desde la línea de comandos.
- La documentación incluye los comandos exactos para ejecutar el pipeline sin el agente.
- El sistema de error del pipeline informa fallos sin resultados falsos.

---

## 6. ¿Qué pasa si el dataset es enorme?

El pipeline actual carga el dataset completo en memoria (pandas). Para datasets extremadamente grandes (>varios GB), el pipeline podría agotar memoria.

**Estado actual:** no se ha implementado procesamiento por lotes. Esta limitación está documentada y es candidata para futuras mejoras.

---

## 7. ¿Qué pasa si hay datos faltantes?

El pipeline maneja valores faltantes de manera controlada:

- **Exploración:** reporta la cantidad y porcentaje de faltantes por columna.
- **Descriptivos:** calcula estadísticas sobre valores válidos (ignora NaN automáticamente).
- **Inferencia:** clasifica la calidad de la muestra según proporción de faltantes y genera advertencias.

El dataset `clientes_datos_faltantes.csv` fue utilizado específicamente para verificar esta capacidad (evidencia: `clientes_datos_faltantes.pdf` generado exitosamente).

---

## 8. ¿Qué pasa si los datos son confidenciales?

**Protección de datos implementada:**

- `.gitignore` agresivo bloquea `*.csv`, `*.xlsx`, `datos/`, `resultados/`.
- Los datasets nunca se publican en GitHub.
- Solo suben código y documentación.
- No se utilizan servicios externos de almacenamiento de datos.
- Los cálculos se ejecutan localmente.

---

## 9. ¿Qué pasa si el PDF no puede generarse?

El pipeline detecta fallos de compilación LaTeX y los reporta sin resultados falsos:

```python
if ruta_pdf:
    print(f"  PDF:    {ruta_pdf}")
else:
    print("  PDF:    No se pudo generar (ver errores arriba)")
```

El subagente transfiere esta información al usuario.

---

## 10. ¿Qué pasa si el agente inventa una interpretación?

**Guardarraíles implementados:**

- El pipeline calcula estadísticos usando fórmulas matemáticas verificables (scipy, numpy, pydantic).
- Los tests verifican resultados matemáticos contra cálculos manuales independientes.
- El agente no genera interpretaciones estadísticas; el pipeline las produce.
- La documentación declara explícitamente: "El lenguaje natural generado por el agente no sustituye la validación de los cálculos estadísticos."

---

## 11. ¿Cómo verifican los cálculos estadísticos?

**Tests de verificación matemática:**

- `test_verificacion_matematica_iris`: verifica IC de media contra fórmula manual con scipy.
- `test_verificacion_matematica_setosa`: verifica IC de proporción (Wilson) contra fórmula manual.
- `test_no_nan_en_resultados`: verifica que resultados numéricos no contengan NaN no controlado.
- Tests de Pydantic: verifican validación de entrada/salida de modelos de datos.

**Evidencia:** 40+ tests en 3 archivos, ejecutados con pytest.

---

## 12. ¿Cómo saben que el agente aporta valor?

La línea base manual (estimada en ~30-45 min) será comparada contra ElBoss mediante un protocolo controlado documentado en `linea_base.md`.

**Aporte cualitativo actual:**
- Eliminación de pasos repetitivos de carga, tipificación y exploración.
- Generación automática de visualizaciones estandarizadas.
- Reporte PDF estructurado con interpretación estadística.
- Reproducibilidad: mismo dataset → mismo resultado.

---

## 13. ¿Cuál fue la principal limitación?

**Limitación técnica:** el pipeline actual carga datasets completos en memoria (pandas). No soporta procesamiento de datasets que excedan la RAM disponible.

**Limitación de alcance:** el MVP se concentra en reportes estadísticos descriptivos. No incluye pruebas de hipótesis avanzadas, selección automática de modelos, o tratamiento de datos faltantes.

**Limitación de la IA:** la capa de agente depende del servicio de lenguaje del proveedor. Si el servicio falla, la coordinación se ve afectada.

---

## 14. ¿Qué cambiarían en una segunda versión?

1. **Publicación del pipeline** como repositorio independiente para reproducibilidad completa.
2. **Procesamiento por lotes** para datasets grandes.
3. **Subagente de pruebas de supuestos** (evaluación de normalidad, homocedasticidad).
4. **Subagente de tratamiento de datos faltantes** con estrategias estadísticamente fundamentadas.
5. **Métricas de rendimiento** integradas (tiempo de ejecución, calidad del reporte).

---

## 15. ¿Qué parte del sistema realmente utiliza IA?

| Componente | Usa IA |
|---|---|
| ElBoss (coordinación) | Sí — interpreta la solicitud del usuario y delega |
| reportero-estadistico (ejecución) | Sí — interpreta la skill y ejecuta el pipeline |
| Pipeline Python (cálculos) | **No** — determinista (pandas, scipy, matplotlib) |
| Generación LaTeX/PDF | **No** — determinista (pdflatex) |

---

## 16. ¿Qué parte es determinista?

Todo el procesamiento estadístico:

- Cálculos de tendencia central, dispersión, cuartiles, CV.
- Coeficientes de asimetría y curtosis.
- Frecuencias y proporciones.
- Intervalos de confianza (t de Student, Wilson).
- Detección de outliers (IQR/Tukey).
- Generación de visualizaciones (matplotlib/seaborn).
- Compilación LaTeX → PDF.

---

## 17. ¿Por qué no automatizaron también pruebas de supuestos?

Porque las pruebas de supuestos (Shapiro-Wilk, Levene, Anderson-Darling, etc.) requieren:

1. **Decisiones metodológicas** que dependen del contexto (¿qué supuestos? ¿qué nivel de significancia? ¿qué hacer si se viola?).
2. **Validación estadística rigurosa** para evitar recomendaciones incorrectas.
3. **Alcance controlable** — se priorizó completar el flujo de reporte antes de agregar capacidades más complejas.

Se documenta como capacidad futura en `docs/justificacion/alternativas.md`.

---

## 18. ¿Qué capacidades futuras tendría ElBoss?

Según la documentación de alcance:

- Tratamiento especializado de datos faltantes.
- Evaluación de supuestos.
- Selección y aplicación de pruebas estadísticas según contexto.
- Nuevos subagentes estadísticos especializados.
- Procesamiento por lotes para datasets grandes.

Cada capacidad nueva debe cumplir 5 criterios: definición precisa, implementación reproducible, validación estadística, pruebas con casos normales/límite, y documentación en la arquitectura.
