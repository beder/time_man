require 'rails_helper'

feature 'Creating activities for other users', js: true do
  let(:admin) { create(:admin) }
  let(:manager) { create(:manager) }
  let!(:user) { create(:user) }
  let(:activity_attributes) { attributes_for(:activity) }

  scenario 'admin creates an activity' do
    visit '/'

    fill_in 'email', with: admin.email
    fill_in 'password', with: admin.password

    click_button 'Log in'

    click_link 'Users'

    click_on("#{user.first_name} #{user.last_name}")

    fill_in 'name', with: activity_attributes[:name]
    fill_in 'date', with: activity_attributes[:date]
    fill_in 'hours', with: activity_attributes[:hours]

    click_on 'Add'

    expect(page).to have_content(activity_attributes[:name])
    expect(Activity.find_by_name(activity_attributes[:name]).user_id).to eq(user.id)
  end

  scenario 'manager does not create an activity' do
    visit '/'

    fill_in 'email', with: manager.email
    fill_in 'password', with: manager.password

    click_button 'Log in'

    click_link 'Users'

    expect(page).not_to have_link("#{user.first_name} #{user.last_name}")
  end

  scenario 'user does not create an activity' do
    visit '/'

    fill_in 'email', with: user.email
    fill_in 'password', with: user.password

    click_button 'Log in'

    expect(page).not_to have_link('Users')
  end
end