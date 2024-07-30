#!/bin/sh

curl -k 'https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb' > /tmp/amazon-ssm-agent.deb 
dpkg -i /tmp/amazon-ssm-agent.deb
systemctl enable amazon-ssm-agent
tail -f /dev/null
