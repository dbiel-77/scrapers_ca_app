FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Base setup
RUN apt-get -y update
# PostgreSQL
RUN apt-get -y install postgresql libpq-dev postgresql-client postgresql-client-common gdal-bin postgresql-contrib postgis
# Python
RUN apt-get -y install python3 python3-pip python3-dev build-essential python3-invoke python3-lxml python3-unidecode python3-regex libxml2-dev libxslt-dev lib32z1-dev git sudo
RUN apt-get clean
RUN pip3 install virtualenv virtualenvwrapper ndg_httpsclient flake8

RUN pip3 install --no-cache-dir \
    django==4.2.21 \
    dj-database-url>=1.0.0 \
    opencivicdata==3.4.0 \
    pupa==0.11.0 \
    psycopg2-binary \
    gunicorn \
    dj-static

RUN find /usr/local/lib/python3.10/dist-packages/pupa -type f -name '*.py' \
    -exec sed -i \
      -e 's|from django.contrib.postgres.fields import JSONField|from django.db.models import JSONField|g' \
      {} +

# Bring in your project
WORKDIR /src
RUN mkdir scrapers-ca-app
COPY . /src/scrapers-ca-app

# .bashrc
RUN echo 'export WORKON_HOME=$HOME/.virtualenvs' >> $HOME/.bashrc
RUN echo 'export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3.10' >> $HOME/.bashrc
RUN echo 'export PROJECT_HOME=/src/scrapers-ca' >> $HOME/.bashrc
RUN echo 'source /usr/local/bin/virtualenvwrapper.sh' >> $HOME/.bashrc

WORKDIR /src/scrapers-ca-app

