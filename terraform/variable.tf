variable "region" {
default = "us-west-2"
}

variable "ami" {
type =     string
default  = "ami-0b53285ea6c7a08a7"
}

variable "instance_type" {
type =     string
default  = "t2.micro"
}