class MailingService
  def initialize(users, day)
    @users = users
    @day = day
  end

  def notify
    @users.each do |user|
      events = events_for(user)
      notification_for(user, events).deliver! if events.any?
    end
  end

  private

  def events_for(user)
    query = EventScheduleQuery.new(user.events)
    query.build(@day, @day)
  end

  def notification_for(user, events)
    UserMailer.notification_email(user, events)
  end
end