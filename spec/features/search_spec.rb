require 'rails_helper'

feature 'Searching for activities', js: true do
  let(:user) { create(:user) }
  let!(:activities) { create_list(:activity, 5) }
  let(:an_activity) { create(:activity, name: 'March activity', date: '2015-03-04') }
  let(:another_activity) { create(:activity, name: 'May activity', date: '2015-05-06') }

  scenario 'finding activities' do
    visit '/'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_on 'Log in'

    fill_in 'date_from', with: an_activity.date
    fill_in 'date_to', with: another_activity.date
    click_on 'Search'

    expect(page).to have_content(an_activity.name)
    expect(page).to have_content(another_activity.name)
  end
end