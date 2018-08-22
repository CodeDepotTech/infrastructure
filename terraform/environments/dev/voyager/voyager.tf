# Complete your provider information here
# Full list of providers: https://www.terraform.io/docs/providers/index.html
provider "google" {
    # provider parameters here. Override any secrets at run time and avoid storing them in source control
    project = ""
    region = ""
}

# Make a single call to the component module in the modules folder of this repo.
# Do not create any resources nor reference other modules here.
# That belongs in ../../../modules/voyager/voyager.tf
module "voyager" {
    source = "../../../modules/voyager"
    # other variables to be passed in go here
    environment_name = "${var.environment_name}"
    component_name = "${var.component_name}"
}


terraform {
    backend "s3" {
        bucket = "blah"
        key    = "terraform-remote-state/dev/voyager/terraform.tfstate"
        region = "ap-southeast-2"
    }
}

data "terraform_remote_state" "gke" {
    backend = "s3"
    config {
        bucket = "blah"
        key    = "terraform-remote-state/dev/gke/terraform.tfstate"
        region = "ap-southeast-2"
    }
}




