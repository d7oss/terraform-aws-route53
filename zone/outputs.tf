output "id" {
  description = "The ID of the zone."
  value = aws_route53_zone.main.zone_id
}

output "name" {
  description = "The name of the zone."
  value = aws_route53_zone.main.name
}

output "arn" {
  description = "The ARN of the zone."
  value = aws_route53_zone.main.arn
}

output "name_servers" {
  description = "The name servers of the zone."
  value = aws_route53_zone.main.name_servers
}
