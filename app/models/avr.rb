class Avr < ActiveRecord::Base
has_many :mmms
  has_many :users
end
