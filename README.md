# Сервис аутентификации

## Версии

- Ruby: 3.2.4  
- Rails: 8.0.2  

## Установка

Клонируйте репозиторий:

```bash
git clone <url>
cd <название_папки>
```

Установите зависимости:

```bash
bundle install
```

Создайте и мигрируйте базу данных:
```bash
rails db:create
rails db:migrate
```
Запустите сервер:
```bash
bin/rails s
```

Примеры запросов с curl
```bash
curl -X POST http://localhost:3000/api/v1/auth/token \
  -H "Content-Type: application/json" \
  -d '{
    "user_id": "user-123"
}'
```
Привет ответа
```bash
{
	"access": "eyJhbGciOiJIUzUxMiJ9.eyJ1c2VyX2lkIjoidXNlci0xMjMiLCJpcCI6IjEyNy4wLjAuMSIsInRva2VuX3BhaXJfaWQiOiI3MjA5ZTY5Ni0xMGFjLTRmZWYtOTRhMS01NWVhMDNhZGE3OTQiLCJleHAiOjE3NDQ3OTAwOTZ9.zOE0vGB4eAayzA0C3cqXpjsAF39Imnw3waHy0zlL2QIQZJ744jb-UFtfim8kRNPtU9A4yoRPlem3-MNK5w-ZGQ",
	"refresh": "PlJ7LSe6eXG0P5Hj8bHi1cSQhW0C65c_FFfITIVWs7NEoKBNmH8tFvmLwvOlpO5w19SA9ZPrH_upZmFJbpadPg"
}
```
Обновление токенов (Refresh)
```bash
curl -X POST http://localhost:3000/api/v1/auth/refresh \
  -H "Content-Type: application/json" \
  -d '{
    "access": "eyJhbGciOiJIUzUxMiJ9.eyJ1c2VyX2lkIjoidXNlci0xMjMiLCJpcCI6IjEyNy4wLjAuMSIsInRva2VuX3BhaXJfaWQiOiI3MjA5ZTY5Ni0xMGFjLTRmZWYtOTRhMS01NWVhMDNhZGE3OTQiLCJleHAiOjE3NDQ3OTAwOTZ9.zOE0vGB4eAayzA0C3cqXpjsAF39Imnw3waHy0zlL2QIQZJ744jb-UFtfim8kRNPtU9A4yoRPlem3-MNK5w-ZGQ", 
    "refresh": "PlJ7LSe6eXG0P5Hj8bHi1cSQhW0C65c_FFfITIVWs7NEoKBNmH8tFvmLwvOlpO5w19SA9ZPrH_upZmFJbpadPg"
}'
```
Пример ответа:
```bash
{
	"access": "eyJhbGciOiJIUzUxMiJ9.eyJ1c2VyX2lkIjoidXNlci0xMjMiLCJpcCI6IjEyNy4wLjAuMSIsInRva2VuX3BhaXJfaWQiOiI1ODYzZTg3Zi0zNjg4LTRmZjItOWJmOC1lMDc0YjI4NzM1OTciLCJleHAiOjE3NDQ3OTAyNzF9.Ww6uTIuO8VKVSQ6heMOrs6lv-sa4HR8pt1jHCYFZAV8Uev86C2t6ESaRK8ojLOmiJMiRB0vwzRbDUqnnEMHgpg",
	"refresh": "5Jyu4yoQnS0t-gsmKGnlIWKwmicXWL1W32ITySLzy633lGO4TULIcqGSx99IxxIJUXtJXXrTdGtH4LggnL9M4A"
}
```

# Пример запросов с Insomnia
Скачайте коллекцию Insomnia:

[Скачать коллекцию Insomnia](./Insomnia_collection.json)

# Запуск тестов

```bash
bundle exec rspec
```
