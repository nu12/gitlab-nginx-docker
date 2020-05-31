# TL;DR

Official Gitlab documentaton lacks informatin to setup Gitlab + Nginx in different contianers using SSL. This docker-compose file and nginx configuration files can be used to accomplish this.

## Setup

Edit `/etc/hosts` to point `example.com` and `gitlab.example.com` to `127.0.0.1`. Add the following:

```
127.0.0.1 example.com
127.0.0.1 gitlab.example.com
```

Create a self signed certificate:

``` shell
$ sudo openssl genpkey -algorithm rsa -pkeyopt rsa_keygen_bits:2048 -out /etc/ssl/certs/my_cert.key
$ sudo openssl req -x509 -key /etc/ssl/certs/my_cert.key -out /etc/ssl/certs/my_cert.crt -days 360 -addext "subjectAltName = DNS:example.com,DNS:*.example.com,IP:127.0.0.1"
```

Note 1: if you are setting this up in a VM, replace localhost IP with the VM IP.

Note 2: if you are setting this up in a production environment, or if you need a valid certificate, replace the self signed with a proper one.

## Deploy

```shell
$ docker-compose up -d
```

Folder `conf.d` contains configuration files for `example.com` and `gitlab.example.com`, both redirecting to HTTPS.