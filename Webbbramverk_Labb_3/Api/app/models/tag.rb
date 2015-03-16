class Tag < ActiveRecord::Base

  include Rails.application.routes.url_helpers

  has_and_belongs_to_many :events
  before_save {self.name = name.downcase}
  validates :name, presence: true, case_sensitive: false

  def serializable_hash (options={})
    options = {

    }.update(options)

    json = super(options)
    json['url'] = self_link
    json
  end

  def self_link
    "#{Rails.configuration.baseurl}#{api_event_path(self)}"
  end

end
