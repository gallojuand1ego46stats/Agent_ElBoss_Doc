# Resultados de pruebas del pipeline

Evidencia de verificacion del pipeline `reportes-estadisticos`.

## Resumen

| Metrica | Valor |
|---|---|
| Total de tests | 42 |
| Archivos de test | 3 (test_pipeline.py, test_descriptivo.py, test_inferencia.py) |
| Framework | pytest |
| Estado | Todos pasan |

## Pruebas de integracion (test_pipeline.py)

| Test | Dataset | Condicion | Resultado | Evidencia |
|---|---|---|---|---|
| test_iris | iris.csv (150 filas, 5 cols) | Dataset normal con mix de var numericas y categoricas | PASS | iris.pdf (231 KB, 34 PNGs) |
| test_clientes | clientes_datos_faltantes.csv (250 filas) | Datos faltantes en multiples columnas | PASS | clientes_datos_faltantes.pdf (309 KB) |
| test_drug_price | Drug Price.xlsx | Formato Excel (.xlsx) | PASS | Drug_Price.pdf (276 KB) |
| test_mcdonalds | Datos historicos de McDonald's.csv | Dataset real de acciones | PASS | Datos_historicos_de_McDonalds.pdf (238 KB) |
| test_descriptivos_una_sola_vez | iris.csv | Verificar que calcular_descriptivos se ejecuta exactamente 1 vez | PASS | Sin redundancia computacional |
| test_no_nan_en_resultados | iris.csv | Resultados numericos no deben contener NaN no controlado | PASS | media y desv estandar validos |

## Pruebas unitarias (test_descriptivo.py)

| Test | Verificacion | Resultado |
|---|---|---|
| test_iris | Calcula descriptivos para iris (150 filas) | PASS |
| test_ejecuta_una_vez | Completar en <5 segundos | PASS |
| test_clientes | Maneja clientes con faltantes (250 filas) | PASS |
| test_cols_numericas_presentes | Identifica sepal_length como numerica | PASS |
| test_stats_numericas_indices | Indices: n, media, mediana, desviacion, min, max | PASS |

## Pruebas de inferencia (test_inferencia.py)

### IC de media (t de Student)

| Test | Caso | Resultado |
|---|---|---|
| test_caso_normal | 10 observaciones normales | PASS |
| test_n_2 | Minimo para IC | PASS |
| test_n_menos_de_2 | 1 obs: IC no calculable | PASS |
| test_std_cero | Constantes (7,7,7,7,7) | PASS (IC = [7.0, 7.0]) |
| test_valores_faltantes | NaN intercalados | PASS |
| test_valores_negativos | Negativos y cero | PASS |
| test_verificacion_matematica_iris | Compara contra scipy.stats.t manual | PASS (error <0.0001) |

### IC de proporcion (Wilson)

| Test | Caso | Resultado |
|---|---|---|
| test_p_cero | 0 exitos de 100 | PASS (LI = 0.0) |
| test_p_uno | 100 exitos de 100 | PASS (LS = 1.0) |
| test_p_cercano_cero | 1/1000 | PASS |
| test_p_cercano_uno | 999/1000 | PASS |
| test_n_pequeno | 1/10 | PASS |
| test_n_grande | 500/1000 | PASS |
| test_n_cero | 0/0 | PASS (None) |
| test_verificacion_matematica_setosa | Compara contra formula Wilson manual | PASS (error <0.0001) |

### Outliers (IQR/Tukey)

| Test | Caso | Resultado |
|---|---|---|
| test_sin_outliers | 1..10 | PASS (0 outliers) |
| test_outlier_superior | 1..9 + 100 | PASS (1 outlier) |
| test_outlier_inferior | -100 + 2..10 | PASS (1 outlier) |
| test_valores_en_limite | Valor exacto en umbral IQR | PASS (no es outlier) |
| test_menos_de_4_obs | n=3 | PASS (0 outliers) |
| test_iqr_cero | Constantes | PASS (0 outliers) |

### Clasificacion de asimetria

| Test | Caso | Resultado |
|---|---|---|
| test_aprox_simetrica | skew = 0.0, 0.3, -0.3 | PASS |
| test_asimetria_moderada | skew = 0.6, -0.7, 0.99 | PASS |
| test_asimetria_marcada | skew = 1.0, -1.5, 3.0 | PASS |
| test_frontera_0_5 | 0.5 -> MODERADA | PASS |
| test_frontera_1_0 | 1.0 -> MARCADA | PASS |

### Casos extremos (calcular_inferencia)

| Test | Caso | Resultado |
|---|---|---|
| test_dataset_vacio | DataFrame vacio | PASS (0 resultados) |
| test_todos_nan | [NaN, NaN, NaN] | PASS (n_valido=0, IC=None) |
| test_una_sola_observacion | [42.0] | PASS (n_valido=1, IC=None) |
| test_dos_observaciones | [10.0, 20.0] | PASS (IC calculable) |
| test_variable_constante | 50 observaciones de 7.0 | PASS (IC=[7.0, 7.0], adv: variabilidad_nula) |
| test_categoria_unica | ["A"] x 10 | PASS (prop=1.0, LS=1.0) |
| test_muchos_valores_faltantes | 90 NaN + 10 obs | PASS (advertencias generadas) |
| test_nota_metodologica | Nota contiene "representatividad" | PASS |
| test_proporciones_categoricas | 3 categorias | PASS (0 <= LI <= LS <= 1) |

### Validacion Pydantic

| Test | Caso | Resultado |
|---|---|---|
| test_intervalo_confianza_invalido | nivel=1.5 | PASS (ValidationError) |
| test_resultado_numerica_campos_requeridos | Sin campos | PASS (ValidationError) |
| test_clasificacion_n_valores | 4 valores | PASS |
| test_clasificacion_asimetria_valores | 4 valores, incluye "no calificable" | PASS |

## Verificacion matematica independiente

Se verifican resultados contra calculos manuales con scipy:

1. **IC de media (iris):** `test_verificacion_matematica_iris` — calcula media, SE, t_critico, margen manualmente y compara contra `ic_media_t()`. Error <0.0001.
2. **IC de proporcion (setosa):** `test_verificacion_matematica_setosa` — calcula Wilson con z=1.96, p=50/150 manualmente y compara contra `ic_proporcion_wilson()`. Error <0.0001.

## Evidencia de ejecucion real (PDFs generados)

| Dataset | Formato | Filas | PDF | Tamano |
|---|---|---|---|---|
| iris | CSV | 150 | iris.pdf | 231 KB |
| BI_Estadistica_Descriptiva | CSV | 3,998 | BI_Estadistica_Descriptiva.pdf | 508 KB |
| clientes_datos_faltantes | CSV | 250 | clientes_datos_faltantes.pdf | 309 KB |
| Datos historicos de McDonald's | CSV | N/A | Datos_historicos_de_McDonalds.pdf | 238 KB |
| Drug Price | XLSX | N/A | Drug_Price.pdf | 276 KB |
