require 'rails_helper'

describe 'internal pages have a different layout than marketing pages' do

  before :each do
    User.create(id: 1, first_name: 'joe', last_name: 'schmo', email: 'joe@schmo.com', password: 'password')
    Project.create(id: 1, name: 'example')
    Membership.create(id: 1, user_id: 1, project_id: 1, role: 1)

    visit '/'
    click_on 'Sign In'
    fill_in 'email', with: 'joe@schmo.com'
    fill_in 'password', with: 'password'
    click_button 'Sign In'
  end

  it 'Tasker on navbar links to projects for signed in users' do
    click_on 'Tasker'
    expect(current_path).to eq(projects_path)
  end

  it 'signed in user sees Project dropdown' do
    within('li.dropdown') {click_on 'example'}
    expect(page).to have_content 'Deleting this project'
  end

  it 'signed in user sees Users link in navbar' do
    click_link('users_link')
    expect(page).to have_content 'New user'
  end


end
