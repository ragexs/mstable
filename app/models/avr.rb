class Avr < ActiveRecord::Base
  belongs_to :mmm
  belongs_to :user

  validates :mmm, presence: true
  validates :user, presence: true
end
