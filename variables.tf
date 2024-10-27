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

variable "log_group" {
  type        = string
  description = "The name of the log group to use for the function or null for default"
  default     = null
}

variable "log_json" {
  type        = bool
  description = "true for JSON logging, false for standard"
  default     = false
}

variable "app_log_level" {
  type        = string
  description = "The log level for the application"
  default     = "INFO"
  validation {
    condition     = can(regex("^(DEBUG|INFO|WARN|ERROR|FATAL)$", var.app_log_level))
    error_message = "app_log_level must be one of DEBUG, INFO, WARN, ERROR, FATAL"
  }
}

variable "sys_log_level" {
  type        = string
  description = "The log level for the system"
  default     = "INFO"
  validation {
    condition     = can(regex("^(DEBUG|INFO|WARN)$", var.sys_log_level))
    error_message = "sys_log_level must be one of DEBUG, INFO, WARN"
  }
}

variable "log_infrequent" {
  type        = bool
  description = "True for Infrequence Access log class"
  default     = false
}

## Schedule related variables
variable "schedule_expression" {
  type        = string
  description = "The schedule expression for the rule"
  default     = null
}

variable "schedule_payload" {
  type        = map(string)
  description = "The payload to pass to the scheduled function"
  default     = {}
}

variable "schedule_timezone" {
  type        = string
  description = "The timezone for the schedule"
  default     = "Europe/London"
}

variable "schedule_start_date" {
  type        = string
  description = "The start date for the schedule"
  default     = null
}

variable "schedule_end_date" {
  type        = string
  description = "The end date for the schedule"
  default     = null
}

## Event related variables
variable "event_pattern" {
  type        = string
  description = "The event pattern to use for the event rule"
  default     = null
}

variable "event_bus_name" {
  type        = string
  description = "The name of the event bus to use for the event rule"
  default     = "default"
}

variable "layers" {
  type        = list(string)
  description = "list of layers to add to the lambda function"
  default     = []
}

variable "tracing_mode" {
  type        = string
  description = "The tracing mode to use for the function"
  default     = "PassThrough"
  validation {
    condition     = can(regex("^(Active|PassThrough)$", var.tracing_mode))
    error_message = "tracing_mode must be one of Active, PassThrough"
  }
}