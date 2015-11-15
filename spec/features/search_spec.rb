require 'rails_helper'

feature 'Searching for activities', js: true do
  before do
    Activity.create!(name: 'User registration and authentication', date: '2015-01-02', hours: 1)
    Activity.create!(name: 'Activity management',                  date: '2015-03-04', hours: 2)
    Activity.create!(name: 'User settings',                        date: '2015-05-06', hours: 3)
    Activity.create!(name: 'Highlighting of under performance',    date: '2015-07-08', hours: 4)
    Activity.create!(name: 'Roles',                                date: '2015-09-10', hours: 5)
  end
  scenario 'finding activities' do
    visit '/'
    fill_in 'date_from', with: '2015-03-04'
    fill_in 'date_to', with: '2015-05-06'
    click_on 'Search'

    expect(page).to have_content('Activity management')
    expect(page).to have_content('User settings')
  end
end