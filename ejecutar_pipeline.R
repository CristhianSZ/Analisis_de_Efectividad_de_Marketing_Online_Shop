# Instalar el paquete específico (solo necesitas hacerlo esta vez)
# devtools::install_github("dominikjung42/dstools")

# Cargar el paquete
library(dstools)

# Traer el dataset al espacio de trabajo
data("onlineshop")

# Verifica que ya lo tienes con el resumen descriptivo
summary(onlineshop)
str(onlineshop)
#Exportar el datset.csv
write.csv(onlineshop, file = "onlineshop.csv", row.names = FALSE)
cat("\n[INFO] Ejecutando Fase 1: ETL y Limpieza de datos...\n")
source("fase1_etl_limpieza.R") # Ejecuta toda la limpieza automáticamente

# Ahora cargas la data limpia
datos_marketing <- read.csv("onlineshop_clean.csv")
summary(datos_marketing)
# A partir de aquí, ejecutamos el resto de las etapas del proyecto automáticamente
cat("\n[INFO] Ejecutando Fase 2: Perfilado Estadístico (EDA)...\n")
source("fase2_perfilado_eda.R")

cat("\n[INFO] Ejecutando Fase 3: Análisis de Relaciones...\n")
source("fase3_analisis_relaciones.R")

cat("\n[INFO] Ejecutando Fase 4: Visualización e Inferencia...\n")
source("fase4_visualizacion_inferencia.R")

cat("\n[ÉXITO] Pipeline del proyecto ejecutado correctamente de inicio a fin.\n")