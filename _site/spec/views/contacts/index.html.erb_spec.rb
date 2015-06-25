require 'spec_helper'

describe "contacts/index" do
  before(:each) do
    assign(:contacts, [
      stub_model(Contact,
        :first_name => "First Name",
        :last_name => "Last Name",
        :street => "Street",
        :city => "City",
        :state => "State",
        :zip_code => "Zip Code",
        :phone_number => "Phone Number"
      ),
      stub_model(Contact,
        :first_name => "First Name",
        :last_name => "Last Name",
        :street => "Street",
        :city => "City",
        :state => "State",
        :zip_code => "Zip Code",
        :phone_number => "Phone Number"
      )
    ])
  end

  it "renders a list of contacts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "div>div>a", :text => "First Name".to_s + " Last Name".to_s, :count => 2
  end
end
