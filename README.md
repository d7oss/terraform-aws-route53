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
