require 'rails_helper'

describe 'user can CRUD users' do

  scenario 'user can create a user' do
    visit '/users'

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
    User.create(first_name: 'joe', last_name: 'smith', email: '1234@fake.com', password: 'password')

    visit '/users'

    click_on 'joe smith'

    expect(page).to have_content('joe smith')
    expect(page).to have_content('1234@fake.com')

  end

  scenario 'user can update user information' do
    User.create(first_name: 'joe', last_name: 'smith', email: '1234@fake.com', password: 'password')

    visit '/users'

    click_on 'joe smith'
    click_on 'Edit'
      fill_in 'user[last_name]', with: 'jones'

      expect(page).to have_content('User was successfully updated.')
      expect(page).to have_content('jones')

  end

  scenario 'user can delete users' do
    User.create(first_name: 'joe', last_name: 'smith', email: '1234@fake.com', password: 'password')

    visit '/users'

    click_on 'joe smith'
    click_on 'Edit'
    click_on 'Delete User'

    expect(page).to have_content('User was successfully destroyed.')

  end

end
