# Creacion de bucket de Google Cloud Storage
resource "google_storage_bucket" "consumer-meteorological-data" {
name     = var.output_bucket_name # Nombre del bucket para cargar outputs
location = var.region # Region del bucket
storage_class = var.output_bucket_storage_class # Clase de almacenamiento a utilizar 
force_destroy = true # En caso que se le indique a terraform que destruya el bucket lo eliminara aunque este contenga archivos, en caso contrario dberia estar vacio antes de ser eliminado
uniform_bucket_level_access = true # todos los permisos definidos en el IAM para el bucket aplicaran de forma uniforme a todos los archivos y carpetas que este contenga

# No contiene una politica de eliminacion de los archivos pues esta es una zona de archivos procesados

}

