require 'rails_helper'

RSpec.describe Api::V1::TopicsController, type: :controller do
  let(:my_user) { create(:user) }
  let(:my_topic) { create(:topic) }

  context "unauthenticated user" do
    it "GET index returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "GET show returns http success" do
      get :show, id: my_topic.id
      expect(response).to have_http_status(:success)
    end

    it "GET show returns child posts" do
        get :show, id: my_topic.id
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['posts']).to_not be_nil
    end
  end

  context "unauthorized user" do
    before do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
    end

    it "GET index returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "GET show returns http success" do
      get :show, id: my_topic.id
      expect(response).to have_http_status(:success)
    end

    it "GET show returns child posts" do
        get :show, id: my_topic.id
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['posts']).to_not be_nil
    end
  end
end