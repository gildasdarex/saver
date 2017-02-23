# frozen_string_literal: true
require 'open-uri'
module Pages
  # Create page service
  class QueryService < Base
    def call(params)
      pages = Page.all
      pages.page(params[:number]).per(params[:size])
    end
  end
end
