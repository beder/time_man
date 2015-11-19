require 'rails_helper'

feature 'Creating activities', js: true do
  let(:user) { create(:user) }
  let(:an_activity) { build(:activity) }

  scenario 'creating an activity' do
    visit '/'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_on 'Log in'

    fill_in 'name', with: an_activity.name
    fill_in 'date', with: an_activity.date
    fill_in 'hours', with: an_activity.hours
    click_on 'Add'

    expect(user.activities.find_by_name(an_activity.name)).not_to be_nil
    expect(page).to have_content(an_activity.name)
  end
end