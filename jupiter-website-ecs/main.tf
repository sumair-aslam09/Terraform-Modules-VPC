#configure AWS Provider
provider "aws" {
    region = "ap-south-1"
}

#create vpc using module
module "vpc" {
    source                  =   "../modules/vpc"
    region                  =   var.region
    project_name            =   var.project_name
    vpc_cidr                =   var.vpc_cidr
    pub_sub_az1_cidr        =   var.pub_sub_az1_cidr
    pub_sub_az2_cidr        =   var.pub_sub_az2_cidr
    pvt_app_sub_az1_cidr    =   var.pvt_app_sub_az1_cidr
    pvt_app_sub_az2_cidr    =   var.pvt_app_sub_az2_cidr
    pvt_dt_sub_az1_cidr     =   var.pvt_dt_sub_az1_cidr
    pvt_dt_sub_az2_cidr     =   var.pvt_dt_sub_az2_cidr

}