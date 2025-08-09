FROM postgres:latest

ENV POSTGRES_DB=work_effort
ENV POSTGRES_USER=work_effort
ENV POSTGRES_PASSWORD=work_effort

# Copy all migration files to init directory
# PostgreSQL will execute these in alphabetical order on first run
COPY sql/V_work*.sql /docker-entrypoint-initdb.d/

# Ensure the container uses UTF-8 encoding
ENV LANG=en_US.utf8
