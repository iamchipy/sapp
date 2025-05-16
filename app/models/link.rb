class Link < ApplicationRecord
  validates :original_url, presence: true, url: true
  validates :short_code, presence: true, uniqueness: true

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
    # Basic code generation (can be made more robust)
    self.short_code = loop do
      code = SecureRandom.alphanumeric(6) # Needs 'securerandom' gem
      break code unless Link.exists?(short_code: code)
    end
  end
end
