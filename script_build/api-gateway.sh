aws --endpoint-url=http://localhost:4566 apigateway put-integration \
    --region us-west-2 \
    --rest-api-id zt15esl4lh \
    --resource-id pea3umucf9 \
    --http-method ANY \
    --type HTTP \
    --integration-http-method ANY \
    --uri arn:aws:apigateway:us-west-2:lambda:path/2015-03-31/functions/arn:aws:lambda:us-west-2:000000000000:function:lambda-api-gateway/invocations \
    --credentials arn:aws:iam::000000000000:role/apigAwsProxyRole > resultado.json

# aws --endpoint-url=http://localhost:4566 apigateway \
#     put-integration \
#     --rest-api-id 1234123412 \
#     --resource-id a1b2c3 \
#     --http-method GET \
#     --type AWS \
#     --integration-http-method POST \
#     --uri 'arn:aws:apigateway:us-west-2:lambda:path//2015-03-31/functions/arn:aws:lambda:us-west-2:123412341234:function:function_name/invocations'