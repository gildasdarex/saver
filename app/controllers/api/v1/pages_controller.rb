# frozen_string_literal: true

module Api
  module V1
    # Pages API V1 controller
    class PagesController < Api::V1::ApiController
      include PagesHelper
      before_action :check_tags, only: [:create]

      def index
        render json: Pages::QueryService.call(pagination_params)
      end

      def create
        page = Pages::CreateService.call(page_params)

        if page.persisted?
          render json: page, status: :created
        else
          render json: page, status: :unprocessable_entity
        end
      end

      private

      def page_params
        params.require(:page).permit(:url, tags: [])
      end

      def pagination_params
        if params[:page]
          params[:page].permit(:number, :size)
        else
          { number: 1, size: Kaminari.config.default_per_page }
        end
      end

      def check_tags
        return if support_tags?(page_params[:tags])
        render_error('Unsupported tags found in request', :unprocessable_entity)
      end
    end
  end
end
