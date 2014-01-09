require 'spec_helper'
describe User do
  before(:each) do
    @user = FactoryGirl.create(:user, email:"abc@vinsol.com", firstname: "abc", lastname:"def", username: "abcdef")
  end
  it "is valid with valid attributes" do
    @user.should be_valid
  end
  it "is invalid without email" do
    @user.email = nil
    @user.should_not be_valid
  end
  it "is invalid without first name" do
    @user.firstname = nil
    @user.should_not be_valid
  end
  it "is invalid without user name" do
    @user.username = nil
    @user.should_not be_valid
  end
  

  describe "is invalid without a unique first name" do
    before(:each) do
      @user = FactoryGirl.build(:user, email:"abc@vinsol.com", firstname: "divya", lastname: "abc", username: "abcdef")
    end
    it "is not valid without a unique first name" do
      @user.should_not be_valid
    end
  end 
  describe "is invalid without a unique username" do
    before(:each) do
      @user = FactoryGirl.build(:user, email:"abc@vinsol.com", firstname: "divya1", lastname: "abcd", username: "divyatalwar")
    end
    it "is not valid without a unique first name" do
      @user.should_not be_valid
    end
  end 
  describe "is invalid without a unique email" do
    before(:each) do
      @user = FactoryGirl.build(:user, email:"divya@vinsol.com")
    end
    it "is not valid without a unique mail" do
      @user.should_not be_valid
    end
  end 
end
