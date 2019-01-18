terraform {
  backend "s3" {
    region = "us-east-2"
    bucket = "inkeystone-com-state"
    key    = "labroots-dcos.tfstate"
  }
}