# 📊 Análisis de Efectividad de Marketing: Online Shop

Este proyecto realiza un análisis exhaustivo del comportamiento de compra y la efectividad de las campañas de marketing (anuncios de video vs. texto) para una tienda de comercio electrónico. El objetivo principal es proporcionar insights accionables al equipo de **Marketing** para optimizar la inversión publicitaria y mejorar las tasas de conversión.

##  Objetivo de Negocio

Determinar cómo influyen los **anuncios de video** en la tasa de conversión y el volumen de ventas, segmentando los resultados por grupos de edad y género. Esto permite identificar a las audiencias más rentables y ajustar las estrategias de captación.

### Métricas Clave (KPIs)
*   **Tasa de Conversión (CR):** Porcentaje de usuarios que añaden productos al carrito.
*   **Volumen Total de Ventas (Turnover):** Impacto financiero directo en euros (€).
*   **Valor Promedio de Pedido (AOV):** Gasto medio por transacción.
*   **Efectividad por Formato:** Comparativa `VIDEO_AD == TRUE` vs `FALSE`.

---

##  Pipeline de Datos (Metodología)

El proyecto sigue una estructura modular implementada en **R**:

### 1. Extracción y Carga (`datasetJunglivet.R`)
Los datos se extraen de la librería `dstools` y se exportan para su procesamiento.
*   **Dataset:** `onlineshop.csv` (1.000 registros aprox.)

### 2. Preparación y Limpieza ETL (`limpieza_onlineshop.R`)
*   **Manejo de NAs:** Recodificación de clientes no entrevistados en la variable `TYPE` para preservar datos históricos.
*   **Estandarización:** Conversión de tipos de datos (lógicos para flags de conversión y video, POSIXct para fechas).
*   **Ingeniería de Características:** Creación de la variable `AGE_GROUP` (Joven, Adulto Joven, Adulto, Senior).
*   **Control de Calidad:** Eliminación de duplicados y análisis de outliers en `TURNOVER`.

### 3. Perfilado de Datos EDA (`perfilado_onlineshop.R`)
Análisis exploratorio visual centrado en la distribución del gasto. Se utilizan diagramas de caja (**Box-Plots**) para:
*   Identificar visualmente a los clientes **VIP** (Transacciones > 400€).
*   Comparar medianas de gasto entre usuarios impactados por video vs. otros formatos.

### 4. Visualización e Insights (`visualizacion_onlineshop.R`)
*   Cálculo de probabilidades reales de éxito.
*   Gráficos de barras que revelan patrones demográficos inesperados (como la alta efectividad en el segmento "Senior").
*   **Validación Estadística:** Uso de la prueba de Wilcoxon para confirmar si las diferencias en ventas son estadísticamente significativas.

---

##  Visualización Final: Looker Studio

Para facilitar la toma de decisiones por parte de los stakeholders, los resultados finales se integran en un dashboard dinámico en **Looker Studio**.

> [!NOTE]
> El tablero en Looker Studio permite filtrar por género, grupo de edad y periodo de tiempo, proporcionando una interfaz intuitiva para el equipo de gestión y marketing.

---

##  Requisitos y Ejecución

### Tecnologías
*   **Lenguaje:** R
*   **Librerías principales:** `tidyverse`, `dstools`, `scales`.
*   **BI:** Looker Studio.

### Cómo ejecutar el proyecto
1.  Clona este repositorio.
2.  Asegúrate de tener instalada la librería `dstools` desde GitHub.
3.  Ejecuta el archivo principal para iniciar el pipeline automático:
    ```r
    source("datasetJunglivet.R")
    ```

---

##  Autor
**Cristhian Rodrigo Sosa Zurita**  
Analista de Datos
