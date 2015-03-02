require 'rails_helper'

describe 'User' do

  it 'has a valid factory' do
    newuser = FactoryGirl.create(:user)
    expect(newuser).to be_valid
  end

  it 'is invalid without a first name' do
    nofirst = FactoryGirl.create(:user, first_name: '')
    expect(nofirst).to be_invalid
  end
  #
  # it 'is invalid without a last name'
  # it 'is invalid without an email'
  # it 'is invalid with a duplicate email'
  # it 'is invalid in password/password confirmation do not match'


end
