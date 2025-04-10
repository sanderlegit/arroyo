#!/bin/bash
# postgres-init/01-grant-superuser.sh

# Exit immediately if a command exits with a non-zero status.
set -e

# Use psql to execute the command.
# The script runs inside the container where psql is available.
# It typically runs as the 'postgres' OS user which has initial superuser access.
# $POSTGRES_USER and $POSTGRES_DB are available from the environment.
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    ALTER USER "$POSTGRES_USER" WITH SUPERUSER;
    GRANT ALL PRIVILEGES ON DATABASE "$POSTGRES_DB" TO "$POSTGRES_USER"; -- Also good practice
EOSQL

echo "Granted SUPERUSER privileges to user $POSTGRES_USER on database $POSTGRES_DB"
