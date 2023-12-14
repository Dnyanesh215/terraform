resource "aws_iam_user" "myuser" {
  for_each = toset(["Jack", "James", "TDave"])
  name     = each.key
}
