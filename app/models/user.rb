require 'bcrypt'

class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true, format: { with: /[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,3}/, message: "Invalid Email" }
  validates :password, presence: true

  has_many :created_events, class_name: "Event"

  has_many :event_attendances
  has_many :attended_events, through: :event_attendances, source: :event

  include BCrypt
  has_secure_password

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end

  def authenticate(user_pass)
    if self.password == user_pass
      true
    else
      false
    end
  end
end
