#!/bin/bash -ue
# see https://devcoops.com/decrypt-aws-iam-user-login-profile-password-terraform/

export GPG_TTY=$(tty)
terraform output --raw user1_secret | base64 --decode | gpg --decrypt
echo
