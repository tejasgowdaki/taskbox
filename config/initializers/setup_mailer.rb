ActionMailer::Base.smtp_settings = {
   :address => "smtp.gmail.com",
   :port => 587,
   :domain => "gmail.com",
   :authentication => "plain",
   :enable_starttls_auto => true,
   :user_name => "tejasgowda80@gmail.com",
   :password => "9986965101",
   :openssl_verify_mode  => 'none'
}