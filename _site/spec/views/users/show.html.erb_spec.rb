require 'spec_helper'

describe "users/show" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :user_first_name => "User First Name",
      :user_last_name => "User Last Name",
      :email => "Email",
      :password_digest => "Password Digest"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/User First Name/)
    rendered.should match(/User Last Name/)
    rendered.should match(/Email/)
    rendered.should match(/Password Digest/)
  end
end
