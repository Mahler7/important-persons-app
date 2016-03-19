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
    @template = message.email_template

    mail(to: @important_email, 
      subject: @message_title,
      template_path: 'user_mailer',
      template_name: @template)
  end
end
