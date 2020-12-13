#!/bin/bash




openssl genrsa -aes256 -out privateKey.pem #private key

openssl genrsa -aes256 -out privateKey.pem 2048 #key length, will overwrite the one above

openssl req -utf8 -new -key privateKey.pem -x509 -days 365 -out mycert.crt #self signed certificate

openssl x509 -in mycert.crt -text -noout | cat #see the information stored in the certificate

openssl req -new -key privateKey.pem -out myreq.csr #Certificate Signing Request (instead of self-signed)



[ CA ]

openssl ca #can give CA info


{CA Config}
mkdir -p /etc/pki/CA/private/
openssl genrsa -aes256 2048 > /etc/pki/CA/private/cakey.pem #generate private key
openssl req -utf8 -new -key /etc/pki/CA/private/cakey.pem -x509 -days 365 -out \
    /etc/pki/CA/cacert.pem -set_serial 0 #self signed
touch /etc/pki/CA/index.txt
echo '00' > /etc/pki/CA/serial


{Signing a CSR}
mkdir /etc/pki/CA/newcerts
openssl ca -in /root/myreq.csr -out /root/signedCert.crt #sign the private key
openssl x509 -in signedCert.crt -text -noout | cat #view the signed certificate



[ Private Docker Registry ]

sudo su
curl -fsSL https://get.docker.com | bash
echo "subjectAltName=IP:172.31.16.108" > /usr/lib/ssl/openssl.cnf
cd ~; mkdir certs; cd certs
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $(pwd)/test.key -out $(pwd)/test.cert
docker run -d -p 5000:5000 \
 --restart=always \
 --name=registry \
 -v /certs:/certs \
 -e REGISTRY_HTTPS_TLS_CERTIFICATE=/certs/test.cert \
 -e REGISTRY_HTTPS_TLS_KEY=/certs/test.key \
 registry:2 #create docker registry
docker ps
mkdir -p /etc/docker/certs.d/172.31.16.108:5000
cp test* /etc/docker/certs.d/172.31.16.108\:5000/
cd /etc/docker/certs.d/172.31.16.108:5000
mv test.cert ca.cert




