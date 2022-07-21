#!/bin/sh -ue
. ./tmp_env.sh
export AWS_DEFAULT_REGION="$TFO_region"
outfile=tmp_out.txt

aws lambda invoke --function-name "$TFO_lambda1" "$outfile" --no-cli-pager
cat "$outfile"
echo
