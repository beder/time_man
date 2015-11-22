require 'rails_helper'

feature 'Editing activities of other users', js: true do
  let(:admin) { create(:admin) }
  let(:manager) { create(:manager) }
  let(:user) { create(:user) }
  let!(:activity) { create(:activity, user: user) }
  let(:activity_attributes) { attributes_for(:activity) }

  scenario 'admin edits an activity' do
    visit '/'

    fill_in 'email', with: admin.email
    fill_in 'password', with: admin.password

    click_button 'Log in'

    click_link 'Users'

    click_on("#{user.first_name} #{user.last_name}")

    click_on 'Edit'

    fill_in 'edited_name', with: activity_attributes[:name]
    fill_in 'edited_date', with: activity_attributes[:date]
    fill_in 'edited_hours', with: activity_attributes[:hours]

    click_on 'Save'

    expect(page).not_to have_content(activity.name)
    expect(page).to have_content(activity_attributes[:name])
    expect(Activity.find_by_name(activity_attributes[:name])).not_to be_nil
  end

  scenario 'manager does not edit an activity' do
    visit '/'

    fill_in 'email', with: manager.email
    fill_in 'password', with: manager.password

    click_button 'Log in'

    click_link 'Users'

    expect(page).not_to have_link("#{user.first_name} #{user.last_name}")
  end

  scenario 'user does not edit an activity' do
    visit '/'

    fill_in 'email', with: user.email
    fill_in 'password', with: user.password

    click_button 'Log in'

    expect(page).not_to have_link('Users')
  end
end