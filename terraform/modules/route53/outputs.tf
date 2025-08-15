output "fqdn" {
  value = aws_route53_record.this.fqdn  
}

output "record_name" {
  value = aws_route53_record.this.name  
}