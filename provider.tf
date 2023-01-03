### different ways to setup backends/providers

#### to use external/cloud backend is more secure and reliable 

# for S3 backend of our infrastructure
terraform {
  backend "s3" {
    bucket         = "terraform-cloudguru-hh-test"
    key            = "terraform-cloudgurur.tfstate"
    dynamodb_table = "terarform.lock"
    region         = "us-east-2"
  }
}

##### for local providers use
#############################
# to provide configuration that terraform need to know
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

# Provider block, provides the information need to access AWS specificly
provider "aws" {
  region = "eu-north-1"
  # region                   = "us-west-2"
  shared_credentials_files = [("~/.aws/credentials")]
  # shared_credentials_file = "/Users/M ROBLE/.aws/credentials"
  profile = "devenv01"
  # profile = "arday1"
}
# a provider is to interact with the API of your infrastructure


##### for HashiCorp terraform cloud backend is easy to manage 
terraform {
  cloud {
    organization = "ROBLE-Engineering"

    workspaces {
      name = "arday-backend"
    }
  }
}
# requires to create token and login from the terminal 
# to create token, click your avator and scroll then create new token
# terraform login will be the command to login then paste your token