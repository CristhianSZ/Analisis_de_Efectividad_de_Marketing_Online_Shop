# ==============================================================================
# Etapa 4 PREPARACIÓN Y LIMPIEZA DE DATOS (ETL)
# Proyecto: Análisis de Efectividad de Campañas de Marketing
# Stakeholder: Equipo de Marketing
# Dataset: onlineshop.csv
# ==============================================================================

# 1. EXTRACCIÓN (Extract) ------------------------------------------------------
# Carga de la data cruda desde la fuente original
if (file.exists("onlineshop.csv")) {
  onlineshop <- read.csv("onlineshop.csv", stringsAsFactors = FALSE)
} else {
  stop("Error: El archivo onlineshop.csv no se encuentra en el directorio.")
}

# 2. TRANSFORMACIÓN (Transform) ------------------------------------------------

# 2.1 Control de Calidad (QA): Manejo de NAs
# Recodificamos NAs en TYPE como '3' (No entrevistado) para no perder registros
onlineshop$TYPE[is.na(onlineshop$TYPE)] <- 3

# 2.2 Estandarización de Tipos de Datos 
# Convertimos CONVERTED, VIDEO_AD y SENDBACK a lógicos para un análisis limpio
onlineshop$CONVERTED <- as.logical(onlineshop$CONVERTED)
onlineshop$VIDEO_AD <- as.logical(onlineshop$VIDEO_AD)
onlineshop$SENDBACK <- as.logical(onlineshop$SENDBACK)
# Aseguramos que DATE sea un objeto de fecha (aunque R a veces lo detecta, forzamos)
onlineshop$DATE <- as.POSIXct(onlineshop$DATE)

# 2.3 Ingeniería de Características (Feature Engineering) 
# Creamos grupos de edad para facilitar la segmentación de marketing
onlineshop$AGE_GROUP <- cut(onlineshop$AGE, 
                            breaks = c(0, 25, 40, 65, 100), 
                            labels = c("Joven", "Adulto Joven", "Adulto", "Senior"))

# 2.4 Detección de Duplicados (Mencionado en el documento estratégico)
# Eliminamos registros duplicados en caso de que una sesión se haya registrado dos veces
onlineshop <- onlineshop[!duplicated(onlineshop[c("USER_ID", "DATE")]), ]

# 2.5 Tratamiento de Outliers  
# Identificamos si hay montos de TURNOVER imposibles o extremos
# (Se mantiene la data completa a menos que se defina un límite con Marketing)

# 3. CARGA (Load) --------------------------------------------------------------
# Exportamos la versión limpia para el análisis final 
write.csv(onlineshop, "onlineshop_clean.csv", row.names = FALSE)

# Limpieza del entorno de trabajo para evitar conflictos de nombres 
message("Proceso ETL completado con éxito. Archivo 'onlineshop_clean.csv' generado.")
