output "region" {
    value=var.region
}


output "project_name" {
    value=var.project_name
}

output "vpc_id" {
    value=aws_vpc.my-vpc.id
}

output "public_subnet_az1_id" {
    value = aws_subnet.pub_sub_az1.id
}

output "public_subnet_az2_id" {
    value = aws_subnet.pub_sub_az2.id
}

output "private_app_subnet_az1" {
    value = aws_subnet.pvt_app_sub_az1.id
}

output "private_app_subnet_az2" {
    value = aws_subnet.pvt_app_sub_az2.id
}

output "private_data_subnet_az1" {
    value = aws_subnet.pvt_dt_sub_az1.id
}

output "private_data_subnet_az2" {
    value = aws_subnet.pvt_dt_sub_az2.id
}

output "internet_gateway" {
    value= aws_internet_gateway.internet_gateway
}