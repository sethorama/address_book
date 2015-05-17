class UserMailer < ActionMailer::Base
  default_url_options[:host] = "localhost:3000"
  default from: "from@example.com"

  def welcome_email(user)
  	@user = user
  	@url = 'localhost:3000'
  	mail to: user.email, subject: 'Welcome to Address Book!'
  end

  def password_reset(user)
  	@user = user
  	mail to: user.email, subject: "Reset Your Password"
  end
end
