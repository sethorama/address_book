require "spec_helper"

describe "Signing up" do
	it "allows a user to sign up" do
		expect(User.count).to eq(0)

		visit "/"
		expect(page).to have_content("Register")
		click_link "Register"

		fill_in "First Name", with: "Seth"
		fill_in "Last Name", with: "Reece"
		fill_in "Email", with: "seth@me.com"
		fill_in "Password", with: "password"
		fill_in "Password Confirmation", with: "password"
		click_button "Register"
		expect(User.count).to eq(1)
	end
end