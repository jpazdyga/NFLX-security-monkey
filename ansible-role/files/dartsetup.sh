#!/bin/bash

dartsdk() {
	cd /usr/lib/
	wget https://storage.googleapis.com/dart-archive/channels/stable/release/latest/sdk/dartsdk-linux-x64-release.zip
#	wget https://storage.googleapis.com/dart-archive/channels/dev/release/1.13.0-dev.7.3/sdk/dartsdk-linux-x64-release.zip
	unzip dartsdk-linux-x64-release.zip
	rm -fr dartsdk-linux-x64-release.zip
	mv dart-sdk/ dart
	export PATH="$PATH:/usr/lib/dart/bin"
	echo 'export PATH="$PATH:/usr/lib/dart/bin"' > /etc/profile.d/dart.sh
	echo '/usr/lib/dart/lib' > /etc/ld.so.conf.d/dart.conf

}


webappbuild() {
	cd /usr/local/src/security_monkey/dart
	/usr/lib/dart/bin/pub get
	/usr/lib/dart/bin/pub build
	/bin/cp -R /usr/local/src/security_monkey/dart/build/web/* /usr/local/src/security_monkey/security_monkey/static/
}

dartsdk
webappbuild
