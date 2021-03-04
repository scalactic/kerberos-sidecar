FROM python:3.8-slim

RUN apt-get update && apt-get install krb5-user libkrb5-dev -y

WORKDIR /
COPY . .
RUN chmod +x rekinit.sh

ENTRYPOINT ["bash", "rekinit.sh"]
