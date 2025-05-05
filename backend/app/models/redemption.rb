class Redemption < ApplicationRecord
  belongs_to :reward
  belongs_to :user

  default_scope { order('created_at DESC') }
end
