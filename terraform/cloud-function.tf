# Generates an archive of the source code compressed as a .zip file.
data "archive_file" "source" {
    type        = "zip"
    source_dir  = "../src-cloud-function"
    output_path = "/tmp/cloud-function.zip"
}

# Add source code zip to the Cloud Function's bucket
resource "google_storage_bucket_object" "zip" {
    source       = data.archive_file.source.output_path
    content_type = "application/zip"

    # Append to the MD5 checksum of the files's content
    # to force the zip to be updated as soon as a change occurs
    name         = "src-${data.archive_file.source.output_md5}.zip"
    bucket       = google_storage_bucket.cloud-function-bucket.name

}

# Create the Cloud function triggered by a `Finalize` event on the bucket
resource "google_cloudfunctions_function" "function" {
    name                  = "function-trigger-on-gcs"
    runtime               = "python37"  # of course changeable

    # Get the source code of the cloud function as a Zip compression
    source_archive_bucket = google_storage_bucket.cloud-function-bucket.name
    source_archive_object = google_storage_bucket_object.zip.name

    # Must match the function name in the cloud function `main.py` source code
    entry_point           = "publish_storage_file_to_pubsub"
    region = var.region_cloud_function_bucket
    
    # 
    event_trigger {
        event_type = "google.storage.object.finalize"
        resource   = var.input_bucket_name
    }

    environment_variables = {
        project_id = var.project_id
        topic_id = var.pub_sub_topic_meteorological_data_name
    }

    # Dependencies are automatically inferred so these lines can be deleted
    depends_on            = [
        google_storage_bucket.cloud-function-bucket,
        google_storage_bucket_object.zip
    ]
}