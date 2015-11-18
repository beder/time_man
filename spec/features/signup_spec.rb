require 'rails_helper'

feature 'Signing up', js: true do
  let(:user) { build(:user) }

  scenario 'creating a user' do
    visit '/'

    click_on 'Sign up'

    fill_in 'first_name', with: user.first_name
    fill_in 'last_name', with: user.last_name
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    fill_in 'password_confirmation', with: user.password_confirmation

    click_on 'Sign up'

    expect(page).to have_content('Find Activities')
    expect(User.find_by_first_name(user.first_name)).not_to be_nil
  end
end