require 'rails_helper'

RSpec.describe Redemption, type: :model do
  describe 'associations' do
    it { should belong_to(:reward) }
    it { should belong_to(:user) }
  end

  describe 'scopes' do
    describe 'default_scope' do
      let(:user) { create(:user) }
      let(:reward) { create(:reward) }
      let!(:older_redemption) { create(:redemption, user: user, reward: reward, created_at: 2.days.ago) }
      let!(:newer_redemption) { create(:redemption, user: user, reward: reward, created_at: 1.day.ago) }

      it 'orders redemptions by created_at in descending order' do
        redemptions = Redemption.where(id: [older_redemption.id, newer_redemption.id])
        expect(redemptions).to eq([newer_redemption, older_redemption])
      end
    end
  end
end
