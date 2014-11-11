class Event < ActiveRecord::Base
  REPEAT_TYPES = %i(daily weekly monthly yearly)

  extend Enumerize

  belongs_to :user

  validates_presence_of :title, :starts_on
  validates_presence_of :repeats, if: :recurring?

  enumerize :repeats, in: REPEAT_TYPES, predicates: true
end