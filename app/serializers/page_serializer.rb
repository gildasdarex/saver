# frozen_string_literal: true

# Page serializer
class PageSerializer < ActiveModel::Serializer
  attributes :id, :url, :contents
end
