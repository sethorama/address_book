require "spec_helper"

describe "Logging In" do
	it "displays the email address if the password is wrong" do
		visit new_user_session_path
		fill_in "Email Address", with: "seth@me.com"
		fill_in "Password", with: "wrongpass"
		click_button "Sign In"

		expect(page).to have_content("There was a problem logging in")
		expect(page).to have_field("Email Address", with: "seth@me.com")
	end
end