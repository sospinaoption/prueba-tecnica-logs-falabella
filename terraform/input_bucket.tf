# Creacion de bucket de Google Cloud Storage
resource "google_storage_bucket" "landing-meteorological-data" {
name     = var.input_bucket_name # Nombre del bucket para cargar inputs
location = var.region # Region del bucket
storage_class = var.input_bucket_storage_class # Clase de almacenamiento a utilizar 
force_destroy = true # En caso que se le indique a terraform que destruya el bucket lo eliminara aunque este contenga archivos, en caso contrario dberia estar vacio antes de ser eliminado
uniform_bucket_level_access = true # todos los permisos definidos en el IAM para el bucket aplicaran de forma uniforme a todos los archivos y carpetas que este contenga

  lifecycle_rule { # Establece una politica de eliminacion de los archivos diaria, pues los archivos seran procesados por la cloud function una vez son cargados y no seran utilizados nuevamente, lo que permite ahorrar costos innecesarios
    condition {
      age = var.lyfecyle_condition_input_bucket # dias transcurridos para eliminar archivos del bucket
    }
    action {
      type = "Delete"
    }
  }

}

