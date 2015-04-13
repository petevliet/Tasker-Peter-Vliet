require 'rails_helper'

describe 'user can CRUD projects' do

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

  it 'user can create a project' do

    visit '/projects'

    click_on 'New project'
    click_on 'Create Project'
    expect(page).to have_content 'prohibited'

      fill_in 'project[name]', with: 'example1'
      click_button 'Create Project'

    expect(page).to have_content 'example1'

  end

  it 'takes user to project tasks page upon project creation' do

    expect(page).to have_content 'Tasks for example'
  end

  scenario 'user can view project show page' do

    visit '/projects'

    within('table') {click_on 'example'}

    expect(page).to have_content('example')

  end

  scenario 'user can update project information' do

    visit '/projects'

    within('table') {click_on 'example'}
    click_on 'Edit'
      fill_in 'project[name]', with: 'example_new'
    click_on 'Update Project'

      expect(page).to have_content('example_new')

  end

  scenario 'user can delete projects' do

    visit '/projects'

    within('table') {click_on 'example'}
    click_on 'Delete'

    expect(page).to have_content('Project was successfully destroyed.')

  end

end
