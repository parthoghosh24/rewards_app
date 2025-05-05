module Api
  module V1
    class RewardsController < BaseController
      def index
        rewards = FetchRewards.call(user: current_user)
        rewards = RewardSerializer.new(rewards).serializable_hash[:data].map{|reward| reward[:attributes]}
        render_success(data: rewards, 
          message: 'rewards')
      end
    end
  end
end



