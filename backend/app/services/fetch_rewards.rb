# This fetches the rewards
# for logged in user
class FetchRewards
   def self.call(user: user)
      new(user).call
   end

   def initialize(user)
      @user = user
   end

   def call
       Reward.unredeemed(@user)  
   end
end