#!/bin/bash 

configure() {
	sed -i.backup -e '/SQLALCHEMY_DATABASE_URI/d' -e '/amazonaws.com/d' -e '/SECRET_KEY/d' -e '/SECURITY_CONFIRMABLE/d' -e '/SECURITY_RECOVERABLE/d' -e '/SECURITY_PASSWORD_SALT/d' $configfile
	sed -i.backup "/^# This will be/a ### Configured by Docker: ###\nSQLALCHEMY_DATABASE_URI = \'postgresql://monkey:secmonkeypass@127.0.0.1:5432/secmonkeydb\'\nFQDN = \'`hostname`\'\nSECRET_KEY = \'ge5eyufjr76yf6hFhJjkk654gGggF4ga\'\nSECURITY_CONFIRMABLE = False\nSECURITY_RECOVERABLE = False\nSECURITY_PASSWORD_SALT = \'hfFg6Hg7yjJggJ8669hH7J654d560(9kk7H7ggg611thjJuikJHhHHG7779hH8h8h8h\'\n" $configfile
	sed -i.backup '/127.0.0.1\/32/d' $pg_hba
	sed -i.backup "/^# IPv4 local connections:/a host\tall\tall\t127.0.0.1/32\ttrust" $pg_hba
	tail -20 $pg_hba
}

install() {
	cd /usr/local/src/security_monkey/
	python manage.py db upgrade
}

pg_hba="/var/lib/pgsql/data/pg_hba.conf"
configfile="/usr/local/src/security_monkey/env-config/config-deploy.py"
export SECURITY_MONKEY_SETTINGS="$configfile"
killall -TERM posgres
configure
runuser -l postgres -c "/usr/bin/postgres -D /var/lib/pgsql/data -p 5432 &"
sleep 10
install
