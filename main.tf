variable "region" {
  default = "ap-northeast-1"
}
variable "author_mail" {
  default = "foob@example.com"
}
variable "python" {
  default = "python3.9"
}
variable "prefix" {
  default = "abac0-"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      mail        = var.author_mail
      provided_by = "Terraform"
    }
  }
}

resource "random_id" "id" {
  byte_length = 8
}
