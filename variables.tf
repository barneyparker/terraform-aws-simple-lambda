variable "name" {
  type        = string
  description = "The name of the function"
}

variable "description" {
  type        = string
  description = "The description of the function"
  default     = ""
}

variable "handler" {
  type        = string
  description = "The name of the function handler"
  default     = "index.handler"
}

variable "runtime" {
  type        = string
  description = "The runtime to use for the function"
  default     = "nodejs20.x"
}

variable "source_dir" {
  type        = string
  description = "The directory containing the function source code"
}

variable "log_retention" {
  type        = number
  description = "Number of days to keep CloudWatch Logs"
  default     = 7
}

variable "memory_size" {
  type        = number
  description = "The amount of memory to allocate to the function"
  default     = "128"
}

variable "timeout" {
  type        = number
  description = "The amount of time to allow the function to run"
  default     = 3
}

variable "architecture" {
  type        = string
  description = "The architecture to use for the function"
  default     = "arm64"
}

variable "env_vars" {
  type        = map(string)
  description = "Environment variables to set for the function"
  default     = {}
}

variable "policies" {
  type        = list(string)
  description = "Additional policies to attach to the function role"
  default     = []
}

variable "boundary_policy_arn" {
  type        = string
  description = "Boundary policy ARN to attach to the function role"
  default     = null

}
