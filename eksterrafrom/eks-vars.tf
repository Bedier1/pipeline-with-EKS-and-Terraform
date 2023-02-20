variable "cluster_service_ipv4_cidr" {
    description = "service ipv4 for k8s"
    default =  null
}
variable "cluster_version" {
    default = 1.24
}
variable "cluster_endpoint_private_access" {
    default =  false
}
variable "cluster_endpoint_public_access" {
  default =  true 
}
variable "cluster_endpoint_public_access_cidrs" {
    default = ["0.0.0.0/0"]
}