#HASH=$(md5 deploy.tar.gz | awk '{print $4}')
HASH=$(find . \( -name "*.py" -o -name "*.txt" -o -name "*.yaml" \) \( -not -path "./.venv/*" -not -path "./venv/*" \) -exec cat {} \; | md5)
echo $HASH
aws s3 cp deploy.zip s3://asset2/sss/$HASH/
aws cloudformation deploy --stack-name test-demo1-app --template ./infra/serverless.yaml --parameter-overrides ZipHash=$HASH

