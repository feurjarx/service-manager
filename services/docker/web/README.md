# Web deployment as docker  

Первоначально, админу требуется перейти в каталог системы управления сервисами.
```
cd /services-manager
```
Затем получить права рута
```
su 
# pass is SSHD_ROOT_PASSWORD (.env)
```
Если разворачивание сервиса в режиме production, то необходимо в .env задать DEV_MODE=false
Важно правильно задать параметры окружения .env файла по образцу .env.example

Стоит обратить внимание, что данный сервис зависит от сервиса базы данных. 
Это означает, что данный контейнер должен запускаться после запуска контейнера бд.

###способ №1 (через docker-compose)
Выполнить 
```
./service.sh docker web up
```
Если DEV_MODE=false, то команда выше равносильна этому:
```
docker-compose -f ./docker-compose.prod.yml up
``` 

Иначе:
```
docker-compose -f ./docker-compose.dev.yml up
```

Обратная по смыслу операция:
```
./service.sh docker web down
```

###способ №2 (через docker)
```
./service.sh docker mysql run
./service.sh docker web deploy
```
Чтобы удалить контейнеры:
```
./service.sh docker mysql kill
./service.sh docker web kill
```
Или чтобы удалить контейнеры вместе с образом web:
```
./service.sh docker mysql kill
./service.sh docker web destroy
```
Обратите внимание! Образ mysql используется с репо docker
