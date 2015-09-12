#!/bin/bash
. /usr/sbin/sm_environment.env
export PYTHONPATH="/usr/local/src/security_monkey/"
export SECURITY_MONKEY_SETTINGS="/usr/local/src/security_monkey/env-config/config-deploy.py"
python /usr/local/src/security_monkey/manage.py run_api_server &
