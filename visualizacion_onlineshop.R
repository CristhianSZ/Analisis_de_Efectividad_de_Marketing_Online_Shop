# ==============================================================================
# ETAPA 5: VISUALIZACIÓN DE RESULTADOS PARA MARKETING
# ==============================================================================

datos_marketing <- read.csv("onlineshop_clean.csv")
# 1. Preparar datos para la historia: Tasas de Conversión

# Calcular la probabilidad real de éxito por grupo (margin = 1 calcula por filas/grupos)
tabla_proporciones <- prop.table(table(datos_marketing$AGE_GROUP, datos_marketing$CONVERTED), margin = 1)
df_conv <- as.data.frame(tabla_proporciones)
df_conv <- df_conv[df_conv$Var2 == "1" | df_conv$Var2 == "TRUE", ] # Solo nos interesa el éxito

# Transformar a porcentaje para el gráfico (multiplicar x 100)
df_conv$Freq_Porcentaje <- df_conv$Freq * 100

# 2. Gráfico de Barras: La "Sorpresa de los Seniors"
# Usamos colores sobrios para no distraer
barplot(df_conv$Freq_Porcentaje, 
        names.arg = df_conv$Var1,
        main = "Tasa de Conversión por Rango de Edad (%)",
        col = "steelblue", 
        border = NA,
        ylim = c(0, max(df_conv$Freq_Porcentaje) * 1.2), # Escala relativa dinámica
        ylab = "% de Usuarios que Compraron")
# 3. Prueba de Significancia No Paramétrica (Prueba de Wilcoxon)
# ¿Es la diferencia de gasto (48€ vs 46€) real o azar?
test_resultado <- wilcox.test(TURNOVER ~ VIDEO_AD, data = datos_marketing)
print(test_resultado$p.value) # Si es < 0.05, el impacto del video es real