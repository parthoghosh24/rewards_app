require 'rails_helper'

RSpec.describe UserPoint, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'database columns' do
    it { should have_db_column(:points).of_type(:integer).with_options(default: 0) }
    it { should have_db_column(:user_id).of_type(:integer).with_options(null: false) }
  end

  describe 'creation' do
    let(:user) { create(:user) }

    it 'is automatically created when a user is created' do
      expect(user.user_point).to be_present
      expect(user.user_point.points).to eq(5000)
    end
  end
end
