require 'spec_helper'

describe "Editing contacts" do
	let!(:contact) { Contact.create(
													first_name: "First",
													last_name: "Last",
													street: "Street",
													city: "City",
													state: "ST",
													zip_code: "11111",
													phone_number: "5555551212"
													)}

	def edit_contact(options={})
		options[:first_name] ||= "NewFirst"
		options[:last_name] ||= "NewLast"
		options[:street] ||= "NewStreet"
		options[:city] ||= "NewCity"
		options[:state] ||= "NewST"
		options[:zip_code] ||= "22222"
		options[:phone_number] ||= "5555551212"

		visit "/contacts"
		click_link "Edit"

		fill_in "First name", with: options[:first_name]
		fill_in "Last name", with: options[:last_name]
		fill_in "Street", with: options[:street]
		fill_in "City", with: options[:city]
		fill_in "State", with: options[:state]
		fill_in "Zip code", with: options[:zip_code]
		fill_in "Phone number", with: options[:phone_number]
		click_button "Update Contact"
	end

	it "updates successfully" do
		edit_contact
		expect(page).to have_content("Contact was successfully updated.")
	end

	it "gives an error with no first name" do
		edit_contact first_name: ""
		expect(page).to have_content("error")
	end

	it "gives an error with no last name" do
		edit_contact last_name: ""
		expect(page).to have_content("error")
	end

	it "gives an error with too short a last name" do
		edit_contact last_name: "L"
		expect(page).to have_content("error")
	end

	it "gives an error with no street" do
		edit_contact street: ""
		expect(page).to have_content("error")
	end

	it "gives an error with too short a street" do
		edit_contact street: "123"
		expect(page).to have_content("error")
	end

	it "gives an error with no city" do
		edit_contact city: ""
		expect(page).to have_content("error")
	end

	it "gives an error with too short a city" do
		edit_contact last_name: "C"
		expect(page).to have_content("error")
	end

	it "gives an error with no state" do
		edit_contact state: ""
		expect(page).to have_content("error")
	end

	it "gives an error with too short a state" do
		edit_contact state: "S"
		expect(page).to have_content("error")
	end

	it "gives an error with no zip code" do
		edit_contact zip_code: ""
		expect(page).to have_content("error")
	end

	it "gives an error with a zip code less than five digits" do
		edit_contact zip_code: "1234"
		expect(page).to have_content("error")
	end

	it "gives an error with a zip code more than five digits" do
		edit_contact zip_code: "123456"
		expect(page).to have_content("error")
	end

	it "gives an error with a zip code not numbers" do
		edit_contact zip_code: "abcde"
		expect(page).to have_content("error")
	end


end