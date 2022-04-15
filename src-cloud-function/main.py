# def hello_gcs(event, context):
#     """Background Cloud Function to be triggered by Cloud Storage.
#        This generic function logs relevant data when a file is changed.
#     Args:
#         event (dict):  The dictionary with data specific to this type of event.
#                        The `data` field contains a description of the event in
#                        the Cloud Storage `object` format described here:
#                        https://cloud.google.com/storage/docs/json_api/v1/objects#resource
#         context (google.cloud.functions.Context): Metadata of triggering event.
#     Returns:
#         None; the output is written to Stackdriver Logging
#     """
#     print('Event ID:' , context.event_id)
#     print('Event type:', context.event_type)
#     print('Bucket:', event['bucket'])
#     print('File:',  event['name'])
#     print('Metageneration:',  event['metageneration'])
#     print('Created:',  event['timeCreated'])
#     print('Updated:',  event['updated'])




def publish_storage_file_to_pubsub(event, context):

    import os
    from google.cloud import pubsub_v1

    project_id = os.environ['project_id']
    topic_id = os.environ['topic_id']

    publisher = pubsub_v1.PublisherClient()
    topic_path = publisher.topic_path(project_id, topic_id)

    try:
        publisher.publish(topic_path, event['bucket'] + "/" + event['name'])
        print(topic_path)
        print(event['bucket'] + "/" + event['name'])
        return f"Publish process was successfull"
    except Exception as e:
        return f"Publish process failed with error: " + e