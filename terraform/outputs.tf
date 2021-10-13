output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "carrent_user" {
  value = data.aws_caller_identity.current.user_id
}

output "regions" {
  value = data.aws_region.current.name
}

output "instance_ip_addr" {
   value = aws_instance.my_aws_instance.0.private_ip
}

output "instance_network_interface_id" {
   value = aws_instance.my_aws_instance.0.primary_network_interface_id
}