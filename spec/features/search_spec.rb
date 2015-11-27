require 'rails_helper'

feature 'Searching for activities', js: true do
  let(:user) { create(:user) }
  let!(:prior) { create(:activity, name: 'Prior activity', date: '2015-01-02', user: user) }
  let!(:first) { create(:activity, name: 'First activity', date: '2015-03-04', user: user) }
  let!(:last) { create(:activity, name: 'Last activity', date: '2015-05-06', user: user) }
  let!(:posterior) { create(:activity, name: 'Posterior activity', date: '2015-07-08', user: user) }

  scenario 'finds the right activities' do
    visit '/'
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Log in'

    fill_in 'date_from', with: first.date
    fill_in 'date_to', with: last.date

    click_on 'Search'

    expect(page).not_to have_content(prior.name)
    expect(page).to have_content(first.name)
    expect(page).to have_content(last.name)
    expect(page).not_to have_content(posterior.name)
  end
end