class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  
  

  has_one :user_point
  has_many :redemptions        
  after_create :add_points
  
  private

  def add_points
     user_points  = UserPoint.create(user: self, points: 5000)
  end
end
