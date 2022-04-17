variable "project_id" {
description = "Google Project ID."
type        = string
}

variable "input_bucket_name" {
description = "Nombre del bucket GCP que recibe los archivos de entrada"
type        = string
}

variable "output_bucket_name" {
description = "Nombre del bucket GCP que almacena los archivos procesados de salida"
type        = string
}

variable "cloud_function_bucket_name" {
description = "Nombre del bucket GCP que almacena el codigo fuente de la cloud function que alimenta el pub/sub"
type        = string
}

variable "region" {
description = "Region proyecto de GC"
type        = string
default     = "us"
}

variable "region_cloud_function_bucket" {
description = "Region bucket cloud function codigo fuente"
type        = string
}

variable "output_bucket_storage_class" {
    description = "Clase de almacenamiento del bucket de salida"
    type = string
    default = "standard"
}

variable "input_bucket_storage_class" {
    description = "Clase de almacenamiento del bucket de entrada"
    type = string
    default = "standard"
}

variable "lyfecyle_condition_input_bucket" {
  description = "Dias trancurridos desde la carga de un archivo al bucket de entrada antes de ser eliminados"
  type = string
}


variable "cloud_function_bucket_storage_class" {
    description = "Clase de almacenamiento del bucket que almacena el codigo fuente de la cloud function que alimenta el pub/sub"
    type = string
    default = "standard"
}

variable "pub_sub_topic_meteorological_data_name" {
  description = "Nombre del topico de pub sub al que se publicaran los datos meterologicos originales cargados por el usuario"
  type = string
}

variable "pub_sub_meteorological_data_subscription_pull" {
  description = "Nombre de la suscripcion pub sub encargada de hacer pull de los mensajes que se envian al topico"
  type = string
}

variable "pub_sub_meteorological_data_subscription_push" {
  description = "Nombre de la suscripcion pub sub encargada de hacer push de los mensajes que se envian al topico"
  type = string
}

variable "cloud_run_microservice_name" {
  description = "Nombre del microservicio de cloud run"
  type = string
}

variable "region_cloud_run_microservice" {
  description = "Region del microservicio de cloud run"
  type = string
}

variable "cloud_run_microservice_container" {
  description = "Ruta en el container registry del contenedor que define el microservicio"
  type = string
}

variable "pubsub_service_account_name" {
  description = "ID de la service account configurada para pubsub"
  type = string
}

variable "project_number" {
  description = "Numero de proyecto de GCP"
  type = string
}
