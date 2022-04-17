# from fastapi import FastAPI, Request

# app = FastAPI()

# @app.post("/")
# async def root(request: Request):

#     print(request.headers)
#     # Example response

# # from fastapi import FastAPI

# # app = FastAPI()

# # @app.get("/")
# # async def root():
# #     return {"message": "Hello World"}


import base64
from importlib.resources import path
import os

from flask import Flask, request
import pandas as pd
import hashlib
import numpy as np
from google.cloud import storage
import logging

logger = logging.getLogger(__name__)
app = Flask(__name__)

OUTPUT_BUCKET = os.environ.get("OUTPUT_BUCKET")

@app.route("/", methods=["POST"])
def index():
    envelope = request.get_json()
    if not envelope:
        msg = "no Pub/Sub message received"
        print(f"error: {msg}")
        return f"Bad Request: {msg}", 400

    if not isinstance(envelope, dict) or "message" not in envelope:
        msg = "invalid Pub/Sub message format"
        print(f"error: {msg}")
        return f"Bad Request: {msg}", 400

    pubsub_message = envelope["message"]

    name = "World"
    if isinstance(pubsub_message, dict) and "data" in pubsub_message:
        
        path_file = base64.b64decode(pubsub_message["data"]).decode("utf-8").strip()
        print(f"Captured path: {path_file}!")
        
        storage_client = storage.Client()
        bucket = storage_client.get_bucket(path_file.split("/")[0])

        blob = bucket.get_blob(os.path.basename(path_file))
        temp_file_name = str(np.random.randint(0, 9999)) + os.path.basename(path_file)
        blob.download_to_filename(temp_file_name)

        try:
            data = pd.read_csv(temp_file_name)

            data.loc[:, "Longitude"] = data.loc[:, "Longitude"].str.encode('utf-8').apply(lambda x: hashlib.sha256(x).hexdigest())
            data.loc[:, "Latitude"] = data.loc[:, "Latitude"].str.encode('utf-8').apply(lambda x: hashlib.sha256(x).hexdigest())

            for country in data.Country.unique():
                data.loc[data.loc[:, "Country"] == country].to_csv(f"gs://{OUTPUT_BUCKET}/{country}.csv", encoding = "utf-8", index = False)

        except Exception as error:
            logger.error(error)
            raise  

    return ("", 204)



if __name__ == "__main__":
    PORT = int(os.getenv("PORT")) if os.getenv("PORT") else 8080

    # This is used when running locally. Gunicorn is used to run the
    # application on Cloud Run. See entrypoint in Dockerfile.
    app.run(host="127.0.0.1", port=PORT, debug=False)