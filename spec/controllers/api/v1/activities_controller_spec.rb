require 'rails_helper'

describe Api::V1::ActivitiesController do
  render_views

  describe 'index' do
    before do
      Activity.create!(name: 'User registration and authentication', date: '2015-01-02', hours: 1)
      Activity.create!(name: 'Activity management',                  date: '2015-03-04', hours: 2)
      Activity.create!(name: 'User settings',                        date: '2015-05-06', hours: 3)
      Activity.create!(name: 'Highlighting of under performance',    date: '2015-07-08', hours: 4)
      Activity.create!(name: 'Roles',                                date: '2015-09-10', hours: 5)

      xhr :get, :index, format: :json, date_from: date_from, date_to: date_to
    end

    subject(:results) { JSON.parse(response.body) }

    def extract_name
      ->(object) { object['name'] }
    end

    context 'when the search finds results' do
      let(:date_from) { '2015-01-02' }
      let(:date_to) { '2015-03-04' }
      it 'should 200' do
        expect(response.status).to eq(200)
      end
      it 'should return two results' do
        expect(results.size).to eq(2)
      end
      it "should include 'User registration and authentication'" do
        expect(results.map(&extract_name)).to include('User registration and authentication')
      end
      it "should include 'Activity management'" do
        expect(results.map(&extract_name)).to include('Activity management')
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