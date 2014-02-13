class Event < ActiveRecord::Base
  has_many :event_attendances
  has_many :event_attendees, through: :event_attendances, source: :user
end
