# ==============================================================================
# ETAPA 4: PERFILADO ESTADÍSTICO Y EDA
# Proyecto: Impacto de Video Ads en Ventas
# ==============================================================================

# Carga de la data limpia generada en el paso anterior
datos_marketing <- read.csv("onlineshop_clean.csv")

# 1. Visualización Robusta: Box-Plot de Ventas por Tipo de Anuncio
# Este gráfico ayudará al Equipo de Marketing a ver el impacto real en el gasto
boxplot(TURNOVER ~ VIDEO_AD, 
        data = datos_marketing,
        main = "Distribución de Gasto: Video Ads vs Otros",
        xlab = "¿Vio anuncio de video?",
        ylab = "Volumen de Compra (Euros)",
        col = c("lightblue", "orange"),
        notch = TRUE) # El notch ayuda a ver si las medianas difieren significativamente

# 2. Perfilado de Medidas de Posición (No Paramétricas)
# Calculamos los cuartiles para entender los segmentos de gasto sin sesgos
tapply(datos_marketing$TURNOVER, datos_marketing$VIDEO_AD, summary)

# 3. Análisis de Frecuencia de Conversión (Paso previo a la Etapa 5)
# Tabla de contingencia para ver el éxito por grupo de edad creado en la limpieza
tabla_conversion <- table(datos_marketing$AGE_GROUP, datos_marketing$CONVERTED)
print(tabla_conversion)

# 4. Análisis de Frecuencia por Género
# En procedimiento.Rmd mencionaste segmentar por edad y género. Esto cubre el género.
cat("\n--- Conversiones por Género ---\n")
tabla_genero <- table(datos_marketing$GENDER, datos_marketing$CONVERTED)
print(tabla_genero)

# 5. Análisis de Riesgo: Devoluciones (SENDBACK) vs Tipo de Anuncio
# Fundamental para saber si el Video Ad genera impulsividad (ventas que luego se devuelven)
cat("\n--- Tasa de Devoluciones según Anuncio ---\n")
tabla_devoluciones <- table(datos_marketing$VIDEO_AD, datos_marketing$SENDBACK)
print(tabla_devoluciones)
# Mostrar en porcentaje por fila para mejor lectura:
print(round(prop.table(tabla_devoluciones, margin = 1) * 100, 2))