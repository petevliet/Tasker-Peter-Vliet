require 'rails_helper'

describe 'user can sign in successfully' do

  before :each do
    Registration.create(first_name: 'joe', last_name: 'camel', email: 'joe@camel.com', password: 'password')
  end

  it 'user cannot sign in with unregistered credentials' do
    visit '/signin'

    fill_in 'email', with: 'fake@notreal.com'
    fill_in 'password', with: 'password'
    click_button 'Sign In'

    expect(page).to have_content('Username / password combination is invalid.')
  end

  it 'user cannot sign in with incorrect email/password combination' do
    visit '/signin'

    fill_in 'email', with: 'joe@camel.com'
    fill_in 'password', with: 'notpassword'
    click_button 'Sign In'

    expect(page).to have_content('Username / password combination is invalid.')
  end

  it 'user can sign in with correct email/password combination' do
    visit '/signin'

    fill_in 'email', with: 'joe@camel.com'
    fill_in 'password', with: 'password'
    click_button 'Sign In'

    expect(page).to have_content('Welcome!')
  end

end