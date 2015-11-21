require 'rails_helper'

feature 'Deleting activities', js: true do
  let(:user) { create(:user) }
  let!(:activity) { create(:activity, user: user) }

  scenario 'deleting an activity' do
    visit '/'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Log in'

    click_on 'Delete'

    click_on 'OK'

    expect(page).not_to have_content(activity.name)
  end
end