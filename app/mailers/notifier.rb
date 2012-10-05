# app/mailer/notifier.rb
class Notifier < ActionMailer::Base
	include SupportsHelper	

  # Options for the online contact form
  default :from => "nameup-noreply@gmail.com",
		      :subject => "New Message"
 
  def support_notification(sender)
    @sender = sender
    mail(:to => id_to_mail(sender.id_to))
  end 
end



