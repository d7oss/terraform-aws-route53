variable "name" {
  description = "The domain name of the zone, e.g. 'example.com'."
  type = string
}

variable "comment" {
  description = "An optional comment to describe the zone."
  type = string
  default = null
}

variable "vpc" {
  description = "If a private zone, the VPC to associate."
  type = object({
    id = string
    region = optional(string)
  })
  default = null
}
