class Users::CreateUser < ActiveInteraction::Base
  string :name, :surname, :patronymic, :email, :nationality, :country, :gender
  integer :age
  array :interests, default: []
  array :skills, default: []

  def execute
    user = User.new(
      name: name,
      surname: surname,
      patronymic: patronymic,
      email: email,
      nationality: nationality,
      country: country,
      gender: gender,
      age: age,
      user_full_name: "#{surname} #{name} #{patronymic}"
    )

    ActiveRecord::Base.transaction do
      user.save!
      attach_interests(user)
      attach_skills(user)
    end

    user
  rescue => e
    errors.add(:base, e.message)
  end

  private

  def attach_interests(user)
    interests.each do |interest_name|
      Interest.create!(name: interest_name, user: user)
    end
  end

  def attach_skills(user)
    skills.each do |skill_name|
      Skill.create!(name: skill_name, user: user)
    end
  end
end
