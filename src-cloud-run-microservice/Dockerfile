#Tengo un Mac con arquitectura arm entonces debo declarar que la plataforma es linux y la arquitectura x64 para que funcione fuera de mi pc 
FROM --platform=linux/amd64 python:3.7-slim 

ENV PYTHONUNBUFFERED True
COPY requirements.txt ./
RUN pip install -r requirements.txt

ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 main:app