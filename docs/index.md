# Sistema multiagente de analisis estadistico

Documentacion oficial del agente **El-Boss** y su ecosistema de subagentes para la generacion automatica de reportes estadisticos en PDF.

## Que resuelve

Automatiza el ciclo completo de un analisis estadistico: desde que el usuario entrega un dataset (CSV/Excel local o URL) hasta que obtiene un reporte PDF profesional con exploracion, descriptivos, inferencia basica y visualizaciones.

## Componentes

| Componente | Rol | Definicion viva |
|---|---|---|
| **El-Boss** | Agente principal: recibe peticiones, coordina y resume resultados | `~/.config/opencode/agent/El-Boss.md` |
| **reportero-estadistico** | Subagente ejecutor del pipeline de reportes | `~/.config/opencode/agent/reportero-estadistico.md` |
| **Skill reportes-estadisticos** | Manual de invocacion del pipeline | `~/.config/opencode/skill/reportes-estadisticos/SKILL.md` |
| **Pipeline Python** | Motor de analisis (scripts/main.py) | `~/Projects/reportes-estadisticos` |

## Recorrido rapido

1. [Arquitectura](arquitectura.md) - como se comunican los componentes.
2. [Agentes](agentes/El-Boss.md) - instrucciones exactas de cada agente (copias sincronizadas).
3. [Guia de actualizacion](guia-actualizacion.md) - como mantener esta documentacion al dia.

## Principios de diseno

- **Delegacion obligatoria**: El-Boss nunca ejecuta el pipeline directamente; siempre delega al subagente.
- **Fuente unica de verdad**: los agentes viven en `~/.config/opencode`; este sitio publica copias sanitizadas generadas por `sync-agents.ps1`.
- **Reportes descriptivos**: sin imputaciones ni eliminacion de outliers salvo peticion explicita.
