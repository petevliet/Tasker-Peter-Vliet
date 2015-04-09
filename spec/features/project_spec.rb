require 'rails_helper'

describe 'user can CRUD projects' do

  before :each do

    visit '/signup'
      fill_in 'user[first_name]', with: 'joe'
      fill_in 'user[last_name]', with: 'camel'
      fill_in 'user[email]', with: 'joe@camel.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button 'Sign Up'

    visit '/projects'
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
