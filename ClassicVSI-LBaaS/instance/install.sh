#!/usr/bin/env bash

# Install sysdig agent

curl -sL https://ibm.biz/install-sysdig-agent | sudo bash -s -- -a 656a290c-a9a5-444b-9c47-8599be8f774a -c ingest.private.us-south.monitoring.cloud.ibm.com --collector_port 6443 --secure true -ac "sysdig_capture_enabled: false"

## Update machine
DEBIAN_FRONTEND=noninteractive apt -qqy update
DEBIAN_FRONTEND=noninteractive apt-get -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' upgrade

## Install Apache 
DEBIAN_FRONTEND=noninteractive apt -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' install apache2 

cat <<EOF > /tmp/index.html
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
</head>
<body>
   <h1>HOSTNAME</h1>
    </body>
    </html>
EOF

hst=`hostname -f`

sed -i "s|HOSTNAME|$hst|g" /tmp/index.html 

systemctl stop apache2
mv /var/www/html/index.html{,.bak}
mv /tmp/index.html /var/www/html/index.html
systemctl start apache2
