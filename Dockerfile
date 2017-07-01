FROM ubuntu:16.04

RUN apt-get update && apt-get install -y python python-pip

RUN pip install mcstatus

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

