# This redeems
# reward for user if eligible
class RedeemPoints
  def self.call(user: user, reward_id: reward_id)
     new(user, reward_id).call
  end

  def initialize(user, reward_id)
     @user = user
     @reward_id = reward_id
  end

  def call
      # In transaction
      # Reduce points from existing points.
      # if there not enough points for reduction
      # then raise error
      # Add in Redemption table

      ActiveRecord::Base.transaction do        
        reward  = Reward.find(@reward_id)
        user_points = UserPoint.find_by(user: @user)

        raise StandardError, "Not enough points" unless user_points && user_points.points >= reward.points
        
        
        user_points.update(points: user_points.points - reward.points)
        Redemption.create!(user: @user, reward: reward)
      end
   end
end