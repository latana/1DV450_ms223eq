class Creator < ActiveRecord::Base

  include Rails.application.routes.url_helpers

  has_many :events

  validates :user, presence: true
  validates :password_digest, presence: true
  has_secure_password

  def serializable_hash (options={})
    options = {

        only: [:id, :user, :created_at, :updated_at],
    }.update(options)

    json = super(options)
    json['url'] = self_link
    json
  end

  def self_link
    "#{Rails.configuration.baseurl}#{api_event_path(self)}"
  end

end
