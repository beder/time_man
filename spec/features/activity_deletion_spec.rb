require 'rails_helper'

feature 'Deleting activities', js: true do
  let(:user) { create(:user) }
  let!(:an_activity) { create(:activity, user: user) }

  scenario 'deleting an activity' do
    visit '/'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_on 'Log in'

    click_on 'Delete'

    click_on 'OK'

    expect(user.activities.find_by_name(an_activity.name)).to be_nil
    expect(page).not_to have_content(an_activity.name)
  end
end