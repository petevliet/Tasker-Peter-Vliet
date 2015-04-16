require 'rails_helper'

describe 'project memberships' do

  before :each do

    # owner
    User.create(id: 1, first_name: 'joe', last_name: 'camel', email: 'joe@camel.com', password: 'password')
    # visitor
    User.create(id: 2, first_name: 'joe', last_name: 'namath', email: 'joe@namath.com', password: 'password')
    # member
    User.create(id: 3, first_name: 'joan', last_name: 'rivers', email: 'joan@rivers.com', password: 'password')
    # member2
    User.create(id: 4, first_name: 'jake', last_name: 'plummer', email: 'jake@plummer.com', password: 'password')
    # I had to create a project where I knew the project_id
    Project.create(id: 3, name: 'toast bread')
    Membership.create(user_id: 1, project_id: 3, role: 1)
    Membership.create(id: 5, user_id: 3, project_id: 3, role: 0)
    Membership.create(user_id: 4, project_id: 3, role: 0)

    visit '/signin'
      fill_in 'email', with: 'joe@camel.com'
      fill_in 'password', with: 'password'
      click_button 'Sign In'


      click_on 'New project'
      fill_in 'project[name]', with: 'example'
      click_on 'Create Project'
  end

  it 'project creator is made owner and cannot delete it' do
      click_link('proj')
      click_on '1 Members'
      expect(page).to have_content 'You are the last owner'
  end

  it 'users can only view memberships on projects they are members of' do

    click_on 'Sign Out'
    click_on 'Sign In'

    fill_in 'email', with: 'joe@namath.com'
    fill_in 'password', with: 'password'
    click_button 'Sign In'

    visit 'projects/3/memberships'

    expect(page).to have_content('You do not have access to that project')
  end

  it 'project members who are not owners do not see form for managing project memberships' do

    click_on 'Sign Out'
    click_on 'Sign In'

    fill_in 'email', with: 'joan@rivers.com'
    fill_in 'password', with: 'password'
    click_button 'Sign In'

    visit '/projects/3/memberships'

    expect(page).to have_content('Manage Members')
    expect(page).to_not have_button('Update')

  end

  it 'project owners can manage memberships of their project' do

    click_on 'Sign Out'
    click_on 'Sign In'

    fill_in 'email', with: 'joan@rivers.com'
    fill_in 'password', with: 'password'
    click_button 'Sign In'

    visit '/projects/3/memberships'

    # will fail if there are multiple (ambiguous) matches
    expect(page).to have_css('span.glyphicon')

  end

  it 'project members can delete their own memberships' do

    click_on 'Sign Out'
    click_on 'Sign In'

    fill_in 'email', with: 'joan@rivers.com'
    fill_in 'password', with: 'password'
    click_button 'Sign In'

    visit '/projects/3/memberships'

    click_link('', href: '/projects/3/memberships/5')

    expect(page).to have_content('was successfully removed')

  end

end
