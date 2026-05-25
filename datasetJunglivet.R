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
cat("\n[INFO] Ejecutando Etapa 3: Limpieza de datos...\n")
source("limpieza_onlineshop.R") # Ejecuta toda la limpieza automáticamente

# Ahora cargas la data limpia
datos_marketing <- read.csv("onlineshop_clean.csv")
summary(datos_marketing)
# A partir de aquí, ejecutamos el resto de las etapas del proyecto automáticamente
cat("\n[INFO] Ejecutando Etapa 4: Perfilado Estadístico...\n")
source("perfilado_onlineshop.R")

cat("\n[INFO] Ejecutando Etapa 4.5 (Nivel 3): Análisis de Relaciones...\n")
source("relaciones_onlineshop.R")

cat("\n[INFO] Ejecutando Etapa 5: Visualización de Resultados...\n")
source("visualizacion_onlineshop.R")

cat("\n[ÉXITO] Pipeline del proyecto ejecutado correctamente de inicio a fin.\n")