# Skill: reportes-estadisticos

> Copia sincronizada automaticamente desde `~/.config/opencode`. No editar aqui: usar `sync-agents.ps1`.

# Reportes Estadísticos

Pipeline listo para usar en `~/Projects\reportes-estadisticos`.

## Cuándo usar esta skill

- El usuario pide un "reporte estadístico", un "análisis descriptivo" o un PDF a partir de un dataset.
- El usuario entrega un CSV/Excel local o una URL y quiere analizarlo estadísticamente.

## Cómo ejecutar

1. Fija como directorio de trabajo `~/Projects\reportes-estadisticos`.
2. Ejecuta el pipeline completo (carga, tipificación, exploración, descriptivos, inferencia básica, visualizaciones, LaTeX/PDF):

   ```
   & ".venv\Scripts\python.exe" scripts\main.py "<ruta-o-url-del-dataset>"
   ```

3. Salidas esperadas:
   - Figuras PNG en `figuras/`.
   - `.tex` y `.pdf` en `latex/` con el nombre del dataset saneado.

## Reglas

- No modificar el código del pipeline salvo petición explícita del usuario.
- Si el PDF no se genera, verificar que pdflatex (MiKTeX) esté instalado y accesible; reportar el error sin parchar el `.tex`.
- Si ya existe un reporte para el mismo dataset, regenerarlo es seguro; no tocar reportes de otros datasets.
- Tratar los resultados como descriptivos: sin pruebas de hipótesis, sin imputaciones, sin eliminar outliers.


