variable "cluster_name" {
    description = "The name of the ECS cluster."
    type        = string
}

variable "capacity_providers" {
    description = "A list of capacity providers to associate with the cluster."
    type        = list(string)
    default     = []
}

variable "enable_container_insights" {
    description = "Whether to enable Container Insights for the cluster."
    type        = bool
    default     = false
}

variable "tags" {
    description = "A map of tags to assign to the cluster."
    type        = map(string)
    default     = {}
}
variable "managed_termination_protection" {
    description = "Whether to enable managed termination protection for the cluster."
    type        = bool
    default     = false
}

variable "default_capacity_provider_strategy" {
    description = "The default capacity provider strategy to use for the cluster."
    type        = list(object({
        capacity_provider = string
        weight            = number
        base              = number
    }))
    default     = []
}