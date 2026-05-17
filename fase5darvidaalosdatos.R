# ==============================================================================
# INFORME ESTRATÉGICO: EVALUACIÓN DE EFECTIVIDAD DE VIDEO ADS Y SEGMENTACIÓN
# Objetivo: Validar si Video Ads captura al segmento VIP frente a Texto (SCQM)
# Autor: Arquitectura de Datos Clínicos
# ==============================================================================

# 1. CARGA DE LIBRERÍAS
library(tidyverse)
library(scales) # Para formatos de euros y porcentajes

# 2. INGENIERÍA DE DATOS Y TRATAMIENTO DE INTEGRIDAD ---------------------------
# Asumiendo que vienes arrastrando el dataset de los scripts anteriores
# df_fase5 <- df_limpio %>%
#   mutate(
#     # Tratamiento NAs en TYPE (Preservamos la fila para no perder facturación)
#     TYPE = replace_na(TYPE, "3"),
#     TYPE = as.factor(TYPE),
#     
#     # Creación de AGE_GROUP
#     AGE_GROUP = case_when(
#       AGE >= 18 & AGE <= 25 ~ "18-25",
#       AGE >= 26 & AGE <= 40 ~ "26-40",
#       AGE >= 41             ~ "41+",
#       TRUE                  ~ "Desconocido"
#     ),
#     AGE_GROUP = factor(AGE_GROUP, levels = c("18-25", "26-40", "41+"))
#   )

# 3. BLINDAJE ESTADÍSTICO (TEST NO PARAMÉTRICO) --------------------------------
# Comprobamos matemáticamente si la diferencia de medianas es significativa
# wilcox_test <- wilcox.test(TURNOVER ~ VIDEO_AD, data = filter(df_fase5, CONVERTED == TRUE))
# print(wilcox_test) # P-value debe respaldar nuestras conclusiones

# 4. ARQUITECTURA VISUAL: BOXPLOT DE COMPORTAMIENTO VIP ------------------------
# Aplicando Trifecta y Atributos de Preatención

# vis_boxplot <- df_fase5 %>%
#   filter(CONVERTED == TRUE) %>%
#   ggplot(aes(x = AGE_GROUP, y = TURNOVER, fill = VIDEO_AD)) +
#   geom_boxplot(
#     alpha = 0.8,
#     outlier.colour = "#D81B60", # Color de preatención para destacar a los VIPs (Outliers)
#     outlier.size = 2.5,
#     outlier.alpha = 0.7
#   ) +
#   scale_fill_manual(values = c("FALSE" = "#B0BEC5", "TRUE" = "#1E88E5")) + # Gris para base, Azul fuerte para Video
#   scale_y_continuous(
#     labels = label_dollar(prefix = "€", big.mark = ".", decimal.mark = ","),
#     limits = c(0, NA) # Honestidad Visual: Eje Y debe empezar en 0
#   ) +
#   labs(
#     title = "El Video Ad como Motor de Captación VIP",
#     subtitle = "Distribución del Gasto por Generación y Formato. Los puntos rosas revelan transacciones High-Ticket (>400€)",
#     x = "Segmento Generacional",
#     y = "Ingresos por Transacción (Turnover)",
#     fill = "Formato (Video)"
#   ) +
#   theme_minimal(base_family = "sans") + # Evita el "Junk Chart", diseño limpio
#   theme(
#     plot.title = element_text(face = "bold", size = 14),
#     legend.position = "top",
#     panel.grid.major.x = element_blank(),
#     panel.border = element_blank()
#   )
# 
# print(vis_boxplot)
