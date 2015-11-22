require 'rails_helper'
require 'support/download_helpers'

feature 'Consulting reports', js: true do
  include DownloadHelpers

  let(:user) { create(:user) }
  let!(:early_activity) { create(:activity, name: 'Early activity', date: '2015-01-02', user: user) }
  let!(:first_activity) { create(:activity, name: 'First activity', date: '2015-03-04', user: user) }
  let!(:last_activity) { create(:activity, name: 'Last activity', date: '2015-05-06', user: user) }
  let!(:late_activity) { create(:activity, name: 'Late activity', date: '2015-07-08', user: user) }

  scenario 'reports activities' do
    visit '/'

    fill_in 'email', with: user.email
    fill_in 'password', with: user.password

    click_button 'Log in'

    fill_in 'date_from', with: first_activity.date
    fill_in 'date_to', with: last_activity.date

    click_on 'Search'

    click_on 'Download report'

    expect(downloaded_content).not_to have_content(early_activity.name)
    expect(downloaded_content).to have_content(first_activity.name)
    expect(downloaded_content).to have_content(last_activity.name)
    expect(downloaded_content).not_to have_content(late_activity.name)
  end
end