require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    before(:each) do
      @user = User.new(
        name: 'firstName',
        email: 'test@gmail.com',
        password: 'test123',
        password_confirmation: 'test123'
      )
    end

    it 'checks is a user is valid' do
      expect(@user).to be_valid
    end

    it 'checks if password confirmation does not match password' do
      @user.password_confirmation = 'different123'
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to include("doesn't match")
    end

    it 'requires a password and confirmation to succeed' do
      @user.password = nil
      @user.password_confirmation = nil
      expect(@user).to_not be_valid
    end

    it "does require user to have a name" do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it "doesn't require user to have an email" do
      @user.email = nil
      expect(@user).to be_valid
    end

    it 'refuses to create a user with an email that already exists' do
      @user.save!

      @user2 = User.new(
        name: "Tony Test",
        email: 'test@gmail.com',
        password: 'oops456',
        password_confirmation: 'oops456'
      )
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages[0]).to eq("Email has already been taken")
    end

    it 'checks password length greater than 4' do
      @user.password = '123'
      @user.password_confirmation = '123'
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages[0]).to eq("Password is too short (minimum is 4 characters)")
    end


  end

  describe '.authenticate_with_Credentials' do

    before(:each) do
      @user = User.create(
        name: 'firstName',
        email: 'test@gmail.com',
        password: 'test123',
        password_confirmation: 'test123'
      )
    end

    it 'redirects user to main page if correct password' do
      expect(User.authenticate_with_credentials('test@gmail.com', 'test123')).to eq(@user)
    end

    it 'validates email without case-sensitivity' do
      expect(User.authenticate_with_credentials('tEsT@gMaIl.COM', 'test123')).to eq(@user)
    end

    it 'trims spacing around email and correctly parses' do
      expect(User.authenticate_with_credentials('  test@gmail.com  ', 'test123')).to eq(@user)
    end

  end
end
