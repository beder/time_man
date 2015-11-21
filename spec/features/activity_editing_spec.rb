require 'rails_helper'

feature 'Editing activities', js: true do
  let(:user) { create(:user) }
  let!(:an_activity) { create(:activity, user: user) }
  let(:another_activity) { build(:activity) }

  scenario 'editing an activity' do
    visit '/'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Log in'

    click_on 'Edit'

    fill_in 'edited_name', with: another_activity.name
    fill_in 'edited_date', with: another_activity.date
    fill_in 'edited_hours', with: another_activity.hours
    click_on 'Save'

    expect(user.activities.find_by_name(another_activity.name)).not_to be_nil
    expect(page).not_to have_content(an_activity.name)
    expect(page).to have_content(another_activity.name)
  end
end