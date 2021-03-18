provider "aws" {
    profile = "saml"
    shared_credentials_file = "/root/.aws/credentials"
    region = "${var.aws_region}"
#    version = "2.70.0"
}
