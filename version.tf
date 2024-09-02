terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "4.4.0"
    }
  }
}

provider "hcp" {
  # Configuration options
}

provider "vault" {
  # Configuration options
  address = "http://127.0.0.1:8200"
  token   = var.vault-token
}

# data "vault_aws_static_access_credentials" "creds" {
#   backend = vault_aws_secret_backend.aws.path
#   name    = vault_aws_secret_backend_static_role.role.role_name
# }

# vault read hellocloud-aws-master-account/static-creds/master-vpc-vault-static-role
data "vault_aws_static_access_credentials" "creds" {
  name    = "master-vpc-vault-static-role"  # ) The name of the AWS secret backend static role to read credentials from
  backend = "hellocloud-aws-master-account" # The path to the AWS secret backend to read credentials from
}


# provider "aws" {
#  profile = "master-vpc-vault-static-role"
#  region = "ap-southeast-1"
# }

provider "aws" {
  access_key = data.vault_aws_static_access_credentials.creds.access_key
  secret_key = data.vault_aws_static_access_credentials.creds.secret_key
  region     = "ap-southeast-1"
  alias = "master-singapore-vpc"
}