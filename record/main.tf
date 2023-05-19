resource "aws_route53_record" "main" {
  /*
  The DNS record
  */
  name = var.name
  zone_id = var.zone_id
  ttl = var.ttl
  type = var.type
  records = var.records

  dynamic alias {
    for_each = var.alias == null ? [] : [true]
    content {
      name = var.alias.name
      zone_id = var.alias.zone_id
      evaluate_target_health = var.alias.evaluate_target_health
    }
  }
}
