# frozen_string_literal: true

# Pages helper
module PagesHelper
  def support_tags?(tags)
    return true if tags.nil?
    supported_tags_names = Page.supported_tags.collect { |tag| tag[:name] }
    request_tags = tags.map(&:downcase)
    request_tags.each do |tag|
      return false unless supported_tags_names.include? tag
    end
    true
  end
end
