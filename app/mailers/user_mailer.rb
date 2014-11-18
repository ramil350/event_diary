class UserMailer < ActionMailer::Base
  default from: 'from@example.com'

  def notification_email(user, events)
    @user = user
    @events = events
    mail(to: user.email, subject: 'Your events for today!')
  end
end
