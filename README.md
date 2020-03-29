# Laravel Mysql Docker
Generic docker image for Laravel Applications.

Laravel Framework version 5.3.31

### MySQL Setup
You setup MySQL host, user and password in this file: [docker-compose.yml](https://github.com/mhobesong/laravel-docker/blob/master/docker-compose.yml)


```yml
version: '3.1'

services:

  db:
    image: mysql:5.7
    command: --default-authentication-plugin=mysql_native_password
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: secret
      MYSQL_PASSWORD: secret
      MYSQL_USER: homestead
      MYSQL_DATABASE: homestead
      
      ...
```
Place the content of your Laravel application in the [app](https://github.com/mhobesong/laravel-docker/blob/master/app) folder.

### Build
`docker-compose build`

### Run
`docker-compose up
