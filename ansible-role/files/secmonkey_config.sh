#!/bin/bash 

configure() {
	sed -i.backup -e '/SQLALCHEMY_DATABASE_URI/d' -e '/amazonaws.com/d' -e '/SECRET_KEY/d' -e '/SECURITY_CONFIRMABLE/d' -e '/SECURITY_RECOVERABLE/d' -e '/SECURITY_PASSWORD_SALT/d' -e '/MAIL_DEFAULT_SENDER/d' -e '/SECURITY_TEAM_EMAIL/d' -e '/SES_REGION/d' -e '/SECURITY_REGISTERABLE/d' $configfile
	sed -i.backup "/^# This will be/a ### Configured by Ansible: ###\nSQLALCHEMY_DATABASE_URI = \'postgresql://monkey:secmonkeypass@127.0.0.1:5432/secmonkeydb\'\nFQDN = \'`hostname`\'\nSECRET_KEY = \'XxXxXxufjr76yf6hFhJjkk654gGxgXxXx\'\nSECURITY_CONFIRMABLE = False\nSECURITY_RECOVERABLE = False\nSECURITY_PASSWORD_SALT = \'hfFg6Hg7yjJggJ8669hH7J654d560(9kk7H7fgg611thjJuikJHhHHG7779hH8h8h8h\'\nMAIL_DEFAULT_SENDER = \'admin@lascalia.com\'\nSECURITY_TEAM_EMAIL = [\'admin@lascalia.com\']\nSES_REGION = \'eu-west-1\'\nSECURITY_REGISTERABLE = False\n" $configfile
	sed -i.backup '/127.0.0.1\/32/d' $pg_hba
	sed -i.backup "/^# IPv4 local connections:/a host\tall\tall\t127.0.0.1/32\ttrust" $pg_hba

}

install() {
	cd /usr/local/src/security_monkey/
	python manage.py db upgrade
}

admin() {

	sed -i.backup '/db.drop_all\(\)/a \
\n@manager.command \
def create_user(): \
    """Creates new user login """ \
    from flask import Flask \
    from flask import render_template \
    from flask.ext.sqlalchemy import SQLAlchemy \
    app = Flask(__name__) \
    app.config.from_envvar("SECURITY_MONKEY_SETTINGS") \
    db = SQLAlchemy(app) \
    from security_monkey.datastore import User, Role \
    from flask.ext.security import Security, SQLAlchemyUserDatastore \
    from flask.ext.security.utils import encrypt_password \
    from flask.ext.security.registerable import register_user \
    user_datastore = SQLAlchemyUserDatastore(db, User, Role) \
    user_datastore.create_user(email='ADMIN_EMAIL', password=encrypt_password('ADMIN_PASSWORD')) \
    db.session.commit() \n
' /usr/local/src/security_monkey/manage.py

}

pg_hba="/var/lib/pgsql/data/pg_hba.conf"
configfile="/usr/local/src/security_monkey/env-config/config-deploy.py"
export SECURITY_MONKEY_SETTINGS="$configfile"
killall -TERM postgres
configure
runuser -l postgres -c "/usr/bin/postgres -D /var/lib/pgsql/data -p 5432 &"
sleep 10
install
sleep 3
admin
