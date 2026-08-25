# Resumen ejecutivo

## Que es

ElBoss es un **sistema multiagente de analisis estadistico** construido sobre [opencode](https://opencode.ai) que automatiza la generacion de reportes estadisticos completos en PDF a partir de datasets CSV o Excel.

## Para que sirve

Convertir un dataset crudo en un **reporte estadistico profesional** con:

- Estadisticos descriptivos (tendencia central, dispersion, forma)
- Analisis de frecuencias para variables categoricas
- Intervalos de confianza (IC de media con t de Student, IC de proporcion con Wilson)
- Deteccion de outliers (metodo IQR/Tukey)
- Visualizaciones automaticas (boxplots, barras, histogramas)
- Documento LaTeX compilado a PDF con tablas y figuras

## Como funciona

```text
Usuario: "hazme un reporte de iris.csv"
        |
   [ El-Boss ]  ──delega──>  [ reportero-estadistico ]
                                    |
                              ejecuta pipeline Python
                                    |
                    carga → exploracion → descriptivos →
                    inferencia → visualizaciones → LaTeX/PDF
                                    |
                              devuelve rutas + resumen
        |
   [ El-Boss ]  ──resume──>  Usuario recibe PDF + metadata
```

## Que aporta

| Aspecto | Valor |
|---|---|
| **Tiempo manual estimado** | ~30-45 minutos por reporte |
| **Tiempo con ElBoss** | ~2-3 minutos (ejecucion automatica) |
| **Techniques cubiertas** | 11 (descriptivos, IC, outliers, asimetria, etc.) |
| **Tests** | 42 pruebas con verificacion matematica contra scipy |
| **Datasets probados** | 5 (iris, BI Estadistica Descriptiva, clientes, McDonald's, Drug Price) |
| **Formato de salida** | PDF via LaTeX con tablas formateadas y figuras PNG |

## Repositorios

| Repositorio | Contenido |
|---|---|
| [Agent_ElBoss_Doc](https://github.com/gallojuand1ego46stats/Agent_ElBoss_Doc) | Documentacion del sistema (este sitio) |
| [pipeline-estadistico](https://github.com/gallojuand1ego46stats/pipeline-estadistico) | Codigo del pipeline, tests, datasets, PDFs de ejemplo |

## Stack tecnico

- **Agente:** opencode (Grok como modelo base)
- **Pipeline:** Python 3.11, pandas, scipy, matplotlib, seaborn, pydantic
- **Reporte:** LaTeX (pdflatex via MiKTeX)
- **Documentacion:** MkDocs Material, desplegado en GitHub Pages
- **Tests:** pytest (42 tests, verificacion matematica con scipy)
