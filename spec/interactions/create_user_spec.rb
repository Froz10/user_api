# spec/interactions/users/create_spec.rb

require 'rails_helper'

RSpec.describe Users::CreateUser, type: :interaction do
  let(:valid_params) do
    {
      name: 'Ivan',
      surname: 'Ivanov',
      patronymic: 'Ivanovich',
      email: 'ivan@example.com',
      nationality: 'Russian',
      country: 'Russia',
      gender: 'male',
      age: 30,
      interests: ['Music', 'Sports'],
      skills: ['Ruby', 'Rails']
    }
  end

  let(:invalid_params) do
    {
      name: '',
      email: 'invalid_email',
      age: 150,
      gender: 'unknown'
    }
  end

  describe '#execute' do
    context 'with valid params' do
      it 'creates a new user with correct attributes' do
        result = described_class.run(valid_params)

        expect(result).to be_valid
        expect(result.result).to be_persisted
        expect(result.result.user_full_name).to eq('Ivanov Ivan Ivanovich')
        expect(result.result.interests.count).to eq(2)
        expect(result.result.skills.count).to eq(2)
      end
    end

    context 'with invalid params' do
      it 'returns errors for invalid input' do
        result = described_class.run(invalid_params)

        expect(result).to_not be_valid
      end
    end

    context 'with duplicate email' do
      it 'returns an error when email is already taken' do
        described_class.run(valid_params)
        result = described_class.run(valid_params)

        expect(result).to_not be_valid
        expect(result.errors.details[:base][0][:error]).to include("Validation failed: Email has already been taken")
      end
    end
  end
end
