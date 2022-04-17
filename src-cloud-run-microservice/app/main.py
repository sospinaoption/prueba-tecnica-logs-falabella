# from fastapi import FastAPI, Request

# app = FastAPI()

# @app.post("/")
# def root(request: Request):

#     print(request.headers)
#     # Example response
#     {
#         'host': 'eventarc-test-s6gfdsap7fda-uc.a.run.app',
#         'content-type': 'application/json',
#         'content-length': '838',
#         'accept': 'application/json',
#         'from': 'noreply@google.com',
#         'user-agent': 'APIs-Google; (+https://developers.google.com/webmasters/APIs-Google.html)',
#         'x-cloud-trace-context': '483010b253289e906d9324f80bad0cd3/9989356814841849077;o=1',
#         'traceparent': '00-483010b253389e906d9324f80bad0cd3-8aa15318e346a4f5-01',
#         'x-forwarded-for': '66.112.6.102',
#         'x-forwarded-proto': 'https',
#         'forwarded': 'for="66.112.6.102";proto=https',
#          'accept-encoding': 'gzip, deflate, br',
#          'ce-id': '33212954fdsa24407',
#          'ce-source': '//storage.googleapis.com/projects/_/buckets/mappable-upload-data-dev',
#          'ce-specversion': '1.0',
#          'ce-type': 'google.cloud.storage.object.v1.finalized',
#          'ce-subject': 'objects/<object name in storage>',
#          'ce-time': '2021-11-02T11:10:56.505568Z',
#          'ce-bucket': '<bucket name>'
#          }


from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello World"}