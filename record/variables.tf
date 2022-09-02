variable "zone_id" {
  type = string
}

variable "type" {
  type = string
}

variable "name" {
  type = string
}

variable "ttl" {
  type = number
  default = null
}

variable "records" {
  type = list(string)
  default = null
}

variable "alias" {
  type = object({
    name = string
    zone_id = string
    evaluate_target_health = optional(bool)
  })
  default = null
}
