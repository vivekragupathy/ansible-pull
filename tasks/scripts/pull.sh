#!/bin/bash

OAUTH_TOKEN=$(<"/opt/secrets/gh_token")
/usr/bin/ansible-pull -o -U https://$OAUTH_TOKEN:x-oauth-basic@github.com/epomatti/ansible-pull-demo
