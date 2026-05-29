# Análisis de Efectividad de Marketing: Online Shop

[![Reporte Stakeholder](https://img.shields.io/badge/Reporte-Stakeholder-blue?style=flat-square&logo=markdown)](./reporte_correo_stakeholder.md)
[![Metodología](https://img.shields.io/badge/Metodolog%C3%ADa-Procedimiento.Rmd-green?style=flat-square&logo=r)](./procedimiento.Rmd)
[![Licencia MIT](https://img.shields.io/badge/Licencia-MIT-orange?style=flat-square&logo=open-source-initiative)](./LICENSE)

> [!NOTE]
> **Propósito del Proyecto:** Este es un proyecto personal desarrollado con el fin de poner en práctica lo aprendido al día en la capacitación de Operador en Análisis de Datos del **CFP 16** (Centro de Formación Profesional N° 16, Ciudad Autónoma de Buenos Aires), integrando programación en R, análisis estadístico descriptivo e inferencial y comunicación orientada a stakeholders.

Este proyecto realiza un análisis exhaustivo de extremo a extremo (end-to-end) del comportamiento de compra y la efectividad de las campañas de marketing (anuncios de video vs. texto) para una tienda de comercio electrónico. El objetivo principal es proporcionar recomendaciones accionables al equipo de **Marketing** para optimizar la inversión publicitaria y mejorar las tasas de conversión.

---

## Buenas Prácticas y Reproducibilidad

Como pilar de reproducibilidad y transparencia en proyectos de analisis de datos, el repositorio cuenta con un registro formal de cambios de la fuente de datos original:
*    **Bitácora de Cambios:** Consúltala en [Log de Registro de Cambios_ Dataset onlineshop.docx](file:///c:/Users/Usuario/Documents/Cursos/Aprendiendo_R/Proyecto/Log%20de%20Registro%20de%20Cambios_%20Dataset%20onlineshop.docx) para observar el historial de control de versiones y auditoría del dataset.

---

##  Ciclo de Vida de los Datos y Visualizaciones por Etapas

El proyecto sigue una progresión metodológica rigurosa de 6 niveles (La Raíz $\rightarrow$ Las Hojas), mapeada en archivos modulares de R. A continuación se presentan los gráficos correspondientes a cada etapa del ciclo de vida:

### Etapa 2: Perfilado de Datos (Box-Plot)
Visualización de la distribución del gasto sin sesgo por tipo de anuncio para identificar medianas reales y outliers (clientes VIP).

![Box-Plot: Distribución de Gasto por Formato de Anuncio](./Rplot_Distribucion_de_gastos_por_formato_de_anuncio.png)

### Etapa 3: Análisis de Relaciones (Scatter Plot)
Análisis de covariabilidad entre la edad y el gasto, demostrando una correlación prácticamente nula con línea de tendencia plana.

![Scatter Plot: Relación entre Edad y Gasto](./Rplot_analisis_de_relacion_edad_vs_volumen_de_compra.png)

### Etapa 4: Visualización e Inferencia (Grouped Bar Plot)
Gráfico de barras agrupado que ilustra la tasa de conversión por grupo de edad segmentada por formato de anuncio.

![Grouped Bar Plot: Conversión por Edad y Formato](./Rplot_tasa_de_conversion_por_rango_de_edad_y_formato_de_anuncio.png)

---

## ️ Visualización Final: Dashboard en Power BI

*    **Acceso al Dashboard Interactivo (Haga clic en la imagen para abrir en otra pestaña):**

<a href="https://app.powerbi.com/reportEmbed?reportId=08b38379-5b1d-47c1-842b-bcd897e7b3fe&autoAuth=true&ctid=cb9bb30c-78c0-48c2-8aec-b3ddc91e3626" target="_blank">
  <img src="./dashboard_preview.jpg" alt="Click para abrir Dashboard Interactivo de Power BI" width="100%" style="border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.15);" />
</a>
---

##  Estructura del Pipeline de Datos (R)

El proyecto está diseñado bajo una arquitectura modular y automatizada en **R**:

1.  **Carga y Orquestación:** [ejecutar_pipeline.R](file:///c:/Users/Usuario/Documents/Cursos/Aprendiendo_R/Proyecto/ejecutar_pipeline.R) (Ejecuta todo el pipeline secuencialmente).
2.  **Fase 1 - ETL y Saneamiento:** [fase1_etl_limpieza.R](file:///c:/Users/Usuario/Documents/Cursos/Aprendiendo_R/Proyecto/fase1_etl_limpieza.R) (Tratamiento de NAs, duplicados, ingeniería de características).
3.  **Fase 2 - Perfilado Estadístico:** [fase2_perfilado_eda.R](file:///c:/Users/Usuario/Documents/Cursos/Aprendiendo_R/Proyecto/fase2_perfilado_eda.R) (Shapiro-Wilk, Box-Plot y estadísticas descriptivas).
4.  **Fase 3 - Análisis de Relaciones:** [fase3_analisis_relaciones.R](file:///c:/Users/Usuario/Documents/Cursos/Aprendiendo_R/Proyecto/fase3_analisis_relaciones.R) (Matriz de correlación y pruebas Chi-cuadrado para conversión).
5.  **Fase 4 - Visualización e Inferencia:** [fase4_visualizacion_inferencia.R](file:///c:/Users/Usuario/Documents/Cursos/Aprendiendo_R/Proyecto/fase4_visualizacion_inferencia.R) (Prueba de Wilcoxon, gráficos de barra agrupados).
6.  **Metodología Completa:** [procedimiento.Rmd](file:///c:/Users/Usuario/Documents/Cursos/Aprendiendo_R/Proyecto/procedimiento.Rmd) (Documento detallado de la metodología teórica y técnica).

---

##  Resultados Estratégicos Clave
*   **Conversión Video vs Texto:** El video incrementa la conversión de 10.3% a 23.3% (+125% de mejora).
*   **Efecto en Hombres:** El video eleva la conversión masculina de 8.8% a 26.1% (+197%).
*   **La Sorpresa de los Seniors:** 50% de conversión con video frente a 11.1% con texto.
*   **Validación de Ticket:** El test de Wilcoxon confirmó que no hay diferencias significativas de gasto debido al formato del anuncio ($p = 0.1068$), sugiriendo enfocar el video exclusivamente en la captación.

---

##  Autor
**Cristhian Rodrigo Sosa Zurita**  
*Analista de Datos*
