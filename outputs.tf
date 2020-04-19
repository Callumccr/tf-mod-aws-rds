# -----------------------------------------------------------------------------
# Outputs: TF-MOD-RDS  
# -----------------------------------------------------------------------------

output "instance_id" {
  value       = aws_db_instance.default.*.id
  description = "ID of the instance"
}

output "instance_arn" {
  value       = aws_db_instance.default.*.arn
  description = "The ARN of the RDS instance."
}

output "instance_address" {
  value       = aws_db_instance.default.*.address
  description = "Address of the instance"
}

output "instance_endpoint" {
  value       = aws_db_instance.default.*.endpoint
  description = "DNS Endpoint of the instance"
}

output "subnet_group_id" {
  value       = aws_db_subnet_group.default.*.id
  description = "ID of the Subnet Group"
}

output "security_group_id" {
  value       = aws_security_group.default.*.id
  description = "ID of the Security Group"
}

output "parameter_group_id" {
  value       = aws_db_parameter_group.default.*.id
  description = "ID of the Parameter Group"
}

output "option_group_id" {
  value       = aws_db_option_group.default.*.id
  description = "ID of the Option Group"
}

output "hostname" {
  value       = module.dns.hostname
  description = "RDS hostname"
}

output "username" {
  value       = aws_db_option_group.default.*.username
  description = "The username  for logging in to the database."
  sensitive   = true
}

output "password" {
  value       = aws_db_option_group.default.*.password
  description = "The password for logging in to the database."
  sensitive   = true
}
