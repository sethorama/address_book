class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user)
  	@user = user
  	@url = 'localhost:3000'
  	mail to: user.email, subject: 'Welcome to Address Book!'
  end
end
