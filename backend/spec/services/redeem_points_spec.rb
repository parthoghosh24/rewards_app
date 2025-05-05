require 'rails_helper'

RSpec.describe RedeemPoints do
  let(:user) { create(:user) }
  let(:reward) { create(:reward, points: 100) }
  
  describe '.call' do
    context 'when user has enough points' do

      it 'successfully redeems the reward' do
        
        described_class.call(user: user, reward_id: reward.id)        

        redemption = Redemption.first
        expect(redemption.user).to eq(user)
        expect(redemption.reward).to eq(reward)
        expect(redemption.user.user_point.points).to eq(user.user_point.points - reward.points)
      end
    end

    context 'when user does not have enough points' do
      let!(:reward) { create(:reward, points: 10000) }
      

      it 'raises an error and does not create redemption' do
        expect {
          described_class.call(user: user, reward_id: reward.id)
        }.to raise_error(StandardError, "Not enough points")

        expect(Redemption.count).to eq(0)
        expect(user.user_point.reload.points).to eq(5000)
      end
    end

    context 'when reward does not exist' do
      it 'raises an ActiveRecord::RecordNotFound error' do
        create(:user_point, user: user, points: 150)
        initial_points = user.user_point.points
        
        expect {
          described_class.call(user: user, reward_id: -1)
        }.to raise_error(ActiveRecord::RecordNotFound)
        
        expect(Redemption.count).to eq(0)
        expect(user.user_point.reload.points).to eq(initial_points)
      end
    end
  end
end 