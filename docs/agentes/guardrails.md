# Guardrails

Lista formal de restricciones que el sistema respeta durante la ejecucion.

## Guardrails del pipeline (reportero-estadistico)

| # | Restriccion | Por que | Consecuencia si se viola |
|---|---|---|---|
| G1 | **No modificar el codigo del pipeline** salvo orden explicita del usuario | Mantener integridad del codigo probado | Regresion en tests existentes |
| G2 | **No parchar archivos .tex** generados | El pipeline regenera el .tex completo en cada ejecucion | El parche se pierde y crea confusion |
| G3 | **No eliminar ni sobrescribir reportes de otros datasets** | Cada dataset tiene su propio PDF en `latex/` | Perdida de trabajo previo |
| G4 | **No imputar valores faltantes** | Los resultados deben reflejar los datos reales | Sesgo en estadisticos |
| G5 | **No eliminar outliers** | La deteccion es informativa, no prescriptiva | Perdida de informacion valiosa |
| G6 | **No ejecutar pruebas de hipotesis** no solicitadas | El pipeline es descriptivo, no inferencial | Resultados irrelevantes o confusos |
| G7 | **Detenerse ante errores fatales** | Un dataset corrupto no debe generar un reporte erroneo | Reporte con datos incompletos o incorrectos |

## Guardrails del coordinador (El-Boss)

| # | Restriccion | Por que |
|---|---|---|
| G8 | **Siempre delegar al subagente** para tareas del pipeline | El-Boss coordina, no ejecuta codigo estadistico |
| G9 | **No inventar resultados** | Los numeros deben venir del pipeline, no de la IA |
| G10 | **Reportar errores tal cual** | El usuario necesita saber si algo fallo |

## Guardrails de seguridad

| # | Restriccion | Evidencia |
|---|---|---|
| G11 | **No exponer API keys o tokens** | Verificado: sin `.env`, sin tokens hardcodeados en ningun repo |
| G12 | **No commitear `.venv/`** | `.gitignore` excluye directorios de entorno virtual |
| G13 | **No ejecutar codigo externo no verificado** | Solo se ejecuta el pipeline local y sus dependencias en `requirements.txt` |
