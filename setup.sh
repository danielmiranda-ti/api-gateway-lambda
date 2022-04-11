#aws --endpoint-url=http://localhost:4566 apigateway \
#    create-rest-api --name 'HelloWorld (AWS CLI)' \
#    --region us-west-2 > rs-api.json

rest_api=$(cat rs-api.json | jq -c '.id')
echo $rest_api

# aws --endpoint-url=http://localhost:4566 \
#     apigateway get-resources \
#     --rest-api-id t9231axetz \
#     --region us-west-2 > resource.json

rs_id=$(cat resource.json | jq -c '.items[0].id')
echo $rs_id
# {
#    "id": "7qcgstiv85",
#    "path": "/"
# }

#aws --endpoint-url=http://localhost:4566 apigateway \
#    create-resource \
#    --rest-api-id t9231axetz \
#    --region us-west-2 \
#    --parent-id wsjdd3gr0w \
#    --path-part {proxy+} > crt_resource.json

crt_rs=$(cat crt_resource.json | jq -c '.id')
# {
#     "id": "pea3umucf9",
#     "parentId": "7qcgstiv85",
#     "pathPart": "{proxy+}",
#     "path": "/{proxy+}"
# }

# http://zt15esl4lh.execute-api.localhost.localstack.cloud:4566/local/my/path2

#aws --endpoint-url=http://localhost:4566 apigateway \
#    put-method --rest-api-id t9231axetz \
#    --region us-west-2 \
#    --resource-id 4sv1rfmmog \
#    --http-method ANY \
#    --authorization-type "NONE" > put_resource.json

# 
aws apigateway put-integration \
        --region us-west-2 \
        --rest-api-id zt15esl4lh \
        --resource-id pea3umucf9 \
        --http-method ANY \
        --type HTTP \
        --uri arn:aws:apigateway:us-west-2:lambda:path/2015-03-31/functions/arn:aws:lambda:us-west-2:000000000000:function:lambda-api-gateway/invocations \
        --credentials arn:aws:iam::000000000000:role/apigAwsProxyRole > result.json

# arn:aws:apigateway:${AWS::Region}:lambda:path/2015-03-31/functions/${LambdaArn1}/invocations
#  --integration-http-method POST \

# cd script_build
# ./script_build/build_lambda.sh
# ./script_build/lambda.sh
# ./script_build/api-gateway.sh