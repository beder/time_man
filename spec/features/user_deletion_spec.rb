require 'rails_helper'

feature 'User deletion', js: true do
  let!(:admin) { create(:admin) }
  let!(:manager) { create(:manager) }
  let!(:user) { create(:user) }
  let!(:activity) { create(:activity, user: user) }

  scenario 'admin deletes managers' do
    visit '/'

    fill_in 'email', with: admin.email
    fill_in 'password', with: admin.password

    click_button 'Log in'

    click_link 'Users'

    within :css, "#user_#{manager.id}" do
      click_on('Delete')
    end

    click_button 'OK'

    expect(page).not_to have_content(manager.first_name)
    expect(User.find_by_id(manager.id)).to be_nil
  end

  scenario 'admin does not delete herself' do
    visit '/'

    fill_in 'email', with: admin.email
    fill_in 'password', with: admin.password

    click_button 'Log in'

    click_link 'Users'

    within :css, "#user_#{admin.id}" do
      click_on('Delete')
    end

    click_button 'OK'

    expect(page).to have_content(admin.first_name)
    expect(User.find_by_id(admin.id)).not_to be_nil
  end

  scenario 'manager deletes users' do
    visit '/'

    fill_in 'email', with: manager.email
    fill_in 'password', with: manager.password

    click_button 'Log in'

    click_link 'Users'

    within :css, "#user_#{user.id}" do
      click_on('Delete')
    end

    click_button 'OK'

    expect(page).not_to have_content(user.first_name)
    expect(User.find_by_id(user.id)).to be_nil
  end

  scenario 'manager does not delete admins' do
    visit '/'

    fill_in 'email', with: manager.email
    fill_in 'password', with: manager.password

    click_button 'Log in'

    click_link 'Users'

    within :css, "#user_#{admin.id}" do
      click_on('Delete')
    end

    click_button 'OK'

    expect(page).to have_content(admin.first_name)
    expect(User.find_by_id(admin.id)).not_to be_nil
  end

  scenario 'manager does not delete herself' do
    visit '/'

    fill_in 'email', with: manager.email
    fill_in 'password', with: manager.password

    click_button 'Log in'

    click_link 'Users'

    within :css, "#user_#{manager.id}" do
      click_on('Delete')
    end

    click_button 'OK'

    expect(page).to have_content(manager.first_name)
    expect(User.find_by_id(manager.id)).not_to be_nil
  end

  scenario 'user does not delete users' do
    visit '/'

    fill_in 'email', with: user.email
    fill_in 'password', with: user.password

    click_button 'Log in'

    expect(page).not_to have_link('Users')
  end
end