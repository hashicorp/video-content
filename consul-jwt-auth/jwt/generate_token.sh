#!/usr/bin/env bash

#
# JWT Encoder Bash Script
#

# Static header fields.
header='{
	"alg": "RS512",
	"typ": "JWT"
}'

payload=$(cat <<EOF 
{
  "admin": true,
	"exp": $(date -d '+1 day' +%s),
	"iat": $(date +%s),
	"iss": "test.com",
	"nbf": $(date +%s),
	"service": "testservice"
}
EOF
)

base64_encode()
{
  base64 | tr -d '=' | tr '/+' '_-' | tr -d '\n'
}

sha256_sign()
{
  openssl dgst -sha512 -sign ./private.pem
}

header_base64=$(echo -n "${header}" | tr -d '\n' | base64_encode)
payload_base64=$(echo -n "${payload}" | tr -d '\n' | base64_encode)

header_payload=$(echo -n "${header_base64}.${payload_base64}")
signature=$(echo -n "${header_payload}" | sha256_sign | base64_encode)

echo "${header_payload}.${signature}"

echo -n "${header_payload}.${signature}" > jwt.token