require "spec_helper"

describe "Logging In" do

	it "logs the user in and redirects to the contacts page" do
		User.create(
								user_first_name: "Seth",
								user_last_name: "Reece",
								email: "seth@me.com",
								password: "password",
								password_confirmation: "password"
								)
		visit "/login"
		fill_in "Email Address", with: "seth@me.com"
		fill_in "Password", with: "password"
		click_button "Sign In"

		expect(page).to have_content("Contacts")
		expect(page).to have_content("You've been logged in!")
	end

	it "displays the email address if the password is wrong" do
		visit "/login"
		fill_in "Email Address", with: "seth@me.com"
		fill_in "Password", with: "wrongpass"
		click_button "Sign In"

		expect(page).to have_content("There was a problem logging in")
		expect(page).to have_field("Email Address", with: "seth@me.com")
	end
end