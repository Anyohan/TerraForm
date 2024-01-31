
resource "aws_launch_configuration" "Web_lc" {
  name_prefix     = "web-lc-"
  image_id        = "ami-0bc4327f3aabf5b71"
  instance_type   = "t2.micro"
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_configuration" "App_lc" {
  name_prefix     = "app-lc-"
  image_id        = "ami-0bc4327f3aabf5b71"
  instance_type   = "t2.micro"
  
  lifecycle {
    create_before_destroy = true
  }
}