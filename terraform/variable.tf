variable "region" {
default = "us-west-2"
}

variable "image_id" {
type =     string
default  = "ami-0b53285ea6c7a08a7"
}

variable "instance_type" {
type =     string
default  = "t2.micro"
}