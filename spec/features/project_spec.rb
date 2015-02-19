require 'rails_helper'

describe 'user can CRUD projects' do

  before :each do
    @project = Project.create(name: 'example')
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

    click_on 'example'

    expect(page).to have_content('example')

  end

  scenario 'user can update project information' do

    visit '/projects'

    click_on 'example'
    click_on 'Edit'
      fill_in 'project[name]', with: 'example_new'
    click_on 'Update Project'

      expect(page).to have_content('example_new')

  end

  scenario 'user can delete projects' do

    visit '/projects'

    click_on 'example'
    click_on 'Delete'

    expect(page).to have_content('Project was successfully destroyed.')

  end

end
