require 'rails_helper'

describe 'user can sign out' do

  before :each do
    Registration.create(first_name: 'joe', last_name: 'camel', email: 'joe@camel.com', password: 'password')

    visit '/signin'

    fill_in 'email', with: 'joe@camel.com'
    fill_in 'password', with: 'password'
    click_button 'Sign In'
  end


  it 'user can sign out' do
    visit '/'
    click_on 'Sign Out'

    expect(page).to have_content 'Fare thee well.'
  end


end
