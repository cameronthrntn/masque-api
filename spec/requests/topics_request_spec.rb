require 'rails_helper'

RSpec.describe "Topics", type: :request do
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id }
  let!(:topics) { create_list(:topic, 43, user_id: users.first.id) }
  let(:topic_id) { topics.first.id }

  describe 'GET /topics' do
    before { get '/topics' }

    it 'returns a list of active topics' do
      expect(json).not_to be_empty
      expect(json.size).to eq(43)
    end
  end

  describe 'POST /topics' do
    let(:valid_attributes) {
      {
        title: 'This is a new topic',
        content: 'This is the content of the topic. It can have plenty of words but is still limited to a certain character limit. It will of course contain relevant, informative, and engaging information which will enrich the lives of those who read it and society as a whole. Of course.',
        user_id: user_id
      }
    }

    context 'when given a valid new thread' do
      before { post '/topics', params: valid_attributes }
      
      it 'returns 201' do
        expect(response).to have_http_status(201)
      end

      it 'creates a topic' do
        expect(json['title']).to eq('This is a new topic')
      end
    end
  end

end
