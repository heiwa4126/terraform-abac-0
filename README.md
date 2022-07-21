# terraform-imauser-accesskey

TerraformでIAMユーザを作りアクセスキーを得るサンプル

PGPキーがいる。なければ `gpg --gen-key`


# 参考リンク

- [Create AWS IAM User Login Profile with PGP encrypted password in Terraform | DevCoops](https://devcoops.com/create-aws-iam-user-login-profile-pgp-ecrypted-password-terraform/)
- [Decrypt iam_user_login_profile password in Terraform | DevCoops](https://devcoops.com/decrypt-aws-iam-user-login-profile-password-terraform/)
- [aws_iam_access_key | Resources | hashicorp/aws | Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key)


# 動かし方

まず
```bash
gpg --output pgp/my-public-key.gpg --export heiwa4126  # IDは自分のに変える
```

で、公開鍵をエクスポートしておく。

さらに
```bash
terraform init
terraform apply
```

で、デプロイ。正常終了したら

```bash
./decode_secret.sh
```

で、GPGのパスフレーズ入れるとデコードされる。


# メモ

いらんコードがけっこう入ったままでスイマセン。
