require 'rails_helper'

describe 'user can sign up successfully' do

    it 'guest cannot sign up with duplicate email' do

      User.create(first_name: 'joe', last_name: 'camel', email: 'joe@camel.com', password: 'password')

      visit '/signup'
      fill_in 'user[first_name]', with: 'example'
      fill_in 'user[last_name]', with: 'example'
      fill_in 'user[email]', with: 'joe@camel.com'
      fill_in 'user[password]', with: 'example'
      fill_in 'user[password_confirmation]', with: 'example'

      click_button 'Sign Up'
      expect(page).to have_content('Email has already been taken')

    end

    it 'guest cannot sign up if password does not match confirmation' do

      visit '/signup'
      fill_in 'user[first_name]', with: 'example'
      fill_in 'user[last_name]', with: 'example'
      fill_in 'user[email]', with: 'example@example.com'
      fill_in 'user[password]', with: 'example'
      fill_in 'user[password_confirmation]', with: 'notexample'

      click_button 'Sign Up'
      expect(page).to have_content('Password confirmation doesn\'t match Password')

    end

    it 'guest cannot sign up if first name is blank' do

      visit '/signup'
      fill_in 'user[first_name]', with: ''
      fill_in 'user[last_name]', with: 'example'
      fill_in 'user[email]', with: 'example@example.com'
      fill_in 'user[password]', with: 'example'
      fill_in 'user[password_confirmation]', with: 'example'

      click_button 'Sign Up'
      expect(page).to have_content('First name can\'t be blank')

    end

    it 'guest cannot sign up if last name is blank' do

      visit '/signup'
      fill_in 'user[first_name]', with: 'example'
      fill_in 'user[last_name]', with: ''
      fill_in 'user[email]', with: 'example@example.com'
      fill_in 'user[password]', with: 'example'
      fill_in 'user[password_confirmation]', with: 'example'

      click_button 'Sign Up'
      expect(page).to have_content('Last name can\'t be blank')

    end

    it 'guest cannot sign up if email is blank' do

      visit '/signup'
      fill_in 'user[first_name]', with: 'example'
      fill_in 'user[last_name]', with: 'example'
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: 'example'
      fill_in 'user[password_confirmation]', with: 'example'

      click_button 'Sign Up'
      expect(page).to have_content('Email can\'t be blank')

    end

    it 'guest can sign up with valid credentials' do

      visit '/signup'
      fill_in 'user[first_name]', with: 'example'
      fill_in 'user[last_name]', with: 'example'
      fill_in 'user[email]', with: 'example@example.com'
      fill_in 'user[password]', with: 'example'
      fill_in 'user[password_confirmation]', with: 'example'

      click_button 'Sign Up'
      expect(page).to have_content('New account!')

    end


end
