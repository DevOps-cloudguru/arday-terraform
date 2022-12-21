resource "random_integer" "random" {
    max= 4
    min= 2
  byte_length = 8
}
 resource "aws_iam_user" "Ahmed" {
    count = 2
   name = "T-Ahmed-${random_integer.random.id}"
}
  
