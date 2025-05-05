require 'rails_helper'

RSpec.describe Reward, type: :model do
  describe 'associations' do
    it { should have_many(:redemptions) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:points) }
  end

  describe 'scopes' do
    describe '.unredeemed' do
      let(:user) { create(:user) }
      let!(:redeemed_reward) { create(:reward) }
      let!(:unredeemed_reward) { create(:reward) }

      before do
        create(:redemption, user: user, reward: redeemed_reward)
      end

      it 'returns rewards not redeemed by the given user' do
        expect(Reward.unredeemed(user)).to include(unredeemed_reward)
        expect(Reward.unredeemed(user)).not_to include(redeemed_reward)
      end
    end
  end
end
