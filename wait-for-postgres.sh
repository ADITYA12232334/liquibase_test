#!/bin/sh

echo "Waiting for PostgreSQL..."

until pg_isready -h postgres -p 5432 -U admin -d taskdb
do
  echo "Postgres is unavailable - sleeping"
  sleep 2
done

echo "PostgreSQL is up!"

# Run Liquibase after DB is ready
liquibase \
  --url=jdbc:postgresql://postgres:5432/taskdb \
  --username=admin \
  --password=admin \
  --changelog-file=changelog/db.changelog-master.yaml \
  update