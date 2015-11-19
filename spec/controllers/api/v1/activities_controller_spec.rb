require 'rails_helper'
require 'support/api_request_helpers'

describe Api::V1::ActivitiesController do
  render_views

  include ApiRequestHelpers

  let!(:accept) { set_accept }
  let(:user) { create(:user) }
  let!(:authorize) { set_authorization(user) }

  describe 'create' do
    let(:activity_attributes) { attributes_for(:activity, name: 'New activity') }
    before do
      xhr :post, :create, format: :json, activity: activity_attributes
    end

    describe 'response' do
      subject { response }

      it { is_expected.to have_http_status(:created) }

      it { is_expected.to render_template(:create) }
    end

    describe 'result name' do
      subject(:result_name) { JSON.parse(response.body)['name'] }

      it { is_expected.to eq(activity_attributes[:name]) }
    end
  end

  describe 'index' do
    let!(:activities) { create_list(:activity, 5, user: user) }
    let(:an_activity) { create(:activity, name: 'An activity', date: '2015-01-02', user: user) }
    let(:another_activity) { create(:activity, name: 'Another activity', date: '2015-03-04', user: user) }
    before do
      xhr :get, :index, format: :json, date_from: date_from, date_to: date_to
    end

    subject(:results) { JSON.parse(response.body) }

    def extract_name
      ->(object) { object['name'] }
    end

    context 'when the search finds results' do
      let(:date_from) { an_activity.date }
      let(:date_to) { another_activity.date }

      describe 'response' do
        subject { response }

        it { is_expected.to have_http_status(:ok) }
      end

      describe 'result count' do
        subject(:result_count) { JSON.parse(response.body).size }

        it { is_expected.to eq(2) }
      end

      describe 'result names' do
        subject(:result_names) { JSON.parse(response.body).map(&extract_name) }

        it { is_expected.to include(an_activity.name) }
        it { is_expected.to include(another_activity.name) }
      end
    end

    context "when the search doesn't find results" do
      let(:date_from) { '2014-01-02' }
      let(:date_to) { '2014-03-04' }

      describe 'result count' do
        subject(:result_count) { JSON.parse(response.body).size }

        it { is_expected.to eq(0) }
      end
    end
  end

  describe 'update' do
    let(:activity) { create(:activity, name: 'Previous name', user: user) }
    let(:edited_activity) { build(:activity, name: 'New name') }
    before do
      xhr :put, :update, format: :json, id: activity.id, activity: attributes_for(:activity, name: edited_activity.name)
    end

    describe 'response' do
      subject { response }

      it { is_expected.to have_http_status(:ok) }

      it { is_expected.to render_template(:update) }
    end

    describe 'result name' do
      subject(:result_name) { JSON.parse(response.body)['name'] }

      it { is_expected.to eq(edited_activity.name) }
    end
  end

  describe 'destroy' do
    let(:activity) { create(:activity, user: user) }
    before do
      xhr :delete, :destroy, format: :json, id: activity.id
    end

    describe 'response' do
      subject { response }

      it { is_expected.to have_http_status(:ok) }
    end

    it 'deletes the activity' do
      expect(Activity.find_by_id(activity.id)).to be_nil
    end
  end
end