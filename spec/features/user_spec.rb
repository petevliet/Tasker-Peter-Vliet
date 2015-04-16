require 'rails_helper'

describe 'user can CRUD users' do

  before :each do
    User.create(id: 10, first_name: 'joe', last_name: 'smith', email: '1234@fake.com', password: 'password')
    User.create(id: 5, first_name: 'jane', last_name: 'smith', email: '1111@fake.com', password: 'password')
    # admin
    User.create(id: 1, first_name: 'pete', last_name: 'vliet', email: 'pete@vliet.com', password: 'password', admin: true)

    visit '/signin'

    fill_in 'email', with: '1234@fake.com'
    fill_in 'password', with: 'password'
    click_button 'Sign In'

    visit '/users'
  end

  scenario 'user can create a user' do

    click_on 'New user'
      fill_in 'user[first_name]', with: 'joe'
      fill_in 'user[last_name]', with: 'smith'
      fill_in 'user[email]', with: 'test@fake.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_on 'Create User'

    expect(page).to have_content('User was successfully created.')

  end

  scenario 'user can view user show page' do

    within('table') {click_on 'joe smith'}

    expect(page).to have_content('joe smith')
    expect(current_path).to eq(user_path(10))

  end

  scenario 'user can update user information' do

    within('table') {click_on 'joe smith'}
    click_on 'Edit'
      fill_in 'user[last_name]', with: 'jones'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
    click_on 'Update User'

      expect(page).to have_content('User was successfully updated.')
      expect(page).to have_content('jones')

  end

  scenario 'user can delete users' do

    # within('table') {click_on 'joe smith'}
    # click_on 'Edit'
    click_on 'Delete'

    expect(page).to have_content('User successfully destroyed')

  end

  scenario 'user cannot see another users edit page' do
    click_on 'Sign Out'

    click_on 'Sign In'
    fill_in 'email', with: '1111@fake.com'
    fill_in 'password', with: 'password'
    click_button 'Sign In'

    visit '/users/10/edit'

    expect(page).to have_content('The page you were looking for')

  end

  scenario 'users cannot see other users email' do
    visit '/users'

    expect(page).to have_content('1234@fake.com')
    expect(page).to_not have_content('1111@fake.com')

  end

  scenario 'admins can create other admins' do

    User.create(first_name: 'admin', last_name: 'admin', email: 'admin@example.com', password: 'password', admin: true)
    click_on 'Sign Out'

    click_on 'Sign In'
    fill_in 'email', with: 'admin@example.com'
    fill_in 'password', with: 'password'
    click_button 'Sign In'

    visit '/users/new'

    expect(page).to have_content('Admin')

  end

  scenario 'users cannot create admins' do
    visit '/users/new'

    expect(page).to_not have_content('Admin')

  end

  scenario 'admins can edit all users' do
    click_on 'Sign Out'
    click_on 'Sign In'

    fill_in 'email', with: 'pete@vliet.com'
    fill_in 'password', with: 'password'
    click_button 'Sign In'

    visit '/users/5/edit'

    expect(page).to have_content('Edit User')

    fill_in 'user[first_name]', with: 'Bubba'

    click_on 'Update User'

    expect(page).to have_content('User was successfully updated')

  end

end
