require 'rails_helper'

feature 'Changing user settings', js: true do
  let(:user) { create(:user, hours_per_day: 12) }

  scenario 'modifying user settings' do
    visit '/'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Log in'

    click_on "#{user.first_name} #{user.last_name}"

    click_on 'Settings'

    fill_in 'hours_per_day', with: 8
    click_on 'Save'

    expect(page).to have_content('Activities')
    expect(User.find(user.id).hours_per_day).to eq(8)
  end
end