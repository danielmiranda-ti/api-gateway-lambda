if [ ! -f "rs-api.json" ] 
then
    echo "Criando o arquivo rs-api.json"
    aws --endpoint-url=http://localhost:4566 apigateway \
        create-rest-api --name 'HelloWorld (AWS CLI)' \
        --region us-west-2 > rs-api.json
fi

rest_api_str=$(cat rs-api.json | jq -c '.id')
rest_api=`echo $rest_api_str | sed -e 's/\"//g'`
echo $rest_api

if [ ! -f "resource.json" ]
then
    echo "Criando o arquivo resource.json"
    aws --endpoint-url=http://localhost:4566 \
        apigateway get-resources \
        --rest-api-id $rest_api \
        --region us-west-2 > resource.json
fi

parent_id_str=$(cat resource.json | jq -c '.items[0].id')
parent_id=`echo $parent_id_str | sed -e 's/\"//g'`
echo $parent_id
# {
#    "id": "7qcgstiv85",
#    "path": "/"
# }

if [ ! -f "crt_resource.json" ]
then
    aws --endpoint-url=http://localhost:4566 apigateway \
        create-resource \
        --rest-api-id $rest_api \
        --region us-west-2 \
        --parent-id $parent_id \
        --path-part {proxy+} > crt_resource.json
fi

crt_rs_id_str=$(cat crt_resource.json | jq -c '.id')
crt_rs_id=`echo $crt_rs_id_str | sed -e 's/\"//g'`
echo $crt_rs_id
# {
#     "id": "pea3umucf9",
#     "parentId": "7qcgstiv85",
#     "pathPart": "{proxy+}",
#     "path": "/{proxy+}"
# }

# http://lbnh9gs9jj.execute-api.localhost.localstack.cloud:4566/local/hello
if [ ! -f "put_resource.json" ]
then
    aws --endpoint-url=http://localhost:4566 apigateway \
        put-method --rest-api-id $rest_api \
        --region us-west-2 \
        --resource-id $crt_rs_id \
        --http-method ANY \
        --authorization-type "NONE" > put_resource.json
fi
# 
echo "Chegou aqui sem erros..."
if [ ! -f "result.json" ]
then
    aws --endpoint-url=http://localhost:4566 \
        apigateway put-integration \
        --region us-west-2 \
        --rest-api-id $rest_api \
        --resource-id $crt_rs_id \
        --http-method ANY \
        --type AWS_PROXY \
        --integration-http-method POST \
        --uri arn:aws:apigateway:us-west-2:lambda:path/2015-03-31/functions/arn:aws:lambda:us-west-2:000000000000:function:lambda-api-gateway/invocations \
        --credentials arn:aws:iam::000000000000:role/apigAwsProxyRole > result.json
fi
# arn:aws:apigateway:${AWS::Region}:lambda:path/2015-03-31/functions/${LambdaArn1}/invocations
#  --integration-http-method POST \

# cd script_build
# ./script_build/build_lambda.sh
# ./script_build/lambda.sh
# ./script_build/api-gateway.sh