# CRIA AS ROLES
aws --endpoint-url=http://localhost:4566 iam create-role \
--role-name lambda-role-exec --assume-role-policy-document '{"Version": "2012-10-17","Statement": [{ "Effect": "Allow", "Principal": {"Service": "lambda.amazonaws.com"}, "Action": "sts:AssumeRole"}]}'

echo "criou a role"
# POLICY
aws --endpoint-url=http://localhost:4566 iam attach-role-policy \
--role-name lambda-role-exec \
--policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
echo "populou a policy"

# CRIA A LAMBDA
aws --endpoint-url=http://localhost:4566 lambda create-function \
--function-name lambda-api-gateway \
--zip-file fileb://api-gateway-lambda.zip \
--handler api \
--runtime python3.8 \
--role arn:aws:iam::000000000000:role/lambda-role-exec
# echo 'criou a lambda'

aws --endpoint-url=http://localhost:4566 lambda \
    update-function-code \
    --function-name  lambda-api-gateway \
    --zip-file fileb://api-gateway-lambda.zip