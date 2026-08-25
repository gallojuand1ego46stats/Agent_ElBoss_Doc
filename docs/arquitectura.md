# Arquitectura del sistema

## Diagrama general

```mermaid
flowchart LR
    U["Usuario"] -->|"pide un reporte"| EB["El-Boss<br/>agente principal"]
    EB -->|"Tool Task (delegacion)"| RE["reportero-estadistico<br/>subagente"]
    RE -->|"consulta"| SK["SKILL.md<br/>skill reportes-estadisticos"]
    RE -->|"ejecuta"| PY["scripts/main.py<br/>pipeline Python"]
    PY --> P1["01 Explorar"]
    PY --> P2["02 Descriptivo"]
    PY --> P3["03 Visualizaciones"]
    PY --> P4["04 Reporte LaTeX"]
    PY --> P5["05 Inferencia"]
    P3 --> OUT1["figuras/*.png"]
    P4 --> OUT2["latex/*.pdf + .tex"]
```

## Flujo de delegacion paso a paso

1. El usuario pide algo como *"hazme un analisis descriptivo de datos.csv"*.
2. **El-Boss** identifica la intencion y delega al subagente `reportero-estadistico` mediante la Tool Task, incluyendo:
   - La ruta o URL exacta del dataset.
   - Requisitos especiales indicados por el usuario.
3. El subagente fija el directorio de trabajo en la raiz del proyecto y ejecuta:

   ```powershell
   & "~/Projects/reportes-estadisticos/.venv/Scripts/python.exe" scripts\main.py "<fuente>"
   ```

4. El pipeline procesa el dataset por fases y compila el PDF con pdflatex (MiKTeX).
5. El subagente verifica las salidas y devuelve al coordinador:
   - Rutas exactas de `.tex`, `.pdf` y figuras.
   - Resumen breve (filas, columnas, advertencias).
6. **El-Boss** resume todo al usuario.

## Mapeo detallado del flujo

```mermaid
flowchart TD
    A["1. Usuario solicita reporte"] --> B["2. El-Boss identifica intencion"]
    B --> C["3. El-Boss delega via Tool Task"]
    C --> D["4. reportero-estadistico recibe petition"]
    D --> E{"5. Valida fuente del dataset"}
    E -->|"Existe"| F["6. Ejecuta main.py"]
    E -->|"No existe"| G["Reporta error y se detiene"]
    F --> H["7. Pipeline: carga + tipificacion"]
    H --> I["8. Pipeline: exploracion (01_explorar.py)"]
    I --> J["9. Pipeline: descriptivos (02_descriptivo.py)"]
    J --> K["10. Pipeline: inferencia (05_inferencia.py)"]
    K --> L["11. Pipeline: visualizaciones (03_*.py)"]
    L --> M{"12. Visualizaciones OK?"}
    M -->|"Si"| N["13. Pipeline: reporte LaTeX (04_reporte.py)"]
    M -->|"Fallo"| O["Advertencia, continua sin figuras"]
    O --> N
    N --> P{"14. pdflatex OK?"}
    P -->|"Si"| Q["15. Subagente verifica salidas"]
    P -->|"Fallo"| R["Reporta error LaTeX"]
    Q --> S["16. Subagente devuelve resultado a El-Boss"]
    S --> T["17. El-Boss resume al usuario"]
```

### Validacion en cada fase

| Fase | Que valida | Si falla |
|---|---|---|
| Carga | Archivo existe, formato soportado, no vacio | Detiene pipeline, informa error |
| Tipificacion | Al menos 1 variable numerica util | Detiene pipeline, informa error |
| Exploracion | Estructura del DataFrame | Continua con advertencia |
| Descriptivos | Valores numericos disponibles | Calcula sobre valores validos |
| Inferencia | n >= 2 para IC, categorias para proporciones | Genera notas de no-calificabilidad |
| Visualizaciones | Datos suficientes para graficar | Continua sin figuras (no fatal) |
| LaTeX | pdflatex instalado y funcionando | Informa que PDF no se pudo generar |

## Fases del pipeline

| Fase | Script | Salida |
|---|---|---|
| Exploracion | `01_explorar.py` | Estructura, tipos, nulos, duplicados |
| Descriptivos | `02_descriptivo.py` | Medidas resumen numericas y categoricas |
| Visualizaciones | `03_visualizaciones.py`, `03_boxplot.py` | PNG en `figuras/` |
| Reporte | `04_reporte.py` | LaTeX -> PDF en `latex/` |
| Inferencia | `05_inferencia.py` | Pruebas basicas complementarias |

## Manejo de errores del pipeline

| Error | Deteccion | Respuesta | Mensaje al usuario |
|---|---|---|---|
| Archivo no encontrado | `FileNotFoundError` en carga | Pipeline se detiene | "Error al cargar: [detalle]" |
| Formato no soportado | `ValueError` en carga | Pipeline se detiene | "Error al cargar: [detalle]" |
| Dataset vacio (0 filas/columnas) | Verificacion en `main.py:72-74` | Pipeline se detiene | "El dataset esta vacio" |
| Variables sin utilidad | Verificacion en `main.py:81-83` | Pipeline se detiene | "No contiene variables utiles" |
| Fallo en visualizaciones | `Exception` en `main.py:149-153` | Continua sin figuras | "Advertencia: Error generando visualizaciones" |
| Fallo compilacion LaTeX | Verificacion en `main.py:196-197` | Informa sin resultado PDF | "PDF: No se pudo generar (ver errores arriba)" |
| Valores faltantes | Manejado por pandas/scipy | Calcula sobre valores validos | Advertencia en resultados |

## Reglas de convivencia entre agentes

- El subagente **no modifica** el codigo del pipeline salvo orden explicita del usuario.
- Si pdflatex falla, se reporta el error tal cual; no se parchea el `.tex`.
- Regenerar el PDF de un dataset es seguro; nunca se tocan reportes de otros datasets.

## Conexion entre este documento y el pipeline

Este repositorio (`Agent_ElBoss_Doc`) documenta la arquitectura del sistema. El codigo ejecutable se encuentra en un repositorio separado:

| Este repositorio (docs) | Repositorio del pipeline (codigo) |
|---|---|
| `docs/arquitectura.md` → describe el flujo | `scripts/main.py` → implementa el flujo |
| `docs/agentes/*.md` → definen roles y reglas | `tests/` → verifican que el codigo cumple |
| `docs/justificacion/` → por que existe el sistema | `datos/` → datasets de prueba |
| `docs/pruebas/` → resultados documentados | `latex/` → PDFs generados |
| `docs/implementacion/` → como instalar | `requirements.txt` → dependencias |

**Para ejecutar el sistema:** clonar `pipeline-estadistico`, crear venv, instalar dependencias, ejecutar `python scripts/main.py <dataset>`. Ver `docs/implementacion/instalacion.md` para guia completa.
