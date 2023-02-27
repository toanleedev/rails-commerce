class UserMailer < ApplicationMailer
  def confirmation_user_mail(record, opts={})
    @user = record
    @token = record.confirmation_token
    mail(to: @user.email, subject: t('.confirmation_user'))
  end
end
