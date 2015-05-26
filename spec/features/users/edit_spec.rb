require 'spec_helper'

describe "edit user" do
  let(:user) { create(:user) }

  before do
    sign_in user, password: "password"
    visit "/"
    click_link "Profile"
  end

  it "takes the user to profile page" do    
    expect(page).to have_content("Update Profile")
  end

  it "changes the user's first name" do
    fill_in "First Name", with: "Rocky"
    click_button "Update Profile"
    expect(page).to have_content("Profile was successfully updated.")
    user.reload
    expect(user.user_first_name).to eq("Rocky")
  end

  it "changes the user's first name" do
    fill_in "Last Name", with: "Dogs"
    click_button "Update Profile"
    expect(page).to have_content("Profile was successfully updated.")
    user.reload
    expect(user.user_last_name).to eq("Dogs")
  end

  it "changes the user's email" do
    fill_in "Email", with: "rocky@dogs.com"
    click_button "Update Profile"
    expect(page).to have_content("Profile was successfully updated.")
    user.reload
    expect(user.email).to eq("rocky@dogs.com")
  end

  it "doesn't change the user's password without confirmation" do
    fill_in "Password", with: "NewPassword"
    click_button "Update Profile"
    expect(page).to have_content("error")
    user.reload
    click_link "Sign Out"
    fill_in "Email", with: user.email
    fill_in "Password", with: "NewPassword"
    click_button "Sign In"
    expect(page).to have_content("There was a problem logging in. Please check your email and/or password.")
  end

  it "changes the user's password" do
    fill_in "Password", with: "NewPassword"
    fill_in "Password Confirmation", with: "NewPassword"
    click_button "Update Profile"
    expect(page).to have_content("Profile was successfully updated.")
    user.reload
    click_link "Sign Out"
    fill_in "Email", with: user.email
    fill_in "Password", with: "NewPassword"
    click_button "Sign In"
    expect(page).to have_content("You've been logged in!")
  end
end