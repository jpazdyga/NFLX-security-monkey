#!/bin/bash
echo -e "[Credentials]\naws_access_key_id = $AWS_ACCESS_KEY\naws_secret_access_key = $AWS_SECRET_ACCESS_KEY" > /etc/boto.cfg
