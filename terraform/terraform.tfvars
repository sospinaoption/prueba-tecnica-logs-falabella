project_id = "sospina-test" # ID del proyecto de GCP
input_bucket_name = "landing-meteorological-data" # Nombre del bucket que recibe los inputs de datos meteorologicos
output_bucket_name = "consumer-meteorological-data" # Nombre del bucket que recibe los outputs de datos meteorologicos desde cloud run
lyfecyle_condition_input_bucket = 1 # dias transcurridos desde la carga de un archiov antes de ser eliminado del bucket de entrada