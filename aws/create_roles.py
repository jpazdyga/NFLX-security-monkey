#!/usr/bin/python

try:
 import json
except ImportError:
 import simplejson as json

import time
import boto
from pprint import pprint
from policies import *

SecurityMonkeyRole = iam.create_role('SecurityMonkey')
SecurityMonkeyPolicy = iam.put_role_policy('SecurityMonkey','SecurityMonkeyReadOnly',role_policy_json)
SecurityMonkeyUser = iam.create_user('security_monkey_docker_user')
SecurityMonkeyPolicy = iam.put_user_policy('security_monkey_docker_user','SM_ASSUMEROLE',user_policy_json)
time.sleep(10)
SecurityMonkeyRelationship = iam.update_assume_role_policy('SecurityMonkey',trusted_relationships_json)

CreateAccessKeys = iam.create_access_key('security_monkey_docker_user')
id = CreateAccessKeys.access_key_id
keys = CreateAccessKeys.secret_access_key;
print("access_key_id: " + id + "\n" + "secret_access_key: " + keys);
