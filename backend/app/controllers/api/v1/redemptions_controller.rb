module Api
  module V1
    class RedemptionsController < BaseController
      def index
         redemptions = Redemption.includes(:reward).where(user: current_user)
         
         redemptions = RedemptionSerializer.new(redemptions).serializable_hash[:data].map{|redemption| redemption[:attributes]}
         render_success(data: redemptions, 
                        message: 'redemptions')
      end

      def create
        RedeemPoints.call(user: current_user, reward_id: params[:reward_id])
        render_success(data: {}, message: 'redemption successful', status: 201)
      end
    end
  end
end


