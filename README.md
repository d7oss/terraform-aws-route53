# Terraform modules for AWS Route53

Make it easier to handle DNS zones and records in AWS.


## Available modules

### d7oss/route53/aws//zone

A DNS zone.

```hcl
module "dns_zone" {
  source = "d7oss/route53/aws//zone"
  version = "~> 1.0"  # >= 1.0.0, < 2.0.0

  name = "example.com"
  comment = "Main application platform."
}

module "private_dns_zone" {
  source = "d7oss/route53/aws//zone"
  version = "~> 1.0"  # >= 1.0.0, < 2.0.0

  name = "internal.example.com"

  vpc = {  # Associate to a VPC
    id = aws_vpc.main.id
    region = data.aws_region.current.name
  }
}
```


### d7oss/route53/aws//record

```hcl
module "dns_mx_records" {
  source = "d7oss/route53/aws//record"
  # version = set me

  for_each = {
    "example.com": [
      "1 ASPMX.L.GOOGLE.COM",
      "5 ALT1.ASPMX.L.GOOGLE.COM",
      "5 ALT2.ASPMX.L.GOOGLE.COM",
      "10 ALT3.ASPMX.L.GOOGLE.COM",
      "10 ALT4.ASPMX.L.GOOGLE.COM",
    ],
  }

  zone_id = module.dns_zone.id
  type = "MX"
  name = each.key
  ttl = 300
  records = each.value
}

module "dns_txt_records" {
  source = "d7oss/route53/aws//record"
  # version = set me

  for_each = {
    "example.com": "some-dns-ownership-validation-key",
    "foo.example.com": "foo",
    "bar.example.com": "bar",
  }

  zone_id = module.dns_zone.id
  type = "TXT"
  name = each.key
  ttl = 300
  records = [each.value]
}

module "dns_alias_records" {
  source = "d7oss/route53/aws//record"
  # version = set me

  for_each = {  # Mapping of objects to create aliases for
    "app.example.com": {
      dns_name = aws_lb.apps.dns_name
      zone_id = aws_lb.apps.zone_id
    },
    "cdn.example.com": {
      dns_name = aws_cloudfront_distribution.cache.domain_name
      zone_id = aws_cloudfront_distribution.cache.hosted_zone_id
    }
  }

  zone_id = module.dns_zone.id
  type = "A"
  name = each.key
  alias = {
    name = each.value.dns_name
    zone_id = each.value.zone_id
    evaluate_target_health = true
  }
}

```
