require 'rails_helper'

describe 'logged out users cannot see marketing pages' do

  before :each do
    Project.create(id: 1, name: 'testing')
  end

  it 'Tasker link on navbar links to root path' do
    visit '/'
    click_on 'Tasker'
    expect(current_path).to eq(root_path)
  end

  it 'signed out users cannot see projects' do
    visit '/projects'
    expect(page).to have_content 'You must be logged in'
  end

  it 'signed out users cannot see tasks' do
    visit '/projects/1'

    expect(page).to have_content 'You must be logged in'
  end

  it 'signed out users cannot see memberships' do
    visit '/projects/1'

    expect(page).to have_content 'You must be logged in'
  end

  it 'signed out users cannot see users' do

    visit '/users'
    expect(page).to have_content 'You must be logged in'
  end

end
