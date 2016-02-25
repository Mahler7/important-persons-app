class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.email_message.subject
  #
  def email_message(message)
    @important_email = message.important_person.email
    @important_message = message.user_message
    @message_title = message.title

    mail to: @important_email, subject: @message_title
  end
end
