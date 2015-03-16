class Event < ActiveRecord::Base

  include Rails.application.routes.url_helpers

  has_and_belongs_to_many :tags
  belongs_to :creator
  belongs_to :position

  validates :description, presence: true
  validates :title, presence: true

  def serializable_hash (options={})
    options = {

        include: {:position => {only: [:long, :latt]}, :creator => {only: [:user]}, :tags => {only:[:name]}},
        only: [:id, :title, :position_id, :creator_id, :description, :created_at, :updated_at],
    }.update(options)

    json = super(options)
    json['url'] = self_link
    json
  end

  def self_link
     "#{Rails.configuration.baseurl}#{api_event_path(self)}"
  end

end
