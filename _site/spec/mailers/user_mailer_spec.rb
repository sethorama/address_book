require "spec_helper"

describe UserMailer do
	let(:user) { create(:user) }
  it "sends an email when a user signs up" do
  	mailer = UserMailer.welcome_email(user)
  	expect(mailer.to).to eq([user.email])
  	expect(mailer.subject).to eq("Welcome to Address Book!")
	end
end
