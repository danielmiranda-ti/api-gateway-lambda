ROOT=$PWD
BUILD_PACKEGE_NAME="api-gateway-lambda.zip"
echo $ROOT
pip install -r requirements.txt --target packages/ --find-links ./packages

cd packages
zip -r ../$BUILD_PACKEGE_NAME .            
cd ..
rm -rf packages
zip -g $BUILD_PACKEGE_NAME *.py
cd $ROOT

# cp $BUILD_PACKEGE_NAME script_build