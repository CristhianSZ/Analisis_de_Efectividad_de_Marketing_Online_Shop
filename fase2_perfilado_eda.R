# ==============================================================================
# ETAPA 4: Etapa de Comprender los Datos (Perfilado/EDA)
# Proyecto: Análisis de Efectividad de Campañas de Marketing
# Stakeholder: Equipo de Marketing
# Dataset: onlineshop_clean.csv
# ==============================================================================

# Carga de la data limpia generada en el paso anterior
datos_marketing <- read.csv("onlineshop_clean.csv")

# 1. Visualización Robusta: Box-Plot de Ventas por Tipo de Anuncio
# Este gráfico ayudará al Equipo de Marketing a ver el impacto real en el gasto
#boxplot(TURNOVER ~ VIDEO_AD, 
#        data = datos_marketing,
#        main = "Distribución de Gasto: Video Ads vs Otros",
#        xlab = "¿Vio anuncio de video?",
#        ylab = "Log del Volumen de Compra (Euros)",
#        col = c("lightblue", "orange"),
#        notch = TRUE,
#        log = "y")

boxplot(TURNOVER ~ VIDEO_AD,
        data = datos_marketing,
        main = "Distribución de Gasto por Formato de Anuncio",
        xlab = "Formato de Anuncio Publicitario",
        ylab = "Volumen de Compra (Euros €)",
        names = c("Texto / Otros", "Video Ad"),
        col = c("skyblue", "orange"),
        notch = TRUE,
        outline = FALSE)

stripchart(TURNOVER ~ VIDEO_AD,
           data = datos_marketing,
           vertical = TRUE,
           method = "jitter",
           pch = 20,
           col = rgb(0,0,0,0.3),
           add = TRUE) # El notch ayuda a ver si las medianas difieren significativamente

# 1.5 Prueba Formal de Normalidad (Shapiro-Wilk) --------------------------------
# Justifica matemáticamente el uso de estadística no paramétrica (medianas y Wilcoxon)
cat("\n--- Prueba de Normalidad de Shapiro-Wilk para TURNOVER ---\n")
prueba_normalidad <- shapiro.test(datos_marketing$TURNOVER)
print(prueba_normalidad)
cat(sprintf("p-value de Normalidad: %g (Si es < 0.05, los datos NO se distribuyen normalmente)\n", prueba_normalidad$p.value))

# 2. Perfilado de Medidas de Posición (No Paramétricas)
# Calculamos los cuartiles para entender los segmentos de gasto sin sesgos
cat("\n--- Medidas de Gasto por Tipo de Anuncio ---\n")
summary_gasto <- tapply(datos_marketing$TURNOVER, datos_marketing$VIDEO_AD, summary)
print(summary_gasto)

# 2.1 Respaldo de KPIs Principales (BANs) del Dashboard
cat("\n--- KPIs PRINCIPALES DEL DASHBOARD ---\n")
ventas_totales <- sum(datos_marketing$TURNOVER[datos_marketing$CONVERTED == TRUE | datos_marketing$CONVERTED == "TRUE"], na.rm = TRUE)
transacciones_totales <- sum(datos_marketing$CONVERTED == TRUE | datos_marketing$CONVERTED == "TRUE", na.rm = TRUE)
conversion_general <- mean(datos_marketing$CONVERTED == TRUE | datos_marketing$CONVERTED == "TRUE", na.rm = TRUE) * 100
aov_general <- ventas_totales / transacciones_totales

cr_video <- mean(datos_marketing$CONVERTED[datos_marketing$VIDEO_AD == TRUE | datos_marketing$VIDEO_AD == "TRUE"] == TRUE, na.rm = TRUE) * 100
cr_texto <- mean(datos_marketing$CONVERTED[datos_marketing$VIDEO_AD == FALSE | datos_marketing$VIDEO_AD == "FALSE"] == TRUE, na.rm = TRUE) * 100
mejora_video_vs_texto <- ((cr_video - cr_texto) / cr_texto) * 100

cat(sprintf("Volumen Total de Ventas: €%.1f mil\n", ventas_totales / 1000))
cat(sprintf("Transacciones Exitosas: %d\n", transacciones_totales))
cat(sprintf("Tasa de Conversión General: %.1f%%\n", conversion_general))
cat(sprintf("Valor Promedio de Pedido (AOV): €%.0f\n", aov_general))
cat(sprintf("Conversión Video: %.1f%% vs Texto: %.1f%% (Mejora: +%.0f%%)\n", cr_video, cr_texto, mejora_video_vs_texto))

# 2.2 Conteo de Clientes VIP (> 400€) para resolver discrepancia del Dashboard
cat("\n--- Conteo de Clientes VIP (Gasto > €400) ---\n")
vip_video <- sum(datos_marketing$TURNOVER > 400 & (datos_marketing$VIDEO_AD == TRUE | datos_marketing$VIDEO_AD == "TRUE"), na.rm = TRUE)
vip_texto <- sum(datos_marketing$TURNOVER > 400 & (datos_marketing$VIDEO_AD == FALSE | datos_marketing$VIDEO_AD == "FALSE"), na.rm = TRUE)
cat(sprintf("Clientes VIP en grupo VIDEO: %d\n", vip_video))
cat(sprintf("Clientes VIP en grupo TEXTO: %d\n", vip_texto))

# 3. Análisis de Frecuencia de Conversión (Paso previo a la Etapa 5)
# Tabla de contingencia para ver el éxito por grupo de edad creado en la limpieza
tabla_conversion <- table(datos_marketing$AGE_GROUP, datos_marketing$CONVERTED)
print(tabla_conversion)

# 4. Análisis de Frecuencia por Género (Cruzado con Video para respaldar Dashboard)
cat("\n--- Conversiones por Género y Formato de Anuncio ---\n")
# Calculamos la probabilidad de éxito (Conversión) cruzando Género y Exposición a Video
tabla_genero_video <- prop.table(table(datos_marketing$GENDER, datos_marketing$VIDEO_AD, datos_marketing$CONVERTED), margin = c(1, 2))
# Convertimos a porcentaje para mejor visualización y nos quedamos con CONVERTED == TRUE
pct_genero_video <- round(tabla_genero_video[, , "TRUE"] * 100, 2)
print(pct_genero_video)

# 5. Análisis de Riesgo: Devoluciones (SENDBACK) vs Tipo de Anuncio
# Fundamental para saber si el Video Ad genera impulsividad (ventas que luego se devuelven)
cat("\n--- Tasa de Devoluciones según Anuncio ---\n")
tabla_devoluciones <- table(datos_marketing$VIDEO_AD, datos_marketing$SENDBACK)
print(tabla_devoluciones)
# Mostrar en porcentaje por fila para mejor lectura:
print(round(prop.table(tabla_devoluciones, margin = 1) * 100, 2))