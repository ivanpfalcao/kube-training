FROM python:3.9.5-slim-buster

WORKDIR /app

RUN apt update && apt install -y curl nano

COPY ./ ./
RUN pip install -r requirements.txt