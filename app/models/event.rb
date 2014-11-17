class Event < ActiveRecord::Base
  REPEAT_TYPES = %i(daily weekly monthly yearly)

  extend Enumerize

  belongs_to :user

  validates_presence_of :title, :starts_on
  validates_presence_of :repeats, if: :recurring?

  enumerize :repeats, in: REPEAT_TYPES, predicates: true

  scope :for_user, ->(user) { where(user: user) }

  def as_json(options = {})
    {
      id: id,
      title: title,
      start: try(:schedule_date) || starts_on
    }
  end
end