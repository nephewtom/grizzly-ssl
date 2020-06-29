CERTS=./mycerts
curl -v --cacert $CERTS/myCA.pem --key $CERTS/grizzly.key --cert $CERTS/grizzly.crt -X GET -H Cache-Control: no-cache https://localhost:9999/hello
