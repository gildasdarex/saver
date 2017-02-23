# frozen_string_literal: true

# Page model class
class Page < ApplicationRecord
  validates :url, presence: true
  validates :url, format: { with: URI.regexp }, allow_blank: false

  def self.supported_tags
    [
      { name: 'h1', type: 'text' },
      { name: 'h2', type: 'text' },
      { name: 'h3', type: 'text' },
      { name: 'a', type: 'url' }
    ]
  end
end
