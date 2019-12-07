#!/bin/bash

/opt/splunkforwarder/bin/splunk start --accept-license --answer-yes --no-prompt
/usr/sbin/sshd -D
