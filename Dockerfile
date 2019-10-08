FROM composer

LABEL maintainer="Yannick Pereira-Reis <yannick.pereira.reis@gmail.com>"
LABEL description="A basic composer + prestissimo image"

RUN composer global require hirak/prestissimo
