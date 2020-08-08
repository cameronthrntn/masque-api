require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id }
  let!(:topics) { create_list(:topic, 6, user_id: users.first.id) }
  let(:topic_id) { topics.first.id }
  let!(:comments) { create_list(:comment, 15) }
  let(:comment_id) {comments.first.id }

  describe 'GET /topics/:id/comments' do
    before { get "topics/#{topic_id}/comments" }

    context 'gets comments for given topic' do
    end
  end


end
