class Event < ActiveRecord::Base
  REPEAT_TYPES = %i(daily weekly monthly yearly)

  extend Enumerize

  belongs_to :user

  validates_presence_of :title, :starts_on
  validates_presence_of :repeats, if: :recurring?
  validate :ends_later_than_start?

  enumerize :repeats, in: REPEAT_TYPES, predicates: true

  def as_json(options = {})
    {
      id: id,
      title: title,
      start: try(:schedule_date) || starts_on,
      ends_on: ends_on
    }
  end

  private

  def ends_later_than_start?
    if ends_on.present? && ends_on <= starts_on
      errors.add(:ends_on, 'must be later than starts on')
    end
  end
end