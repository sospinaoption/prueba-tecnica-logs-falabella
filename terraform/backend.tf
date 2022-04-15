terraform {
backend "gcs" {
  bucket = "falabella-logs-test-tfstate-bucket"   # Nombre del bucket para guardar el tfstate con la configuracion actual de la infraestructura
  prefix = "falabella-logs-test"           # prefijo de terraform del proyecto
  }
}