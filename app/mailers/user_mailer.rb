class UserMailer < ActionMailer::Base

  default from: "noreply@tsethorama-address-book.com"

  ActionMailer::Base.smtp_settings = {
  :port           => ENV['MAILGUN_SMTP_PORT'],
  :address        => ENV['MAILGUN_SMTP_SERVER'],
  :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
  :password       => ENV['MAILGUN_SMTP_PASSWORD'],
  :domain         => 'https://sethorama-address-book.herokuapp.com',
  :authentication => :plain
}
ActionMailer::Base.delivery_method = :smtp

  def welcome_email(user)
  	@user = user
  	@url = 'https://sethorama-address-book.herokuapp.com'
  	mail to: user.email, subject: 'Welcome to Address Book!'
  end

  def password_reset(user)
  	@user = user
  	mail to: user.email, subject: "Reset Your Password"
  end
end
