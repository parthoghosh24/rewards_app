module Api
  module V1
    class BaseController < ApplicationController
      
      before_action :authenticate_api_v1_user!
      
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from Errors::RedemptionError, with: :redemption_error

      def current_user
        current_api_v1_user
      end
      
      private

      def redemption_error
          render_error(code: , message: 'Failed to redeem', status: 500)
      end
      
      def not_found
        render json: {
          error: 'Record not found'
        }, status: :not_found
      end
    end
  end
end 