#!/usr/bin/python

try:
 import json
except ImportError:
 import simplejson as json

import boto
from pprint import pprint

iam = boto.connect_iam()

SecurityMonkeyPolicy = iam.delete_role_policy('SecurityMonkey','SecurityMonkeyReadOnly')
SecurityMonkeyRole = iam.delete_role('SecurityMonkey')
SecurityMonkeyUserPolicy = iam.delete_user_policy('security_monkey_docker_user','SM_ASSUMEROLE')

GetAccessKeys = iam.get_all_access_keys('security_monkey_docker_user')
for i in GetAccessKeys.access_key_metadata:
  print(i.access_key_id)
  keys = i.access_key_id

SecurityMonkeyKeys = iam.delete_access_key(i.access_key_id,user_name='security_monkey_docker_user')
SecurityMonkeyUser = iam.delete_user('security_monkey_docker_user')
