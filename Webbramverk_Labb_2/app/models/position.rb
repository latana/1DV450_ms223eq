class Position < ActiveRecord::Base

  has_many :events

  validates :long, presence: true
  validates :latt, presence: true

end
