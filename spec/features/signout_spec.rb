require 'rails_helper'

describe 'user can sign out' do

  before :each do
    User.create(first_name: 'joe', last_name: 'camel', email: 'joe@camel.com', password: 'password')
  end

  it 'user can sign out' do

    visit '/signin'

    fill_in 'email', with: 'joe@camel.com'
    fill_in 'password', with: 'password'
    click_button 'Sign In'

    visit '/'
    click_on 'Sign Out'

    expect(page).to have_content 'Fare thee well.'
  end


end
