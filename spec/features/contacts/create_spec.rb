require 'spec_helper'

describe "Creating contacts" do

	def create_contact(options={})
		options[:first_name] ||= "First"
		options[:last_name] ||= "Last"
		options[:street] ||= "Street"
		options[:city] ||= "City"
		options[:state] ||= "ST"
		options[:zip_code] ||= "11111"
		options[:phone_number] ||= "5555551212"

		visit "/contacts"
		click_link "New Contact"

		fill_in "First Name", with: options[:first_name]
		fill_in "Last Name", with: options[:last_name]
		fill_in "Street", with: options[:street]
		fill_in "City", with: options[:city]
		fill_in "State", with: options[:state]
		fill_in "Zip Code", with: options[:zip_code]
		fill_in "Phone Number", with: options[:phone_number]
		click_button "Create Contact"
	end

	it "redirects to contact index page on success" do
		create_contact
		expect(page).to have_content("Contact was successfully created.")
	end

	it "gives an error with no first name" do
		expect(Contact.count).to eq(0)

		create_contact first_name: ""
		expect(page).to have_content("error")
		expect(Contact.count).to eq(0)
	end

	it "gives an error with no last name" do
		expect(Contact.count).to eq(0)

		create_contact last_name: ""
		expect(page).to have_content("error")
		expect(Contact.count).to eq(0)
	end

	it "gives an error with too short a last name" do
		expect(Contact.count).to eq(0)

		create_contact last_name: "L"
		expect(page).to have_content("error")
		expect(Contact.count).to eq(0)
	end

	it "gives an error with no street" do
		expect(Contact.count).to eq(0)

		create_contact street: ""
		expect(page).to have_content("error")
		expect(Contact.count).to eq(0)
	end

	it "gives an error with too short a street" do
		expect(Contact.count).to eq(0)

		create_contact street: "123"
		expect(page).to have_content("error")
		expect(Contact.count).to eq(0)
	end

	it "gives an error with no city" do
		expect(Contact.count).to eq(0)

		create_contact city: ""
		expect(page).to have_content("error")
		expect(Contact.count).to eq(0)
	end

	it "gives an error with too short a city" do
		expect(Contact.count).to eq(0)

		create_contact last_name: "C"
		expect(page).to have_content("error")
		expect(Contact.count).to eq(0)
	end

	it "gives an error with no state" do
		expect(Contact.count).to eq(0)

		create_contact state: ""
		expect(page).to have_content("error")
		expect(Contact.count).to eq(0)
	end

	it "gives an error with too short a state" do
		expect(Contact.count).to eq(0)

		create_contact state: "S"
		expect(page).to have_content("error")
		expect(Contact.count).to eq(0)
	end

	it "gives an error with no zip code" do
		expect(Contact.count).to eq(0)

		create_contact zip_code: ""
		expect(page).to have_content("error")
		expect(Contact.count).to eq(0)
	end

	it "gives an error with a zip code less than five digits" do
		expect(Contact.count).to eq(0)

		create_contact zip_code: "1234"
		expect(page).to have_content("error")
		expect(Contact.count).to eq(0)
	end

	it "gives an error with a zip code more than five digits" do
		expect(Contact.count).to eq(0)

		create_contact zip_code: "123456"
		expect(page).to have_content("error")
		expect(Contact.count).to eq(0)
	end

	it "gives an error with a zip code not numbers" do
		expect(Contact.count).to eq(0)

		create_contact zip_code: "abcde"
		expect(page).to have_content("error")
		expect(Contact.count).to eq(0)
	end


end