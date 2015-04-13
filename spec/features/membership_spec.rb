require 'rails_helper'

describe 'project memberships' do

  before :each do

    User.create(id: 1, first_name: 'joe', last_name: 'camel', email: 'joe@camel.com', password: 'password')

    visit '/signin'
      fill_in 'email', with: 'joe@camel.com'
      fill_in 'password', with: 'password'
      click_button 'Sign In'


      click_on 'New project'
      fill_in 'project[name]', with: 'example'
      click_on 'Create Project'
  end

  it 'project creator is made owner' do
      click_link('proj')
      click_on '1 Members'
      expect(page).to have_content 'You are the last owner'
  end

end
