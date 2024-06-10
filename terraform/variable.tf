variable "region" {
default = "us-west-2"
}

variable "ami" {
type =     string
default  = "ami-06373f703eb245f45"
}

variable "instance_type" {
type =     string
default  = "t2.micro"
}