require 'rails_helper'

feature 'Logging out', js: true do
  let(:user) { create(:user) }

  scenario 'logging out' do
    visit '/'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Log in'

    click_on "#{user.first_name} #{user.last_name}"

    click_on 'Log out'

    expect(page).to have_content('Please log in')
  end
end