# https://deliciousbrains.com/ssl-certificate-authority-for-local-https-development/ 

# Generate key
# pass phrase = mycapass
openssl genrsa -des3 -out myCA.key 2048

# Generate root certificate 
openssl req -x509 -new -nodes -days 36500 -key myCA.key -sha256 -out myCA.pem

# Show/print certificate 
keytool -printcert -v -file myCA.pem

# Export to pfx & jks
# password = mycapass
openssl pkcs12 -export -nodes -out myCA.pfx -inkey myCA.key -in myCA.pem 
keytool -importkeystore -destkeystore myCA.jks -srckeystore myCA.pfx -srcstoretype pkcs12 -srcstorepass mycapass -storepass mycapass
