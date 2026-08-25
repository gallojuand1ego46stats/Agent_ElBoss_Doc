# Guia de instalacion

## Requisitos previos

| Componente | Version minima | Como verificar |
|---|---|---|
| Python | 3.11+ | `python --version` |
| pip | 22.0+ | `pip --version` |
| MiKTeX (pdflatex) | 2022+ | `pdflatex --version` |
| Git | 2.30+ | `git --version` |

## Paso 1: Clonar el repositorio del pipeline

```bash
git clone https://github.com/gallojuand1ego46stats/pipeline-estadistico.git
cd pipeline-estadistico
```

## Paso 2: Crear entorno virtual

```bash
python -m venv .venv
```

En Windows (PowerShell):

```powershell
.venv\Scripts\Activate.ps1
```

En Linux/Mac:

```bash
source .venv/bin/activate
```

## Paso 3: Instalar dependencias

```bash
pip install -r requirements.txt
```

Dependencias principales:

| Paquete | Version | Para que sirve |
|---|---|---|
| pandas | >=3.0,<4.0 | Carga y manipulacion de datos |
| matplotlib | >=3.11 | Generacion de graficos |
| seaborn | >=0.13 | Graficos estadisticos mejorados |
| openpyxl | >=3.1 | Lectura de archivos Excel |
| pydantic | >=2.0 | Validacion de estructuras de datos |
| scipy | >=1.11 | Funciones estadisticas (IC, tests) |
| pytest | >=8.0 | Ejecucion de pruebas |

## Paso 4: Verificar instalacion

```bash
python scripts/main.py datos/iris.csv
```

Salida esperada:

- Mensajes de progreso por cada fase del pipeline
- Archivo `latex/iris.pdf` generado
- Archivos `figuras/*.png` generados

## Paso 5: Ejecutar tests (opcional)

```bash
pytest tests/ -v
```

Se esperan 42 tests pasando.

## Troubleshooting

| Problema | Solucion |
|---|---|
| `pdflatex no encontrado` | Instalar MiKTeX desde https://miktex.org/download y asegurar que este en PATH |
| `ModuleNotFoundError` | Verificar que el entorno virtual este activado y las dependencias instaladas |
| `FileNotFoundError` al ejecutar | Verificar que la ruta del dataset sea correcta y relativa a la raiz del proyecto |
| PDF no se genera | Ejecutar `pdflatex latex/<nombre>.tex` manualmente para ver errores LaTeX |

## Estructura del proyecto despues de instalar

```
pipeline-estadistico/
├── .venv/                  # Entorno virtual (no commiteado)
├── scripts/
│   ├── main.py             # Punto de entrada
│   ├── 01_explorar.py
│   ├── 02_descriptivo.py
│   ├── 03_visualizaciones.py
│   ├── 03_boxplot.py
│   ├── 04_reporte.py
│   └── 05_inferencia.py
├── tests/
│   ├── test_pipeline.py
│   ├── test_descriptivo.py
│   └── test_inferencia.py
├── datos/                  # Datasets de ejemplo
├── latex/                  # PDFs y .tex generados
├── figuras/                # PNGs generados
├── requirements.txt
├── .gitignore
└── README.md
```
