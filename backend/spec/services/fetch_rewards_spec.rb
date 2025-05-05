require 'rails_helper'

RSpec.describe FetchRewards do
  let!(:user) { create(:user) }
  let!(:reward1) { create(:reward, points: 100) }
  let!(:reward2) { create(:reward, points: 200) }
  
  describe '.call' do
    context 'when user has no redemptions' do

      it 'returns all the rewards' do
        
        result = described_class.call(user: user)        

        expect(result.length).to eq(2)
      end
    end

    context 'when user has 1 redemption' do
      before(:each) do
        create(:redemption, user: user, reward: reward1)  
      end

      it 'returns 1 reward' do
        
        result = described_class.call(user: user)        

        expect(result.length).to eq(1)
        expect(result[0][:points]).to eq(200)
      end
    end

    context 'when user redemmed all the rewards' do
      before(:each) do
        create(:redemption, user: user, reward: reward1) 
        create(:redemption, user: user, reward: reward2)  
      end

      it 'returns empty list' do
        
        result = described_class.call(user: user)        

        expect(result.length).to eq(0)
      end
    end
  end
end 