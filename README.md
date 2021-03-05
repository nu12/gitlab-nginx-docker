# TL;DR

Use `certbot` to generate SSL certificates:
```shell
$ sudo certbot certonly --cert-name gitlab -d gitlab.your-domain.com
```

Config `gitlab.your-domain.com` in the docker-compose and gitlab.conf files.

(OPTIONAL) Configure Mailgun credentials:
```shell
$ export SMTP_USER=your-mailgun-user
$ export SMTP_PW=your-mailgun-password
```

Deploy:
```shell
$ docker-compose up -d
```

# Gitlab + Nginx with SSL using Docker

Official Gitlab documentaton lacks informatin to setup Gitlab + Nginx in different contianers using SSL. This docker-compose file and nginx configuration files can be used to accomplish this.

The current docker-compose file is configured to use Mailgun to send emails.

