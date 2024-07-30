variable "region" {
  description  = "AWS Region"
  type        = string
  default     = "us-west-2" 
}

variable "vpcid" {
  description = "VPC IDs"
  type        = string
  default     = "vpc-00000000000000000" 
}

variable "subnets" {
  description = "Subnet IDs"
  type        = list(string)
  default     = [
    "subnet-00000000000000001",
    "subnet-00000000000000002",
    "subnet-00000000000000003",
    "subnet-00000000000000004"
  ]
} 

