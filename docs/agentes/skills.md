# Skills del sistema

## Skill: reportes-estadisticos

| Campo | Valor |
|---|---|
| **Nombre** | `reportes-estadisticos` |
| **Proposito** | Generar reportes estadisticos completos en PDF a partir de datasets |
| **Archivo** | `~/.config/opencode/skill/reportes-estadisticos/SKILL.md` |
| **Cuando se usa** | El usuario pide un reporte estadistico, analisis descriptivo, o PDF desde un dataset |

### Herramientas utilizadas

| Herramienta | Tipo | Entrada | Salida | Descripcion |
|---|---|---|---|---|
| `Bash` | Ejecucion | Comando shell | stdout/stderr | Ejecuta el pipeline Python via `python scripts/main.py` |
| `Task` | Delegacion | Prompt del coordinador | Respuesta del subagente | El-Boss delega al reportero-estadistico |
| `Read` | Lectura | Ruta de archivo | Contenido | Verifica existencia de PDFs generados |
| `Glob` | Busqueda | Patron glob | Lista de rutas | Encuentra archivos de salida (figuras, PDFs) |

### Pipeline interno (scripts/main.py)

| Fase | Script | Entrada | Salida |
|---|---|---|---|
| Carga | `main.py` | Ruta/URL de dataset | DataFrame pandas |
| Exploracion | `01_explorar.py` | DataFrame | Estructura, tipos, nulos, duplicados |
| Descriptivos | `02_descriptivo.py` | DataFrame | Medidas numericas y categoricas |
| Visualizaciones | `03_visualizaciones.py`, `03_boxplot.py` | DataFrame | PNG en `figuras/` |
| Inferencia | `05_inferencia.py` | DataFrame | IC, outliers, asimetria |
| Reporte | `04_reporte.py` | Resultados + plantilla | `.tex` → `.pdf` en `latex/` |

### Formato de datos

- **Entrada soportada:** CSV (`.csv`), Excel (`.xlsx`, `.xls`)
- **Salida generada:** PDF (via LaTeX), PNG (figuras), TEX (fuente LaTeX)
- **Directorio de trabajo:** raiz del proyecto `reportes-estadisticos/`
