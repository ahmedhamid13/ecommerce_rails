ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              =>  'smtp.sendgrid.net',
  :port                 =>  '587',
  :authentication       =>  :plain,
  :user_name            =>  'app171030440@heroku.com',
  :password             =>  'msnqkao40395',
  :domain               =>  'heroku.com',
  :enable_starttls_auto  =>  true
}