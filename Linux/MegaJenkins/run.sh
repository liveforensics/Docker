#!/bin/bash

/opt/splunkforwarder/bin/splunk start --accept-license --answer-yes --no-prompt
/usr/local/bin/jenkins.sh
/usr/sbin/sshd -D
