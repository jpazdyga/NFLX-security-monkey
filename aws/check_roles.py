#!/usr/bin/python

try:
     import json
except ImportError:
     import simplejson as json

import time
import sys, getopt
import boto
import urllib
from jsoncompare import jsoncompare
from policies import *

def comparejson(a, b):
    result = jsoncompare.are_same(a, b)[0]
    if result:
        ## JSONs are the same ##
        print("0");
    else:
        ## JSONs are different ##
        print("1");

def comparestring(a, b):
    result = a == b
    if result == True:
        ## Strings are the same ##
        print("0");
    else:
        ## Strings are different ##
        print("1");

def usage():
    print("Usage: " + sys.argv[0] + " [user-policy-name|user-policy-document|role-policy-name|role-policy-document|role-trusted]" )

def securitymonkeyuserpolicyname():
    SecurityMonkeyUserPolicyName = iam.get_all_user_policies('security_monkey_docker_user').policy_names
    upname = SecurityMonkeyUserPolicyName[0]
    a = upname
    b = UserPolicyName
    comparestring(a, b)

def securitymonkeyuserpolicydump():
    SecurityMonkeyUserPolicyDump = iam.get_user_policy('security_monkey_docker_user','SM_ASSUMEROLE').policy_document
    updoc = urllib.unquote(SecurityMonkeyUserPolicyDump).decode('utf8');
    a = json.loads(updoc)
    b = json.loads(user_policy_json)
    comparejson(a, b)

def securitymonkeyrolepolicyname():
    SecurityMonkeyRolePolicyName = iam.get_role_policy('SecurityMonkey','SecurityMonkeyReadOnly').policy_name
    print(SecurityMonkeyRolePolicyName);

def securitymonkeyrolepolicydump():
    SecurityMonkeyRolePolicyDump = iam.get_role_policy('SecurityMonkey','SecurityMonkeyReadOnly').policy_document
    updoc = urllib.unquote(SecurityMonkeyRolePolicyDump).decode('utf8');
    a = json.loads(updoc)
    b = json.loads(role_policy_json)
    comparejson(a, b)

def securitymonkeyroletrusted():
    SecurityMonkeyRoleTrusted = iam.get_role('SecurityMonkey').assume_role_policy_document
    updoc = urllib.unquote(SecurityMonkeyRoleTrusted).decode('utf8');
    a = json.loads(updoc)
    b = json.loads(trusted_relationships_json)
    comparejson(a, b)

myopts = sys.argv[1:]
for o in myopts:
    if o == "user-policy-name":
        securitymonkeyuserpolicyname()
    elif o == "user-policy-document":
        securitymonkeyuserpolicydump()
    elif o == "role-policy-name":
        securitymonkeyrolepolicyname()
    elif o == "role-policy-document":
        securitymonkeyrolepolicydump()
    elif o == "role-trusted":
        securitymonkeyroletrusted()
    elif o in 'usage|help|--help|-h':
        usage()
    else:
        print("Wrong argument given.")
        usage()
