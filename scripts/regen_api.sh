rm -rf client-libs
openapi-generator-cli generate -g python -i content-api/openapi.yaml -o client-libs
