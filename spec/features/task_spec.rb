require 'rails_helper'

describe 'user can CRUD tasks' do

  before :each do

    User.create(first_name: 'example', last_name: 'example', email: 'example@email.com', password: 'password', id: 14)
    Project.create(name: 'example', id: 1)
    Task.create(description: 'example-old', project_id: 1, complete: false, due_date: '2015-04-10')
    Membership.create(user_id: 14, project_id: 1, role: 1)

    visit '/signin'
    fill_in 'email', with: 'example@email.com'
    fill_in 'password', with: 'password'
    click_button 'Sign In'
  end

  it 'user can create a task' do

    visit '/projects/1/tasks'

    click_on 'New Task'
    click_on 'Create Task'

    expect(page).to have_content 'prohibited'
      fill_in 'task[description]', with: 'example1'
      click_button 'Create Task'

    expect(page).to have_content 'example1'

  end

  it 'user can view project task page' do

    visit '/projects/1/tasks'

    click_on 'example-old'

    expect(page).to have_content('Due')

  end

  it 'user can update project_task information' do

    visit '/projects/1/tasks'

    click_on 'Edit'
      fill_in 'task[description]', with: 'example-new'
    click_on 'Update Task'

      expect(page).to have_content('Task was successfully updated.')

  end

  it 'user can delete task' do
    visit '/projects/1/tasks'
    click_link('delete_link')

    expect(page).to have_content('Task was successfully destroyed.')

  end

  it 'user can only manage tasks on projects they are members of' do

    User.create(first_name: 'tony', last_name: 'montana', email: 'tony@montana.com', password: 'password', id: 15)
    click_on 'Sign Out'
    click_on 'Sign In'

    fill_in 'email', with: 'tony@montana.com'
    fill_in 'password', with: 'password'
    click_button 'Sign In'

    visit 'projects/1/tasks'

    expect(page).to have_content('You do not have access to that project')

  end

end
