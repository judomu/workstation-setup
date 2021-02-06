#!/usr/bin/env bash
s3fs {{s3bucket}} /home/{{username}}/private-aws -o passwd_file=/home/{{username}}/.aws.cred
keepassxc &
