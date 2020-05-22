# Приложение для организации встреч - BBQ kabab.fun

Приложение для организации публичных и приватных(пинкод) встреч,


Можно добавлять фото к событию, получать оповещения на почту, комментировать встречу,
есть возможность подписаться на встречу, как анонимно так и будучу авторизованным юзером.
Карта яндекса удобно выводит место будущей встречи.

### Демо версия

Демо версия доступна по адресу
* [kabab.fun](https://kabab.fun)

## Установка
```
bundle install
rails db:migrate
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
## Деплой
Используйте `capistrano` [см. документацию](https://capistranorb.com/documentation/getting-started/configuration/)
```
cap production deploy
```

## Автор

* **LEM** - *Учебный проект* - [Lemeri](https://github.com/Lemeri02)
