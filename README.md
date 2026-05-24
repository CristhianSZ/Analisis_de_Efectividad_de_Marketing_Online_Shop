# Análisis de Efectividad de Marketing: Online Shop

Este proyecto realiza un análisis exhaustivo del comportamiento de compra y la efectividad de las campañas de marketing (anuncios de video vs. texto) para una tienda de comercio electrónico. El objetivo principal es proporcionar insights accionables al equipo de **Marketing** para optimizar la inversión publicitaria y mejorar las tasas de conversión.

##  Objetivo de Negocio

Determinar cómo influyen los **anuncios de video** en la tasa de conversión y el volumen de ventas, segmentando los resultados por grupos de edad y género. Esto permite identificar a las audiencias más rentables y ajustar las estrategias de captación.

### Métricas Clave (KPIs)
*   **Tasa de Conversión (CR):** Porcentaje de usuarios que añaden productos al carrito.
*   **Volumen Total de Ventas (Turnover):** Impacto financiero directo en euros (€).
*   **Valor Promedio de Pedido (AOV):** Gasto medio por transacción.
*   **Efectividad por Formato:** Comparativa `VIDEO_AD == TRUE` vs `FALSE`.

---

##  Planificación Metodológica

### Stakeholders identificados

| Tipo | Stakeholder | Interés |
|------|-------------|---------|
| Interno | Marketing | Optimizar campañas y conversiones |
| Interno | Ventas/Producto | Comportamiento de compra y fidelización |
| Interno | Finanzas | Riesgo y solvencia |
| Interno | Analistas de datos | Limpieza, modelado e insights |
| Externo | Clientes | Datos y comportamiento de compra |
| Estratégico | Gerencia | Decisiones para aumentar ingresos |
| Estratégico | Inversores | Métricas de rentabilidad |

### Stakeholder seleccionado: **Equipo de Marketing**

**Objetivo**: Determinar el impacto de los anuncios de video en la tasa de conversión y el volumen de ventas, segmentando por edad y género para identificar audiencias más rentables.

---

##  Pipeline de Datos (Metodología)

El proyecto sigue una estructura modular implementada en **R**:

### 1. Extracción y Carga (`datasetJunglivet.R`)
Los datos se extraen de la librería `dstools` y se exportan para su procesamiento.
*   **Dataset:** `onlineshop.csv` (1.000 registros aprox.)

### 2. Preparación y Limpieza ETL (`limpieza_onlineshop.R`)
*   **Manejo de NAs:** Recodificación de 116 registros NA en la variable `TYPE` (clientes sin entrevista telefónica) como "3" (No entrevistado) para preservar datos históricos de ventas.
*   **Estandarización:** Conversión de tipos de datos (lógicos para flags de conversión y video, POSIXct para fechas).
*   **Ingeniería de Características:** Creación de la variable `AGE_GROUP` con 4 categorías: 18-25, 26-40, 41-55 y 56+ años.
*   **Control de Calidad:** Detección y eliminación de duplicados; análisis de outliers en `TURNOVER` (hasta 718€). Los valores atípicos se conservaron por ser transacciones reales de clientes "VIP".
*   **Enfoque estadístico:** Los datos no siguen distribución normal debido al sesgo positivo en ventas. Se adoptó un enfoque no paramétrico priorizando medianas y rangos intercuartílicos sobre promedios.

### 3. Perfilado de Datos EDA (`perfilado_onlineshop.R`)
Análisis exploratorio visual centrado en la distribución del gasto. Se utilizan diagramas de caja (**Box-Plots**) para:
*   Identificar visualmente a los clientes **VIP** (Transacciones > 400€).
*   Comparar medianas de gasto entre usuarios impactados por video vs. otros formatos.

### 4. Visualización e Insights (`visualizacion_onlineshop.R`)
*   Cálculo de probabilidades reales de éxito.
*   Gráficos de barras que revelan patrones demográficos inesperados (como la alta efectividad en el segmento "Senior").
*   **Validación Estadística:** Uso de la prueba de Wilcoxon para confirmar diferencias en ventas (p-value = 0.1068).

---

##  Visualización Final: Power BI

Para facilitar la toma de decisiones por parte de los stakeholders, los resultados finales se integran en un dashboard dinámico en **Power BI**.

> [!NOTE]
> El tablero en Power BI permite filtrar por género y grupo de edad , proporcionando una interfaz intuitiva para el equipo de gestión y marketing.

---

##  Resultados Clave

### Indicadores de Alto Nivel (BANs)
- **Volumen Total de Ventas:** €80,8 mil (basado en 445 transacciones exitosas)
- **Tasa de Conversión General:** 17,1% de los usuarios que interactuaron con el sitio
- **Valor Promedio de Pedido (AOV):** €182 por transacción
- **Impacto de Video vs. Texto:** Mejora del +125% en la tasa de conversión con formato de video

### Segmentación Demográfica
- **Senior (65+ años):** 50% de conversión con video vs 11,11% con texto
- **Joven Adulto / Millennials (26-40 años):** 24,44% de conversión con video
- **Impacto por Género:** El video eleva la conversión masculina de 8,8% a 26,1% (+197%)

---

##  Requisitos y Ejecución

### Tecnologías
*   **Lenguaje:** R
*   **Librerías principales:** `tidyverse`, `dstools`, `scales`.
*   **BI:** Power BI.

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