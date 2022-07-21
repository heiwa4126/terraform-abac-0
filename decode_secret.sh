#!/bin/bash -ue
. ./tmp_env.sh

ENVFILE=./tmp_cred.sh

export GPG_TTY=$(tty)
user1_secret=$(echo $TFO_user1_secret | base64 --decode | gpg --decrypt -q)
user2_secret=$(echo $TFO_user2_secret | base64 --decode | gpg --decrypt -q)

echo "user1_id=$TFO_user1_id" >$ENVFILE
echo "user1_secret=$user1_secret" >>$ENVFILE
echo "user2_id=$TFO_user2_id" >>$ENVFILE
echo "user2_secret=$user2_secret" >>$ENVFILE
