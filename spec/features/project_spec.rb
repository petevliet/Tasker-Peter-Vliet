require 'rails_helper'

describe 'user can CRUD projects' do

  before :each do

    # admin
    User.create(id: 4, first_name: 'boss', last_name: 'hog', email: 'boss@hog.com', password: 'password', admin: true)
    # owner
    User.create(id: 1, first_name: 'joe', last_name: 'camel', email: 'joe@camel.com', password: 'password')
    # visitor
    User.create(id: 2, first_name: 'joe', last_name: 'namath', email: 'joe@namath.com', password: 'password')
    # member
    User.create(id: 3, first_name: 'joan', last_name: 'rivers', email: 'joan@rivers.com', password: 'password')
    # I had to create a project where I knew the project_id
    Project.create(id: 3, name: 'toast bread')
    Membership.create(user_id: 1, project_id: 3, role: 1)
    Membership.create(user_id: 3, project_id: 3, role: 0)

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

  it 'takes owner to project tasks page upon project creation' do

    expect(page).to have_content 'Tasks for example'
  end

  scenario 'project owner can view and manage from project show page' do

    visit '/projects'

    within('table') {click_on 'example'}

    expect(page).to have_content('example')
    expect(page).to have_content('Deleting this project will')

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

  scenario 'users can only see projects they are members of on the projects index page' do

    Project.create(id: 1, name: 'example')
    Membership.create(user_id: 1, project_id: 1)
    Project.create(id: 2, name: 'example2')

    visit '/projects'

    within('table') {expect(page).to have_content('example')}
    within('table') {expect(page).to_not have_content('example2')}

  end

  it 'project members cannot manage their projects' do

    click_on 'Sign Out'
    click_on 'Sign In'

    fill_in 'email', with: 'joan@rivers.com'
    fill_in 'password', with: 'password'
    click_button 'Sign In'

    visit 'projects/3/'

    expect(page).to_not have_content('Deleting this project will')
    expect(page).to have_content('2 Members')

  end

  it 'admins can see all projects' do

    click_on 'Sign Out'
    click_on 'Sign In'

    fill_in 'email', with: 'boss@hog.com'
    fill_in 'password', with: 'password'
    click_button 'Sign In'

    expect(page).to have_content('toast bread')

  end

  it 'users can only see email of their project teammates' do
    click_on 'Sign Out'
    click_on 'Sign In'

    fill_in 'email', with: 'joan@rivers.com'
    fill_in 'password', with: 'password'
    click_button 'Sign In'

    visit '/users'

    expect(page).to_not have_content('joe@namath.com')
    expect(page).to have_content('joe@camel.com')


  end

end
