FROM ubuntu:14.04.2

ENV UPDATED_AT 2015-05-03

RUN apt-get update

RUN apt-get install -y \
    curl \
    gcc \
    make

RUN curl -L http://cpanmin.us | perl - App::cpanminus
RUN cpanm Carton@v1.0.22

ADD cpanfile /app/
ADD cpanfile.snapshot /app/

WORKDIR /app

ADD . /app

RUN carton install --deployment

CMD carton exec perl -Ilib bin/comparator
