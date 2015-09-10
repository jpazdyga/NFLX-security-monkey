#!/bin/bash

postgresetup() {
	runuser -l postgres -c "psql postgres <<< \"CREATE USER monkey WITH SUPERUSER;\""
	runuser -l postgres -c "psql postgres <<< \"ALTER USER monkey WITH PASSWORD 'secmonkeypass';\""
	runuser -l postgres -c "psql postgres <<< \"CREATE DATABASE secmonkeydb OWNER monkey;\""
}

killall -TERM postgres
sleep 10
runuser -l postgres -c "/usr/bin/postgres -D /var/lib/pgsql/data -p 5432 &"
sleep 10
postgresetup
