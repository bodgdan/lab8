#!/bin/bash
aws ec2 run-instances --image-id ami-053b0d53c279acc90 --count 1 --instance-type t2.micro --key-name devops_key --security-group-ids sg-0807e541176cec6f3 --subnet-id subnet-0f597f2c6d470ed6a --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=\"Lab8\"}]" --user-data file://script8.sh
