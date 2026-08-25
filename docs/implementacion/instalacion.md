# Guia de instalacion

Esta guia explica como instalar y configurar todo lo necesario para usar el sistema ElBoss: la documentacion (este repositorio) y el pipeline ejecutable (repositorio complementario).

---

## Que se va a instalar

El sistema consta de **2 repositorios** que trabajan juntos:

| Repositorio | Contenido | URL |
|---|---|---|
| **Agent_ElBoss_Doc** | Documentacion del sistema (MkDocs) | `https://github.com/gallojuand1ego46stats/Agent_ElBoss_Doc` |
| **pipeline-estadistico** | Codigo del pipeline, tests, datasets, PDFs | `https://github.com/gallojuand1ego46stats/pipeline-estadistico` |

- **Agent_ElBoss_Doc** es el sitio de documentacion navegable (GitHub Pages).
- **pipeline-estadistico** es el codigo que ejecuta el subagente `reportero-estadistico` para generar reportes PDF.

---

## Requisitos previos

Antes de empezar, verifica que tengas instalado:

| Componente | Version minima | Como verificar | Donde bajarlo |
|---|---|---|---|
| Python | 3.11+ | `python --version` | https://www.python.org/downloads/ |
| pip | 22.0+ | `pip --version` | Viene con Python |
| Git | 2.30+ | `git --version` | https://git-scm.com/downloads |
| MiKTeX | 2022+ | `pdflatex --version` | https://miktex.org/download |
| opencode | Cualquier version | `opencode --version` | https://opencode.ai |

> **Nota sobre MiKTeX:** Si `pdflatex` no se encuentra en la linea de comandos, asegurate de que MiKTeX este instalado y que su ruta este en el PATH del sistema. En Windows, la ruta por defecto es `C:\Program Files\MiKTeX\miktex\bin\x64\`.

---

## Paso 1: Clonar el repositorio de documentacion

```bash
git clone https://github.com/gallojuand1ego46stats/Agent_ElBoss_Doc.git
cd Agent_ElBoss_Doc
```

Este repo contiene:

- `docs/` — documentacion navegable (MkDocs)
- `docs/agentes/` — definiciones de El-Boss y reportero-estadistico
- `docs/justificacion/` — justificacion del proyecto
- `docs/implementacion/` — esta guia
- `mkdocs.yml` — configuracion del sitio

Para ver la documentacion localmente (opcional):

```bash
pip install mkdocs-material
mkdocs serve
```

Se abre en `http://127.0.0.1:8000`.

---

## Paso 2: Clonar el repositorio del pipeline

En un directorio separado (o donde prefieras):

```bash
git clone https://github.com/gallojuand1ego46stats/pipeline-estadistico.git
cd pipeline-estadistico
```

Este repo contiene:

- `scripts/` — codigo del pipeline Python
- `tests/` — 42 tests pytest
- `datos/` — datasets de ejemplo (iris, clientes, McDonald's, etc.)
- `latex/` — PDFs de evidencia generados
- `figuras/` — visualizaciones PNG
- `requirements.txt` — dependencias de Python

---

## Paso 3: Crear entorno virtual

Dentro de `pipeline-estadistico`:

```bash
python -m venv .venv
```

Activar el entorno virtual:

**Windows (PowerShell):**

```powershell
.venv\Scripts\Activate.ps1
```

**Windows (CMD):**

```cmd
.venv\Scripts\activate.bat
```

**Linux / Mac:**

```bash
source .venv/bin/activate
```

Verifica que este activado: el nombre del entorno debe aparecer al inicio de la linea de comandos:

```
(.venv) C:\Users\tu_usuario\pipeline-estadistico>
```

---

## Paso 4: Instalar dependencias

Con el entorno virtual activado:

```bash
pip install -r requirements.txt
```

Esto instala:

| Paquete | Version | Para que sirve |
|---|---|---|
| pandas | >=3.0,<4.0 | Carga y manipulacion de datos |
| matplotlib | >=3.11,<4.0 | Generacion de graficos |
| seaborn | >=0.13,<1.0 | Graficos estadisticos mejorados |
| openpyxl | >=3.1,<4.0 | Lectura de archivos Excel (.xlsx) |
| pydantic | >=2.0,<3.0 | Validacion de estructuras de datos |
| scipy | >=1.11,<2.0 | Funciones estadisticas (IC, tests) |
| pytest | >=8.0,<9.0 | Ejecucion de pruebas |

---

## Paso 5: Verificar que pdflatex funciona

```bash
pdflatex --version
```

Si sale un error, instala MiKTeX desde https://miktex.org/download y reinicia la terminal.

Para la primera ejecucion, MiKTeX puede pedir instalar paquetes LaTeX automaticamente. Responde "Yes" para instalarlos.

---

## Paso 6: Ejecutar el pipeline de prueba

Con el entorno virtual activado y dentro de `pipeline-estadistico`:

```bash
python scripts/main.py datos/iris.csv
```

Salida esperada:

1. Mensajes de progreso por cada fase del pipeline
2. Archivos generados en `figuras/` (PNGs)
3. Archivo `latex/iris.pdf` generado exitosamente

Si el PDF se genera, la instalacion esta correcta.

---

## Paso 7: Ejecutar los tests

```bash
pytest tests/ -v
```

Se esperan **42 tests pasando**. Los tests verifican:

- Integracion del pipeline completo (iris, clientes, McDonald's, Drug Price)
- Descriptivos numericos y categoricos
- Inferencia: IC de media (t de Student), IC de proporcion (Wilson)
- Deteccion de outliers (IQR/Tukey)
- Clasificacion de asimetria
- Casos extremos (dataset vacio, una sola observacion, constantes)
- Validacion Pydantic

---

## Paso 8: Configurar los agentes de opencode

El sistema ElBoss funciona con [opencode](https://opencode.ai). Los agentes y la skill deben estar en la carpeta de configuracion de opencode.

### 8.1 Copiar los agentes

Copia estos archivos desde `Agent_ElBoss_Doc/docs/agentes/` hacia `~/.config/opencode/agent/`:

| Archivo origen | Destino en opencode |
|---|---|
| `Agent_ElBoss_Doc/docs/agentes/El-Boss.md` | `~/.config/opencode/agent/El-Boss.md` |
| `Agent_ElBoss_Doc/docs/agentes/reportero-estadistico.md` | `~/.config/opencode/agent/reportero-estadistico.md` |

En Windows (PowerShell):

```powershell
Copy-Item "Agent_ElBoss_Doc\docs\agentes\El-Boss.md" "$env:USERPROFILE\.config\opencode\agent\El-Boss.md"
Copy-Item "Agent_ElBoss_Doc\docs\agentes\reportero-estadistico.md" "$env:USERPROFILE\.config\opencode\agent\reportero-estadistico.md"
```

### 8.2 Copiar la skill

Copia la carpeta de la skill:

```powershell
Copy-Item "Agent_ElBoss_Doc\docs\agentes\SKILL-reportes.md" "$env:USERPROFILE\.config\opencode\skill\reportes-estadisticos\SKILL.md"
```

### 8.3 Verificar la configuracion

```bash
opencode --version
```

Abre opencode y verifica que los agentes esten disponibles. El-Boss debe ser el agente principal y reportero-estadistico el subagente.

---

## Estructura final de ambos repos

```
C:\Users\tu_usuario\Projects\
├── Agent_ElBoss_Doc\                    # Documentacion
│   ├── docs/
│   │   ├── index.md
│   │   ├── arquitectura.md
│   │   ├── justificacion\
│   │   ├── agentes\
│   │   │   ├── El-Boss.md
│   │   │   ├── reportero-estadistico.md
│   │   │   ├── SKILL-reportes.md
│   │   │   ├── skills.md
│   │   │   └── guardrails.md
│   │   ├── implementacion\
│   │   │   └── instalacion.md           # Esta guia
│   │   ├── pruebas\
│   │   │   └── resultado_pruebas.md
│   │   └── sustentacion\
│   ├── mkdocs.yml
│   ├── sync-agents.ps1
│   └── AUDITORIA_MEGA_CHECKLIST.md
│
└── pipeline-estadistico\                # Codigo ejecutable
    ├── .venv\                           # Entorno virtual (no commiteado)
    ├── scripts\
    │   ├── main.py                      # Punto de entrada
    │   ├── 01_explorar.py
    │   ├── 02_descriptivo.py
    │   ├── 03_visualizaciones.py
    │   ├── 03_boxplot.py
    │   ├── 04_reporte.py
    │   └── 05_inferencia.py
    ├── tests\
    │   ├── test_pipeline.py
    │   ├── test_descriptivo.py
    │   └── test_inferencia.py
    ├── datos\                           # Datasets de ejemplo
    ├── latex\                           # PDFs generados
    ├── figuras\                         # PNGs generados
    ├── requirements.txt
    └── .gitignore
```

---

## Como se conectan ambos repos

```text
┌─────────────────────────────────────────────────────┐
│  Agent_ElBoss_Doc (documentacion)                    │
│                                                      │
│  docs/agentes/El-Boss.md  ──────────────────────┐   │
│  docs/agentes/reportero-estadistico.md  ────────┐│   │
│  docs/agentes/SKILL-reportes.md  ─────────────┐ ││   │
│                                               │ ││   │
│  Se copian a ~/.config/opencode/              │ ││   │
└───────────────────────────────────────────────┼─┼┼───┘
                                                │ ││
                                                ▼ ▼▼
┌─────────────────────────────────────────────────────┐
│  pipeline-estadistico (codigo ejecutable)            │
│                                                      │
│  El-Boss delega → reportero-estadistico ejecuta:     │
│  python scripts/main.py <dataset>                    │
│                                                      │
│  Salidas: latex/*.pdf, figuras/*.png                 │
└─────────────────────────────────────────────────────┘
```

**Flujo:** El usuario le pide a El-Boss (via opencode) que genere un reporte. El-Boss delega al reportero-estadistico, que ejecuta `python scripts/main.py` en `pipeline-estadistico`. El PDF generado se guarda en `pipeline-estadistico/latex/`.

---

## Troubleshooting

| Problema | Solucion |
|---|---|
| `pdflatex no encontrado` | Instalar MiKTeX desde https://miktex.org/download y agregar al PATH |
| `ModuleNotFoundError` | Verificar que el entorno virtual este activado: `pip list` debe mostrar las dependencias |
| `FileNotFoundError` al ejecutar | Verificar que la ruta del dataset sea correcta y relativa a la raiz de `pipeline-estadistico` |
| PDF no se genera | Ejecutar `pdflatex latex/<nombre>.tex` manualmente para ver errores LaTeX |
| MiKTeX pide instalar paquetes | Responder "Yes" — es normal en la primera ejecucion |
| `opencode` no encuentra los agentes | Verificar que los archivos esten en `~/.config/opencode/agent/` y la skill en `~/.config/opencode/skill/reportes-estadisticos/` |
| ` gh auth` pide permisos | Ejecutar `gh auth login` y seguir las instrucciones |
