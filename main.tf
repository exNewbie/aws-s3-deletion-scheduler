terraform {
  backend "s3" {
    bucket  = "tf-terraform-state"
    region  = "ap-southeast-2"
    key     = "s3-deletion-scheduler"
    profile = "personal"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "s3_deletion_scheduler" {
  source = "./resources"

  bucket_name     = var.bucket_name
  file_extensions = var.file_extensions
  days_old        = var.days_old
}
