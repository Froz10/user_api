FactoryBot.define do
  factory :user do
    name { "Ivan" }
    surname { "Ivanov" }
	  patronymic { "Ivanovich" }
    email { "ivan@example.com" }
	  nationality { "RU" }
    country { "Russia" }
	  gender { "male" }
    age { 37 }
  end
end
