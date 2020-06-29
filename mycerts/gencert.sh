openssl req -new -newkey rsa:4096 -x509 -sha256 -days 36500 -nodes -out grizzly.crt -keyout grizzly.key
openssl x509 -in grizzly.crt -out grizzly.pem -outform PEM

# Set password to: awesome
openssl pkcs12 -export -nodes -out grizzly.pfx -inkey grizzly.key -in grizzly.crt

keytool -importkeystore -destkeystore grizzly.jks -srckeystore grizzly.pfx -srcstoretype pkcs12 -srcstorepass awesome -storepass awesome
-----

# Create private key
openssl genrsa -out grizzly.key 2048

# Create a CSR (Certificate Signing Request)
openssl req -new -key grizzly.key -out grizzly.csr

# Create the certificate and convert to PEM
openssl x509 -req -in grizzly.csr -CA myCA.pem -CAkey myCA.key -CAcreateserial -out grizzly.crt -days 36500 -sha256 -extfile file.ext
openssl x509 -in grizzly.crt -out grizzly.pem -outform PEM

# Export to pfx & jks
openssl pkcs12 -export -nodes -out grizzly.pfx -inkey grizzly.key -in grizzly.crt
# password: awesome
keytool -importkeystore -destkeystore grizzly.jks -srckeystore grizzly.pfx -srcstoretype pkcs12 -srcstorepass awesome -storepass awesome
