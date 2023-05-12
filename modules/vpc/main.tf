#1.Create VPC
resource "aws_vpc" "my-vpc" {
    cidr_block=var.vpc_cidr
    instance_tenancy="default"
    enable_dns_support="true"
    enable_dns_hostnames="true"
    enable_classiclink="false"
    tags = {
        Name="${var.project_name}-vpc"
    }
}


#2.Create Internet Gateway &  attach it to vpc
resource "aws_internet_gateway" "internet_gateway" {
    vpc_id=aws_vpc.my-vpc.id
    tags={
        Name="${var.project_name}-ig"
    }
}

#3.Use data source to get all availability zones in a region
data "aws_availability_zones" "availability_zones" {}

#4.create public subnet az1
resource "aws_subnet" "pub_sub_az1" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block=var.pub_sub_az1_cidr
    availability_zone=data.aws_availability_zones.availability_zones.names[0]
    map_public_ip_on_launch = true

    tags= {
        Name="pub-sub-az1"
    }
}

#5.Create Public Subnet az2
resource "aws_subnet" "pub_sub_az2" {
    vpc_id=aws_vpc.my-vpc.id
    cidr_block=var.pub_sub_az1_cidr
    availability_zone=data.aws_availability_zones.availability_zones.names[1]
    map_public_ip_on_launch=true

    tags= {
        Name = "pub-sub-az2"
    }
}

#6.Create Route Table & add public Route
resource "aws_route_table" "pub_route_table" {
    vpc_id=aws_vpc.my-vpc.id

    route {
        cidr_block="0.0.0.0/0"
        gateway_id=aws_internet_gateway.internet_gateway.id
    }

    tags={
        Name="pub-route-table"
    }
}

#7.Associate "Public Sub az1" to "Public Route Table" 
resource "aws_route_table_association" "pb_sb_az1_rt" {
    subnet_id=aws_subnet.pub_sub_az1.id
    route_table_id=aws_route_table.pub_route_table.id
}

#8.Associate "Public sub az2" to "Public Route Table" 
resource "aws_route_table_association" "pb-sb-az2-rt" {
    subnet_id=aws_subnet.pub_sub_az2.id
    route_table_id=aws_route_table.pub_route_table.id
}

#9.Create Private App Subnet az1
resource "aws_subnet" "pvt_app_sub_az1" {
    vpc_id=aws_vpc.my-vpc.id
    cidr_block=var.pvt_app_sub_az1_cidr
    availability_zone=data.aws_availability_zones.availability_zones.names[0]
    map_public_ip_on_launch=false

    tags={
        Name="Pvt-app-sub-az1"
    }
}

#10.Create Private App Subnet az2
resource "aws_subnet" "pvt_app_sub_az2" {
    vpc_id=aws_vpc.my-vpc.id
    cidr_block=var.pvt_app_sub_az2_cidr
    availability_zones=data.aws_availability_zones.availability_zones.names[1]
    map_public_ip_on_launch=false

    tags={
        Name="Pvt-app-sub-az2"
    }

}

#11.Create Private data Subnet az1
resource "aws_subnet" "pvt_dt_sub_az1" {
    vpc_id=aws_vpc.my-vpc.id
    cidr_block=var.pvt_dt_sub_az1_cidr
    availability_zones=data.aws_availability_zones.availability_zones.names[0]
    map_public_ip_on_launch=false
    tags={
        Name="Pvt-dt-sub-az1"
    }
}

#12.Create Private data Sunet az2
resource "aws_subnet" "pvt_dt_sub_az2" {
    vpc_id=aws_vpc.my-vpc.id
    cidr_block=var.pvt_dt_sub_az2_cidr
    availability_zones=data.aws_availability_zones.availability_zones.names[1]
    map_public_ip_on_launch=false
    tags={
        Name="Pvt-dt-sub-az2"
    }
}
