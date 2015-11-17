require 'rails_helper'
require 'support/api_request_helpers'

describe Api::V1::ActivitiesController do
  render_views

  include ApiRequestHelpers

  let!(:accept) { set_accept }
  let(:user) { create(:user) }
  let!(:authorize) { set_authorization(user) }

  describe 'index' do
    let!(:activities) { create_list(:activity, 5) }
    let(:an_activity) { create(:activity, date: '2015-01-02') }
    let(:another_activity) { create(:activity, date: '2015-03-04') }
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
      it 'should 200' do
        expect(response.status).to eq(200)
      end
      it 'should return two results' do
        expect(results.size).to eq(2)
      end
      it 'should include an activity' do
        expect(results.map(&extract_name)).to include(an_activity.name)
      end
      it 'should include another activity' do
        expect(results.map(&extract_name)).to include(another_activity.name)
      end
    end

    context "when the search doesn't find results" do
      let(:date_from) { '2014-01-02' }
      let(:date_to) { '2014-03-04' }
      it 'should return no results' do
        expect(results.size).to eq(0)
      end
    end

  end
end