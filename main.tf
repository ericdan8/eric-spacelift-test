terraform {
  required_version = "~> 1.10.0"
  required_providers {
    spacelift = {
      source = "spacelift-io/spacelift"
    }
  }
}

provider "aws" {
  region              = "us-east-1"
}

provider spacelift {}

resource "spacelift_context" "terraform_1_10_1" {
  description = "context for using terraform 1.10.1"
  name = "Terraform 1.10.1"
  before_init = [
    "wget --quiet https://releases.hashicorp.com/terraform/1.10.1/terraform_1.10.1_linux_amd64.zip",
    "unzip terraform_1.10.1_linux_amd64.zip",
    "export PATH=$PATH:~/",
    "mv terraform ~/terraform"
  ]
}

resource "spacelift_mounted_file" "terraform_workflow_config" {
  context_id = spacelift_context.terraform_1_10_1.id
  relative_path = "source/.spacelift/workflow.yml"
  content = filebase64("${path.module}/workflow.yml")
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