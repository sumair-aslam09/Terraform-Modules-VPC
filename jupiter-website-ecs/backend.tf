#Store the Terraform state file in s3
terraform {
    backend "s3" {
        bucket = "terraform-state-bt"
        key="jupiter-project.tfstate"
        region="ap-south-1"
    }
}