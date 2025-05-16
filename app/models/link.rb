class Link < ApplicationRecord
  validates :original_url, presence: true, url: true
  validates :short_code, presence: true, uniqueness: true

  before_validation :generate_short_code, on: :create

  private

  def generate_short_code
    # Basic code generation (can be made more robust)
    self.short_code = loop do
      code = SecureRandom.alphanumeric(6) # Needs 'securerandom' gem
      break code unless Link.exists?(short_code: code)
    end
  end
end
