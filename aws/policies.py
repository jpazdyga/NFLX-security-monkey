#!/usr/bin/python

import boto

iam = boto.connect_iam()
AccountId = iam.get_user()['get_user_response']['get_user_result']['user']['arn'].split(':')[4]

UserPolicyName = "SM_ASSUMEROLE"
RolePolicyName = "SecurityMonkeyReadOnly"

trusted_relationships_json = '''{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::''' + AccountId + ''':user/security_monkey_docker_user"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
'''
role_policy_json = '''{
  "Statement": [
    {
      "Action": [
        "cloudwatch:Describe*",
        "cloudwatch:Get*",
        "cloudwatch:List*",
        "ec2:Describe*",
        "elasticloadbalancing:Describe*",
        "iam:List*",
        "iam:Get*",
        "route53:Get*",
        "route53:List*",
        "rds:Describe*",
        "s3:GetBucketAcl",
        "s3:GetBucketCORS",
        "s3:GetBucketLocation",
        "s3:GetBucketLogging",
        "s3:GetBucketPolicy",
        "s3:GetBucketVersioning",
        "s3:GetLifecycleConfiguration",
        "s3:ListAllMyBuckets",
        "sdb:GetAttributes",
        "sdb:List*",
        "sdb:Select*",
        "ses:Get*",
        "ses:List*",
        "sns:Get*",
        "sns:List*",
        "sqs:GetQueueAttributes",
        "sqs:ListQueues",
        "sqs:ReceiveMessage"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
'''

user_policy_json = '''{
  "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "Stmt1415584016000",
        "Effect": "Allow",
        "Action": [
          "sts:AssumeRole"
        ],
        "Resource": [
          "arn:aws:iam::''' + AccountId + ''':role/SecurityMonkey"
        ]
      }
    ]
}
'''
