# spec/requests/users/create_spec.rb

require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:valid_params) do
    {
      user: {
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
    }
  end

  let(:invalid_params) do
    {
      user: {
        email: 'invalid_email',
        age: 150,
        gender: 'unknown'
      }
    }
  end

  describe 'POST api/users' do
    context 'with valid parameters' do
      it 'creates a new user' do
        post '/api/users', params: valid_params, as: :json

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['email']).to eq('ivan@example.com')
      end
    end

    context 'with invalid parameters' do
      it 'returns validation errors' do
        post '/api/users', params: invalid_params, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with duplicate email' do
      before { create(:user) }

      it 'returns an error' do
        post '/api/users', params: valid_params, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)["base"][0]["error"]).to include("Validation failed: Email has already been taken")
      end
    end
  end
end
