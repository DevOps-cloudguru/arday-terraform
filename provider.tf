terraform {
  backend "s3" {
    bucket   = "terraform-cloudguru-hh-test"
    key      = "terraform-cloudgurur.tfstate"
    dynamodb_table = "terarform.lock"
    region   = "us-east-2"
  }
}



