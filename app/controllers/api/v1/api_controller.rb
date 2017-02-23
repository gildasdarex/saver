# frozen_string_literal: true

module Api
  module V1
    # Api v1 base controller
    class ApiController < ApplicationController
      before_action :check_header

      def check_header
        return if request.content_type == 'application/json'
        render_error 'The request content type must be set to application/json.',
                     :not_acceptable
      end

      def render_error(detail, status)
        render json: { errors: [{ source: { pointer: '' }, detail: detail }] },
               status: status
      end
    end
  end
end
