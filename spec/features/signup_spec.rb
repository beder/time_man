require 'rails_helper'

feature 'Signing up', js: true do
  let(:user_attributes) { attributes_for(:user) }

  scenario 'creating a user' do
    visit '/'

    click_on 'Sign up'

    fill_in 'first_name', with: user_attributes[:first_name]
    fill_in 'last_name', with: user_attributes[:last_name]
    fill_in 'email', with: user_attributes[:email]
    fill_in 'password', with: user_attributes[:password]
    fill_in 'password_confirmation', with: user_attributes[:password_confirmation]

    click_button 'Sign up'

    expect(page).to have_content('Activities')
    expect(User.find_by_first_name(user_attributes[:first_name])).not_to be_nil
    expect(User.find_by_first_name(user_attributes[:first_name]).role.to_sym).to eq(:user)
  end
end