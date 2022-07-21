# terraform-abac-0

このブログ
[Scaling AWS Lambda permissions with Attribute-Based Access Control (ABAC) | AWS Compute Blog](https://aws.amazon.com/jp/blogs/compute/scaling-aws-lambda-permissions-with-attribute-based-access-control-abac/)
の最初のサンプルを
Terraformで作ってみた。


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
./make_env.sh
./decode_secret.sh  # GPGのパスフレーズ聞いてくる
```

テストの実行は
```bash
./invoke_test.sh
```
