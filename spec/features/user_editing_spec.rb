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

    within :css, "#user_#{user.id}" do
      click_on('Edit')
    end

    fill_in 'edited_first_name', with: user_attributes[:first_name]
    fill_in 'edited_last_name', with: user_attributes[:last_name]
    fill_in 'edited_email', with: user_attributes[:email]
    fill_in 'edited_role', with: user_attributes[:role]

    click_on 'Save'

    expect(page).to have_content(user_attributes[:first_name])
    expect(page).to have_content(user_attributes[:last_name])
    expect(User.find_by_first_name(user.first_name)).to be_nil
    expect(User.find(user.id).first_name).to eq(user_attributes[:first_name])
    expect(User.find(user.id).role.to_sym).to eq(user_attributes[:role])
  end
end