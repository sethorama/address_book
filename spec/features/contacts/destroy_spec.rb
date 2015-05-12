require 'spec_helper'

describe "Editing contacts" do
	let(:user) { create(:user) }
	let!(:contact) { Contact.create(
													first_name: "First",
													last_name: "Last",
													street: "Street",
													city: "City",
													state: "ST",
													zip_code: "11111",
													phone_number: "5555551212"
													)}
	before do
		sign_in user, password: "password"
	end

	it "deletes a contact successfully" do
		visit "/contacts"
		expect(Contact.count).to eq(1)
		click_link "Destroy"
		expect(Contact.count).to eq(0)
	end
end