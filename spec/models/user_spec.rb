require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  before(:each) do
     @attr = { :first_name => "David", :last_name =>"Zabinski", :email => "david@z.com", :password => "whatever", :password_confirmation => "whatever"}
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should not create user with no first name" do
    no_first_name_user = User.create(@attr.merge(:first_name => ""))
    no_first_name_user.should_not be_valid
  end

  it "should not create user with no last name" do
    no_last_name_user = User.create(@attr.merge(:last_name => ""))
    no_last_name_user.should_not be_valid
  end

  it "should not create user with no email" do
    no_email_user = User.create(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should not create user with no password" do
    no_password_user = User.create(@attr.merge(:password => ""))
    no_password_user.should_not be_valid
  end

  it "should not create user if password and confirmation do not match" do
    unmatched_pw_user = User.create(@attr.merge(:password_confirmation => "asdf"))
    unmatched_pw_user.should_not be_valid
  end

  it "should not create user with malformed email" do
    bad_email_user = User.create(@attr.merge(:email => "nowaythiswillwork"))
    bad_email_user.should_not be_valid
  end

  it "should not create duplicate email user" do
    first_user = User.create!(@attr)
    duplicate_user = User.create(@attr)

    duplicate_user.should_not be_valid

    correct_user = User.create(@attr.merge(:email => "different@user.com"))
    correct_user.should be_valid
  end

  it "should create all users as beta users for now" do
    new_user = User.create!(@attr)

    new_user.should be_beta_user
  end
end
