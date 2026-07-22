#!/bin/bash

# Update system
dnf update -y

# Install NGINX
dnf install -y nginx wget openssl

# Configure NGINX
TOKEN=$(aws secretsmanager get-secret-value \
--secret-id dynatrace/api-token \
--query SecretString \
--output text)

echo "Hi Shashi, from token: $TOKEN" > /usr/share/nginx/html/index.html

systemctl enable nginx
systemctl restart nginx

# Download OneAgent
wget -O Dynatrace-OneAgent.sh "https://aav98370.live.dynatrace.com/api/v1/deployment/installer/agent/unix/default/latest?arch=x86" \
--header="Authorization: Api-Token $TOKEN"

# Download Dynatrace Root Certificate
wget https://ca.dynatrace.com/dt-root.cert.pem

# Verify installer signature
(
echo 'Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="--SIGNED-INSTALLER"'
echo
echo
echo '----SIGNED-INSTALLER'
cat Dynatrace-OneAgent.sh
) | openssl cms -verify -CAfile dt-root.cert.pem > /dev/null

# Install OneAgent
/bin/sh Dynatrace-OneAgent.sh \
--set-app-log-content-access=true \
--set-infra-only=false