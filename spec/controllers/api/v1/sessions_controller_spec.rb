require 'rails_helper'
require 'support/api_request_helpers'

describe Api::V1::SessionsController do
  render_views

  include ApiRequestHelpers

  let!(:accept) { set_accept }
  let(:user) { create(:user) }

  describe 'create' do
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      xhr :post, :create, format: :json, user: { email: user.email, password: user.password }
    end

    describe 'response' do
      subject { response }

      it { is_expected.to have_http_status(:created) }

      it { is_expected.to render_template(:create) }
    end

    describe 'response token' do
      subject(:response_token) { JSON.parse(response.body)['token'] }

      it { is_expected.to be_present }
    end

    describe 'response user role' do
      subject(:response_user_role) { JSON.parse(response.body)['user']['role'] }

      it { is_expected.to eq(user.role) }
    end
  end
end