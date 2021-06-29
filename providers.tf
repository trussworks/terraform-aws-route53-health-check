terraform {
  required_providers {
    aws = ">= 3.0"
  }
}
provider "aws" {
  alias = "us-east-1"
}
