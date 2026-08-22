# Agent_ElBoss_Doc

![Deploy Docs](https://github.com/gallojuand1ego46stats/Agent_ElBoss_Doc/actions/workflows/docs.yml/badge.svg)

Documentacion del **sistema multiagente de analisis estadistico** construido sobre [opencode](https://opencode.ai):

- **El-Boss**: agente principal (coordinador). Recibe las peticiones y delega.
- **reportero-estadistico**: subagente especializado que ejecuta el pipeline de reportes PDF.
- **Skill `reportes-estadisticos`**: instrucciones reutilizables para invocar el pipeline.

## Sitio web

La documentacion navegable se publica automaticamente en:

> <https://gallojuand1ego46stats.github.io/Agent_ElBoss_Doc/>

## Como funciona

```text
Usuario pide un reporte
        |
        v
   [ El-Boss ]  --delega con Tool Task-->  [ reportero-estadistico ]
                                                 |
                                    lee SKILL.md y ejecuta:
                                    .venv/Scripts/python.exe scripts/main.py "<dataset>"
                                                 |
                                   carga -> tipificacion -> exploracion ->
                                   descriptivos -> inferencia -> visualizaciones ->
                                   LaTeX/PDF
```

## Estructura del repositorio

| Ruta | Contenido |
|---|---|
| `docs/index.md` | Introduccion al sistema |
| `docs/arquitectura.md` | Diagrama y flujo de delegacion |
| `docs/agentes/` | Copias sincronizadas de los agentes vivos |
| `docs/guia-actualizacion.md` | Como mantener este sitio |
| `sync-agents.ps1` | Script que copia y sanitiza los agentes desde `~/.config/opencode` |
| `.github/workflows/docs.yml` | Publica el sitio en GitHub Pages con cada push |

## Actualizar la documentacion

Los archivos en `docs/agentes/` son **copias** de los agentes vivos. Para actualizarlos:

```powershell
powershell -ExecutionPolicy Bypass -File sync-agents.ps1
git add .
git commit -m "docs: sincronizar agentes"
git push
```

El push dispara el workflow que reconstruye y redespliega el sitio solo.
