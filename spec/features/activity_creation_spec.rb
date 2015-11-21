require 'rails_helper'

feature 'Creating activities', js: true do
  let(:user) { create(:user) }
  let(:activity_attributes) { attributes_for(:activity) }

  scenario 'creating an activity' do
    visit '/'

    fill_in 'email', with: user.email
    fill_in 'password', with: user.password

    click_button 'Log in'

    fill_in 'name', with: activity_attributes[:name]
    fill_in 'date', with: activity_attributes[:date]
    fill_in 'hours', with: activity_attributes[:hours]

    click_on 'Add'

    expect(page).to have_content(activity_attributes[:name])
    expect(Activity.find_by_name(activity_attributes[:name])).not_to be_nil
  end
end