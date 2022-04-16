def publish_storage_file_to_pubsub(event, context):

    import os
    from google.cloud import pubsub_v1

    project_id = os.environ['project_id']
    topic_id = os.environ['topic_id']

    publisher = pubsub_v1.PublisherClient()
    topic_path = publisher.topic_path(project_id, topic_id)
    

    # try:
    message = event['bucket'] + "/" + event['name']
    print(publisher.publish(topic_path, message.encode('utf-8')))
    return f"Publish process was successfull"
    # except Exception as e:
    #     print(f"Publish process failed with error: " + str(e))
    #     return f"Publish process failed with error: " + str(e)