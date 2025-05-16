class Link < ApplicationRecord
  validates :original_url, presence: true, url: true
  validates :short_code, presence: true, uniqueness: true

  # before_create :generate_short_code
  before_validation :generate_short_code, on: :create
  before_save :set_short_url

  def full_short_url
    Rails.application.routes.url_helpers.short_link_url(short_code, host: Rails.application.config.default_url_options[:host])
  end

  private

  def set_short_url
    self.short_url = Rails.application.routes.url_helpers.short_link_url(short_code, host: Rails.application.config.default_url_options[:host])
  end

  def generate_short_code
    return if original_url.blank?  # prevent generating code for invalid links
    self.short_code ||= SecureRandom.alphanumeric(6).upcase
  end
end
