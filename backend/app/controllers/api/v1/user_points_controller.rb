module Api
  module V1
    class UserPointsController < BaseController
      def index
        user_points = UserPoint.find_by(user: current_user)
        user_points = UserPointSerializer.new(user_points).serializable_hash[:data][:attributes]
        render_success(data: user_points, 
          message: 'user points')
      end
    end
  end
end