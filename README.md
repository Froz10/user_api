# user-api

HTTP API:

POST /api/users: returns the JSON with user data

```
## Project setup
```
bundle install
```
### Migrate database
```
rails db:migrate
```
### Run server
```
rails s
```
### Testing
```
curl -i -X 'POST' \
  'http://localhost:3000/api/users' \
  -H 'Content-Type: application/json' \
  -d '{
  "user": {
    "name": "Ivan",
    "surname": "Ivanov",
	  "patronymic": "Ivanovich",
    "email": "test@test.ru",
	  "nationality": "RU",
    "country": "Russia",
	  "gender": "male",
    "age": "37",
	  "interests": ["Ruby"],
	  "skills": ["Programming"]
  }
}'

```
