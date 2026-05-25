# ==============================================================================
# ETAPA 5: VISUALIZACIÓN DE RESULTADOS PARA MARKETING
# Proyecto: Análisis de Efectividad de Campañas de Marketing
# Stakeholder: Equipo de Marketing
# Dataset: onlineshop_clean.csv
# ==============================================================================

datos_marketing <- read.csv("onlineshop_clean.csv")
# 1. Preparar datos para la historia: Tasas de Conversión por Edad y Formato de Anuncio

# Calcular la probabilidad real de éxito por edad y anuncio (margin = c(1, 2) calcula por subgrupo)
tabla_proporciones <- prop.table(table(datos_marketing$AGE_GROUP, datos_marketing$VIDEO_AD, datos_marketing$CONVERTED), margin = c(1, 2))

# Extraer el éxito (CONVERTED == TRUE / "TRUE") en porcentaje
matriz_conv <- tabla_proporciones[, , "TRUE"] * 100
colnames(matriz_conv) <- c("Texto", "Video")

cat("\n--- Tasas de Conversión por Edad y Formato de Anuncio (%) ---\n")
print(round(matriz_conv, 2))

# 2. Gráfico de Barras Agrupado: Comparación de formatos por rango de edad
# Transponemos la matriz para agrupar por rango de edad en el eje X
barplot(t(matriz_conv), 
        beside = TRUE,
        main = "Tasa de Conversión por Rango de Edad y Formato de Anuncio",
        xlab = "Grupo de Edad (Segmentos de Marketing)",
        ylab = "Porcentaje de Usuarios Convertidos (%)",
        col = c("skyblue", "darkblue"), 
        border = NA,
        legend.text = TRUE,
        args.legend = list(x = "topright", bty = "n"),
        ylim = c(0, max(matriz_conv) * 1.2)) # Escala relativa dinámica

# 3. Prueba de Significancia No Paramétrica (Prueba de Wilcoxon)
# ¿Es la diferencia de gasto (48€ vs 46€) real o azar?
test_resultado <- wilcox.test(TURNOVER ~ VIDEO_AD, data = datos_marketing)
cat("\n--- Prueba de Wilcoxon para TURNOVER según VIDEO_AD ---\n")
print(test_resultado)
cat(sprintf("p-value: %.4f\n", test_resultado$p.value)) # Si es < 0.05, el impacto del video es real
