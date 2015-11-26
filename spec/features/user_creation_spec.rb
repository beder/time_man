require 'rails_helper'

feature 'User creation', js: true do
  let(:admin) { create(:admin) }
  let(:manager) { create(:manager) }
  let(:user) { create(:user) }
  let(:user_attributes) { attributes_for(:user) }

  scenario 'admin creates users' do
    visit '/'

    fill_in 'email', with: admin.email
    fill_in 'password', with: admin.password

    click_button 'Log in'

    click_link 'Users'

    fill_in 'first_name', with: user_attributes[:first_name]
    fill_in 'last_name', with: user_attributes[:last_name]
    fill_in 'email', with: user_attributes[:email]
    select user_attributes[:role], from: 'role'
    fill_in 'password', with: user_attributes[:password]
    fill_in 'password_confirmation', with: user_attributes[:password_confirmation]

    click_button 'Add'

    expect(page).to have_content(user_attributes[:first_name])
    expect(page).to have_content(user_attributes[:last_name])
    expect(User.find_by_first_name(user_attributes[:first_name])).not_to be_nil
    expect(User.find_by_first_name(user_attributes[:first_name]).role.to_sym).to eq(:user)
  end

  scenario 'manager creates users' do
    visit '/'

    fill_in 'email', with: manager.email
    fill_in 'password', with: manager.password

    click_button 'Log in'

    click_link 'Users'

    fill_in 'first_name', with: user_attributes[:first_name]
    fill_in 'last_name', with: user_attributes[:last_name]
    fill_in 'email', with: user_attributes[:email]
    select user_attributes[:role], from: 'role'
    fill_in 'password', with: user_attributes[:password]
    fill_in 'password_confirmation', with: user_attributes[:password_confirmation]

    click_button 'Add'

    expect(page).to have_content(user_attributes[:first_name])
    expect(page).to have_content(user_attributes[:last_name])
    expect(User.find_by_first_name(user_attributes[:first_name])).not_to be_nil
    expect(User.find_by_first_name(user_attributes[:first_name]).role.to_sym).to eq(:user)
  end

  scenario 'user does not create users' do
    visit '/'

    fill_in 'email', with: user.email
    fill_in 'password', with: user.password

    click_button 'Log in'

    expect(page).not_to have_link('Users')
  end
end