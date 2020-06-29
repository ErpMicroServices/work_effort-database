FROM postgres:10

ENV POSTGRES_DB=work-effort_database
ENV POSTGRES_USER=work-effort_database
ENV POSTGRES_PASSWORD=work-effort_database

RUN apt-get update -qq && \
    apt-get install -y apt-utils postgresql-contrib

COPY build/database_up.sql /docker-entrypoint-initdb.d/
