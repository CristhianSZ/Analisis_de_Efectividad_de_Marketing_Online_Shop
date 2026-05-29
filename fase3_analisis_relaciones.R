# ==============================================================================
# ETAPA 4.5 (Nivel 3): Análisis de Relaciones (AED - Covariabilidad y Asociación)
# Proyecto: Análisis de Efectividad de Campañas de Marketing
# Stakeholder: Equipo de Marketing
# Dataset: onlineshop_clean.csv
# ==============================================================================

# Carga de la data limpia
datos_marketing <- read.csv("onlineshop_clean.csv")

# 1. Matriz de Correlación (Variables Cuantitativas y Flags) -----------------
cat("\n--- 1. Matriz de Correlación (Pearson) ---\n")

# Seleccionamos variables de interés para correlación
# Convertimos columnas lógicas a numéricas (0/1) para incluirlas en el cálculo
datos_corr <- datos_marketing[, c("AGE", "TURNOVER", "CONVERTED", "VIDEO_AD", "SENDBACK")]
datos_corr$CONVERTED <- as.numeric(as.logical(datos_corr$CONVERTED))
datos_corr$VIDEO_AD <- as.numeric(as.logical(datos_corr$VIDEO_AD))
datos_corr$SENDBACK <- as.numeric(as.logical(datos_corr$SENDBACK))

# Calculamos y redondeamos la matriz de correlación
matriz_corr <- cor(datos_corr, use = "complete.obs")
print(round(matriz_corr, 3))

# 2. Análisis de Covariabilidad Visual: Gasto vs Edad --------------------------
cat("\n--- 2. Generando Gráfico de Dispersión (Edad vs Gasto) ---\n")

# Gráfico de dispersión para observar patrones conjuntos
plot(datos_marketing$AGE, datos_marketing$TURNOVER, 
     main = "Análisis de Relación: Edad vs. Volumen de Compra",
     xlab = "Edad del Cliente (Años)", 
     ylab = "Gasto de la Transacción (Euros €)",
     col = rgb(70/255, 130/255, 180/255, 0.5), # Steelblue con transparencia
     pch = 16, 
     cex = 1.2)

# Añadimos línea de regresión lineal simple para observar la tendencia
abline(lm(TURNOVER ~ AGE, data = datos_marketing), col = "red", lwd = 2, lty = 2)

# 3. Pruebas de Asociación Categórica (Chi-Cuadrado de Independencia) ---------
cat("\n--- 3. Pruebas de Asociación de Chi-Cuadrado para Conversión ---\n")

# 3.1 Conversión vs Formato de Anuncio (Video vs Texto)
cat("\n- Relación: CONVERTED vs VIDEO_AD\n")
chisq_anuncio <- chisq.test(table(datos_marketing$VIDEO_AD, datos_marketing$CONVERTED))
print(chisq_anuncio)
cat(sprintf("p-value: %g (Si es < 0.05, la relación es estadísticamente significativa)\n", chisq_anuncio$p.value))

# 3.2 Conversión vs Género
cat("\n- Relación: CONVERTED vs GENDER\n")
chisq_genero <- chisq.test(table(datos_marketing$GENDER, datos_marketing$CONVERTED))
print(chisq_genero)
cat(sprintf("p-value: %g (Si es < 0.05, la relación es estadísticamente significativa)\n", chisq_genero$p.value))

# 3.3 Conversión vs Grupo de Edad
cat("\n- Relación: CONVERTED vs AGE_GROUP\n")
chisq_edad <- chisq.test(table(datos_marketing$AGE_GROUP, datos_marketing$CONVERTED))
print(chisq_edad)
cat(sprintf("p-value: %g (Si es < 0.05, la relación es estadísticamente significativa)\n", chisq_edad$p.value))

cat("[INFO] Análisis de Relaciones completado.\n")
