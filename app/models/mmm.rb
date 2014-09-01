class Mmm < ActiveRecord::Base
  has_many :avrs

  def display
    "#{mdu} #{adress}"
  end
end
