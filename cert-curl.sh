CERTS=./mycerts
curl -v --cacert $CERTS/myCA.pem --key $CERTS/grizzly.key --cert $CERTS/grizzly.crt https://localhost:9999/hello
