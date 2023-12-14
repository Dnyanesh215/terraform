resource "aws_s3_bucket" "my-bucket" {
  for_each = {
    dev  = "my-app-bucket-dp"
    qa   = "my-app-bucket-dp"
    test = "my-app-bucket-dp"
  }

  bucket = "${each.key}-${each.value}"
  tags = {
    enviornment = each.key
    bucket-name = "${each.key}-${each.value}"

  }
}

