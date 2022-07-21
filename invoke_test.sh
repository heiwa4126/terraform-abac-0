#!/bin/bash -u
. ./tmp_env.sh
export AWS_DEFAULT_REGION="$TFO_region"
outfile=tmp_out.txt

echo "
**** default account (it'll work)"
aws lambda invoke --function-name "$TFO_lambda1" "$outfile" --no-cli-pager
cat "$outfile"
echo

. ./tmp_cred.sh

echo "
**** user1 (it'll be fail)"
export AWS_ACCESS_KEY_ID="$user1_id"
export AWS_SECRET_ACCESS_KEY="$user1_secret"
aws sts get-caller-identity --no-cli-pager
aws lambda invoke --function-name "$TFO_lambda1" "$outfile" --no-cli-pager
cat "$outfile"
echo

echo "
**** user2 (it'll work)"
export AWS_ACCESS_KEY_ID="$user2_id"
export AWS_SECRET_ACCESS_KEY="$user2_secret"
aws sts get-caller-identity --no-cli-pager
aws lambda invoke --function-name "$TFO_lambda1" "$outfile" --no-cli-pager
cat "$outfile"
echo
