class UserMailer < ActionMailer::Base

  default :from => ENV['mail_username']

  def email_confirmation(article)
    @article = article
    mail(:to => "<#{article.email}>",
         :subject => "E-Mail Confirmation")
  end

end