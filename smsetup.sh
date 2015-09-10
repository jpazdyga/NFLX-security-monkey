#!/bin/bash

codesetup() {
        cd /usr/local/src
        git clone --depth 1 --branch master https://github.com/Netflix/security_monkey.git
        cd security_monkey
        python setup.py install
}

codesetup
