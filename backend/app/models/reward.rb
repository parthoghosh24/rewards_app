class Reward < ApplicationRecord
    has_many :redemptions
    
    validates :title, presence: true
    validates :points, presence: true
    
    scope :unredeemed, -> (user) { where.not(id: Redemption.where(user: user).select(:reward_id)) } 
end
