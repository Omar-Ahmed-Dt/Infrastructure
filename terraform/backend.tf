terraform {
  backend "s3" {
    bucket = "my-terraform-bucket-2024"
    key    = "live-project/terraform.tfstate"
    region = "us-east-1"
  }
}
