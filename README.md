# Приложение для организации встреч - BBQ kabab.fun

Приложение для организации публичных и приватных(пинкод) встреч,


Можно добавлять фото к событию, получать оповещения на почту, комментировать встречу,
есть возможность подписаться на встречу, как анонимно так и будучу авторизованным юзером.
Карта яндекса удобно выводит место будущей встречи.

### Демо версия

Демо версия доступна по адресу
* [bbqking.space](https://bbqking.space)

## Установка
Запускаем команду
```
$ bundle install --without production
```

Надо прописать в config/credentials.yml.enc данные полученные с `developers.facebook.com` и `vk.com/dev`

Для этого набираем команду в терминале:

```
$ EDITOR=nano rails credentials:edit
```


config/credentials.yml.enc
```
development:
  omniauth_facebook_id: <your apps id from facebook>
  omniauth_facebook_secret: <your apps secret key from facebook>

production:
  omniauth_facebook_id: <your apps id from facebook>
  omniauth_facebook_secret: <your secret key from facebook>
  omniauth_vk_id: <your id from vk>
  omniauth_vk_secret: <your secret key from vk>

```

Необходимо также создать файл config/database.yml
```
default: &default
  adapter: sqlite3
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000

development:
  <<: *default
  database: db/development.sqlite3

test:
  <<: *default
  database: db/test.sqlite3

production:
  <<: *default
  adapter: postgresql
  host: localhost
  port: 5432
  database: <database>
  user: <user>
  password: <your password>
```

Далее запускаем миграции
```
$ rails db:migrate
```

## Запуск
Выполните ```rails s```

## Настройка
Для правильной работы почтовых оповещений в `production` среде нужно задать
в ```config/environments/production.rb``` данные хоста и почтового ящика:
```
  config.action_mailer.default_url_options = { host: 'example.org', protocol: 'https' }

  config.action_mailer.default_options = { from: 'your_email@example.org' }
```
в среде `production` используется Postfix (см. [настройку здесь](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-postfix-on-ubuntu-18-04))



Для загрузки изображений необходимо прописать переменные окружения AMAZON S3 в ```carrierwave.rb```

```
    aws_access_key_id:     ENV['S3_ACCESS_KEY']
    aws_secret_access_key: ENV['S3_SECRET_KEY']
    config.fog_directory = ENV['S3_BUCKET_NAME']
```

На сервере, в корне приложения необходимо создать файл `.env` и прописать туда все переменные окружения, необходимые для работы приложения.

```
S3_ACCESS_KEY=YOUR_KEY
S3_BUCKET_NAME=backetname
S3_SECRET_KEY=YOUR_SECRET_KEY
```

## Деплой
Используйте `capistrano` [см. документацию](https://capistranorb.com/documentation/getting-started/configuration/)
```
cap production deploy
```

## Автор

* **LEM** - *Учебный проект* - [Lemeri](https://github.com/Lemeri02)
