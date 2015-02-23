class Position < ActiveRecord::Base

  has_many :events

  reverse_geocoded_by :long, :latt

  validates :long, presence: true
  validates :latt, presence: true

  after_validation :reverse_geocode
end
