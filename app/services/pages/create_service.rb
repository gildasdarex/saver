# frozen_string_literal: true
require 'open-uri'
module Pages
  # Create page service
  class CreateService < Base
    def call(params)
      @page_dom = Nokogiri::HTML(open(params[:url]))
      contents = {}
      get_tags(params[:tags]).each do |tag|
        contents[tag[:name]] = send("get_#{tag[:type]}", tag[:name])
      end
      Page.create!(url: params[:url], contents: contents)
    end

    private

    def get_text(tag)
      @page_dom.css(tag).collect(&:text)
    end

    def get_url(tag)
      urls = @page_dom.css(tag).collect { |html| html['href'] }
      urls.select { |url| url[0] != '#' }
    end

    def get_tags(tags)
      return Page.supported_tags if tags.nil?
      request_tags = tags.map(&:downcase)
      Page.supported_tags.select { |tag| request_tags.include? tag[:name] }
    end
  end
end
