require 'spec_helper'

describe User do
	let(:valid_attributes) {
		{
			user_first_name: "Seth",
			user_last_name: "Reece",
			email: "seth@me.com",
			password: "password",
			password_confirmation: "password"
		}
	}

	# context "relationships" do
	# 	it { should have_many(:contacts)}
	# end


  context "validations" do
  	let(:user) { User.new(valid_attributes)}

  	before do
  		User.create(valid_attributes)
  	end

  	it "requires an email" do
  		expect(user).to validate_presence_of(:email)
  	end

  	it "requires an unique email" do
  		expect(user).to validate_uniqueness_of(:email)
  	end

  	it "requires an unique email (case insensitive)" do
  		user.email = "SETH@ME.COM"
  		expect(user).to validate_uniqueness_of(:email)
  	end  	

  	it "requires the email address to look like an email" do
        user.email = "seth"
        expect(user).to_not be_valid
    end

    describe "#downcase_email" do

    	it "makes the email attribute lower case" do
    		user = User.new(valid_attributes.merge(email: "SETH@ME.COM"))
    		user.downcase_email
    		expect(user.email).to eq("seth@me.com")
    	end

    	it "downcases an email before saving" do
	  		user = User.new(valid_attributes)
	  		user.email = "SETH@ME.COM"
	  		expect(user.save).to be_truthy
	  		expect(user.email).to eq("seth@me.com")
	  	end
    end

    describe "#generate_password_reset_token!" do
      let(:user) { create(:user) }

      it "changes the password_reset_token attribute" do
        expect{ user.generate_password_reset_token! }.to change{user.password_reset_token}
      end

      it "calls SecureRandom.urlsafe_base64 to generate password_reset_token" do
        expect(SecureRandom).to receive(:urlsafe_base64)
        user.generate_password_reset_token!
      end
    end
  end
end
