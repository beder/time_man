require 'rails_helper'

feature 'Checking fulfillment', js: true do
  let(:user) { create(:user, hours_per_day: 8) }
  let!(:first_activity) { create(:activity, date: '2015-01-01', hours: 1, user: user) }
  let!(:second_activity) { create(:activity, date: '2015-01-01', hours: 7, user: user) }
  let!(:third_activity) { create(:activity, date: '2015-02-02', hours: 1, user: user) }
  let!(:fourth_activity) { create(:activity, date: '2015-02-02', hours: 1, user: user) }

  scenario 'shows fulfillment' do
    visit '/'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Log in'

    expect(page).to have_css('.panel-success h3', text: first_activity.name)
    expect(page).to have_css('.panel-success h3', text: second_activity.name)
    expect(page).to have_css('.panel-danger h3', text: third_activity.name)
    expect(page).to have_css('.panel-danger h3', text: fourth_activity.name)
  end
end