terraform {
  backend "s3" {
    bucket = "terraformstate-servers"
    key    = "JavaWebApp01/backend"
    region = "us-east-1"
  }
}