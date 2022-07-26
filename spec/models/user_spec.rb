require 'rails_helper'

RSpec.describe User, type: :model do
  
  before (:each) do
    @user = User.new(first_name: "Dan", last_name: "Lindeblom", email: "d@l.com", password: "12345", password_confirmation: "12345")
    @user.save!
  end

  describe 'Validations' do
    
    it "should save if all fields have valid inputs" do
      expect(User.all.count).to eq(1)
    end

    it "should not save if first name is blank" do
      @user.first_name = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to be_present
    end

    it "should not save if last name is blank" do
      @user.last_name = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to be_present
    end

    it "should not save if last name is blank" do
      @user.email = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to be_present
    end

    it "should not save if password is blank" do
      @user.password = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to be_present
    end

    it "should not save if password confirmation is blank" do
      @user.password_confirmation = nil
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to be_present
    end

    it "should not save if email is not unique regardless of case" do
      @user1 = User.new(first_name: "Dan", last_name: "Lindeblom", email: "D@L.com", password: "12345", password_confirmation: "12345")
      expect("Email has already been taken").to be_present
    end

    it "should not save if the passwords do not match" do
      @user.password = "12345"
      @user.password_confirmation = "1234"
      expect("Password confirmation doesn't match Password").to be_present
    end

    it "should not save if the password is less than 5 characters" do
      @user.password = "1"
      @user.password_confirmation = "1"
      expect("Password is too short (minimum is 5 characters)").to be_present
    end

    it "should not save if there is whitespace" do
      @user.email = " d@l.com"
      expect(@user).to_not be_valid
    end
    
  end

  describe '.authenticate_with_credentials' do
    
    it "should login a user if they have valid credentials" do
      valid_user = User.authenticate_with_credentials("d@l.com", "12345")
      expect(valid_user).to eq(@user)
    end

    it "should not login user if email is incorrect" do
      valid_user = User.authenticate_with_credentials("da@l.com", "12345")
      expect(valid_user).to_not eq(@user)
    end

    it "should not login user if password is incorrect" do
      valid_user = User.authenticate_with_credentials("d@l.com", "123456")
      expect(valid_user).to_not eq(@user)
    end

    it "should login user if letters are capitalized" do
      valid_user = User.authenticate_with_credentials("D@L.com", "12345")
      expect(valid_user).to eq(@user)
    end

    it "should login user there is whitspace in the email" do
      valid_user = User.authenticate_with_credentials("    d@l.com    ", "12345")
      expect(valid_user).to eq(@user)
    end    
      
  end
end
