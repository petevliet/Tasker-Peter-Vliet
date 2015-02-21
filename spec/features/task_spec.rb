require 'rails_helper'

describe 'user can CRUD tasks' do

  before :each do
    visit '/signup'
      fill_in 'registration[first_name]', with: 'joe'
      fill_in 'registration[last_name]', with: 'camel'
      fill_in 'registration[email]', with: 'joe@camel.com'
      fill_in 'registration[password]', with: 'password'
      fill_in 'registration[password_confirmation]', with: 'password'
      click_button 'Sign Up'

    click_on 'Sign In'
      fill_in 'email', with: 'joe@camel.com'
      fill_in 'password', with: 'password'
      click_button 'Sign In'

    Task.create(description: 'example')
  end

  it 'user can create a task' do

    visit '/tasks'

    click_on 'New Task'
    click_on 'Create Task'

    expect(page).to have_content 'prohibited'
      fill_in 'task[description]', with: 'example1'
      click_button 'Create Task'

    expect(page).to have_content 'example1'

  end

  scenario 'user can view project task page' do

    visit '/tasks'

    click_on 'example'

    expect(page).to have_content('Due on')

  end

  scenario 'user can update project information' do

    visit '/tasks'

    click_on 'example'
    click_on 'Edit'
      fill_in 'task[description]', with: 'example_new'
    click_on 'Update Task'

      expect(page).to have_content('Task was successfully updated.')

  end

  scenario 'user can delete task' do

    visit '/tasks'
    click_on 'Delete'

    expect(page).to have_content('Task was successfully destroyed.')

  end

end
