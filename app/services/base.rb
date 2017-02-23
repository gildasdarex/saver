# frozen_string_literal: true

# Services base class
class Base
  attr_accessor :errors

  def initialize
    @errors = []
  end

  class << self
    def build
      new
    end

    def call(attributes = nil)
      @instance = build
      attributes ? @instance.call(attributes) : @instance.call
    end

    def errors
      @instance.errors
    end
  end
end
