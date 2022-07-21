resource "aws_iam_user" "user1" {
  name = "${var.prefix}user1-${random_id.id.hex}"
  path = "/example/"

  tags = {
    project-name = "falcon"
  }
}

data "local_file" "my_pgp_pub_key" {
  filename = "./pgp/my-public-key.gpg"
}

resource "aws_iam_access_key" "user1" {
  user = aws_iam_user.user1.name
  pgp_key = data.local_file.my_pgp_pub_key.content_base64
}

#----
output "user1_id" {
  value = aws_iam_access_key.user1.id
}
output "user1_secret" {
  value = aws_iam_access_key.user1.encrypted_secret
}
