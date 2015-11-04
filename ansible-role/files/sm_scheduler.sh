#!/bin/bash

export PYTHONPATH="/usr/local/src/security_monkey/"
export SECURITY_MONKEY_SETTINGS="/usr/local/src/security_monkey/env-config/config-deploy.py"
python /usr/local/src/security_monkey/manage.py start_scheduler &
