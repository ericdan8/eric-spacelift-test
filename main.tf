provider "aws" {
  region              = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket        = "eric-spacelift-test-bucket-2"
}

variable "foo" {
  type        = string
  validation {
    condition     = var.foo == "bar"
    error_message = "Please provide bar."
  }
}