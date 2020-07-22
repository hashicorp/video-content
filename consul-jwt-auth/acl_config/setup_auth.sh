#!/bin/bash
consul acl policy create \
  -name "api-policy" \
  -description "Policy for API service to grant agent permisions and consul connect integration" \
  -rules @api_policy.hcl

consul acl role create \
  -name "api-role" \
  -description "Role for the API service" \
  -policy-name "api-policy" \

consul acl auth-method create -name my-jwt -type jwt -config @jwt_auth_config.json
consul acl binding-rule create -method=my-jwt -bind-type=role -bind-name=api-role -selector='value.admin==true'
