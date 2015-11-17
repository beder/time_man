require 'rails_helper'

feature 'Signing up', js: true do
  scenario 'creating a user' do
    visit '/'

    click_on 'Sign up'

    fill_in 'first_name', with: 'John'
    fill_in 'last_name', with: 'Doe'
    fill_in 'email', with: 'john.doe@example.com'
    fill_in 'password', with: 'J0hn_D03'
    fill_in 'password_confirmation', with: 'J0hn_D03'

    click_on 'Sign up'

    expect(User.find_by_first_name('John')).should_not be_nil
  end
end