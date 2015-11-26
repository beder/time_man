require 'rails_helper'

feature 'Editing users', js: true do
  let!(:admin) { create(:admin) }
  let!(:manager) { create(:manager) }
  let!(:user) { create(:user) }
  let(:user_attributes) { attributes_for(:user) }

  scenario 'admin edits users' do
    visit '/'

    fill_in 'email', with: admin.email
    fill_in 'password', with: admin.password

    click_button 'Log in'

    click_link 'Users'

    within :css, "#user_#{manager.id}" do
      click_on('Edit')
    end

    fill_in 'edited_first_name', with: user_attributes[:first_name]
    fill_in 'edited_last_name', with: user_attributes[:last_name]
    fill_in 'edited_email', with: user_attributes[:email]
    select user_attributes[:role], from: 'edited_role'

    click_on 'Save'

    expect(page).to have_content(user_attributes[:first_name])
    expect(page).to have_content(user_attributes[:last_name])
    expect(User.find_by_first_name(manager.first_name)).to be_nil
    expect(User.find(manager.id).first_name).to eq(user_attributes[:first_name])
    expect(User.find(manager.id).role.to_sym).to eq(user_attributes[:role])
  end

  scenario 'manager edits users' do
    visit '/'

    fill_in 'email', with: manager.email
    fill_in 'password', with: manager.password

    click_button 'Log in'

    click_link 'Users'

    within :css, "#user_#{user.id}" do
      click_on('Edit')
    end

    fill_in 'edited_first_name', with: user_attributes[:first_name]
    fill_in 'edited_last_name', with: user_attributes[:last_name]
    fill_in 'edited_email', with: user_attributes[:email]

    click_on 'Save'

    expect(page).to have_content(user_attributes[:first_name])
    expect(page).to have_content(user_attributes[:last_name])
    expect(User.find_by_first_name(user.first_name)).to be_nil
    expect(User.find(user.id).first_name).to eq(user_attributes[:first_name])
  end

  scenario 'manager does not edit user roles' do
    visit '/'

    fill_in 'email', with: manager.email
    fill_in 'password', with: manager.password

    click_button 'Log in'

    click_link 'Users'

    within :css, "#user_#{user.id}" do
      click_on('Edit')
    end

    select 'admin', from: 'edited_role'

    click_on 'Save'

    expect(User.find(user.id).role.to_sym).to eq(user.role.to_sym)
  end

  scenario 'user does not edit users' do
    visit '/'

    fill_in 'email', with: user.email
    fill_in 'password', with: user.password

    click_button 'Log in'

    expect(page).not_to have_link('Users')
  end
end