#/bin/bash

certgen() {
	openssl genrsa -out server.key 4096
	openssl rsa -in server.key -out server.key.insecure
	mv server.key server.key.secure
	mv server.key.insecure server.key
	openssl req -new -key server.key -out server.csr -subj "/C=UK/ST=SE/L=London/O=IT/CN=www.ft.com"
	openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
	cp server.key /etc/ssl/private/
	cp server.crt /etc/ssl/certs/
}

nginxconf() {
	mkdir -p /etc/nginx/sites-enabled/
	ln -s /etc/nginx/sites-available/securitymonkey.conf /etc/nginx/sites-enabled/securitymonkey.conf
	sed -i.orig '/conf\.d\/\*.conf/a \    include \/etc/nginx\/sites-enabled\/*.conf;' /etc/nginx/nginx.conf
	rm -fr /etc/nginx/sites-enabled/default
}

certgen
nginxconf
