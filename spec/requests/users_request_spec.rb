require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id }
  let(:user_access) { users.first.access }
  
  describe 'GET /users' do
    before { get '/users' }

    it 'returns 404' do 
      expect(response).to have_http_status(404)
    end
  end

  describe 'GET /users?access' do
    before { get "/users", params: { access: user_access }}

    context 'when the user exists' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the user does not exist' do
      let(:user_access) { 'something1234123456799' }

      it 'returns 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns not found message' do
        expect(json['message']).to match(/Couldn't find User/)
      end
    end
  end

  describe 'POST /users' do
    let(:valid_attributes) { 
      { 
        word: 'masque',
        number: '1234',
        pin: '123456789',
      } 
    }

    context 'when given a valid user' do
      before { post '/users', params: valid_attributes }

      it 'creates a user' do
        expect(json['access']).to eq('masque1234123456789')
      end

      it 'returns 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when given invalid user' do
      before { post '/users', params: { 
        word: 'masque',
        number: '12345',
        pin: '123456799',
      } }

      it 'returns 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message']).to match(/Invalid user/)
      end
    end
  end

  describe 'DELETE /users/:id' do
    before { delete "/users/#{user_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
