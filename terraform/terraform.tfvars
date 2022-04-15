project_id = "sospina-test" # ID del proyecto de GCP
input_bucket_name = "landing-meteorological-data" # Nombre del bucket que recibe los inputs de datos meteorologicos
output_bucket_name = "consumer-meteorological-data" # Nombre del bucket que recibe los outputs de datos meteorologicos desde cloud run
cloud_function_bucket_name = "cloud-function-source-sospina" # Nombre del bucket GCP que almacena el codigo fuente de la cloud function que alimenta el pub/sub
lyfecyle_condition_input_bucket = 1 # dias transcurridos desde la carga de un archiov antes de ser eliminado del bucket de entrada
region_cloud_function_bucket = "us-central1" # Region del bucket que almacena la cloud function
