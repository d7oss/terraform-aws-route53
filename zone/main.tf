resource "aws_route53_zone" "main" {
  /*
  The DNS zone
  */
  name = var.name
  comment = var.comment

  dynamic vpc {
    for_each = var.vpc == null ? [] : [true]
    content {
      vpc_id = var.vpc.id
      vpc_region = var.vpc.region
    }
  }
}
