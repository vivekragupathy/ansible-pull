#!/bin/bash

token=1234
url="https://$token:x-oauth-basic@github.com/epomatti/ansible-pull-demo.git"

ansible-pull -U $url -d /opt/epomatti/ansible-pull-demo
