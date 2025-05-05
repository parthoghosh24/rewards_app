require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_one(:user_point) }
    it { should have_many(:redemptions) }
  end

  describe 'devise modules' do
    it 'should include default devise modules' do
      expect(User.devise_modules).to include(
        :database_authenticatable,
        :registerable,
        :recoverable,
        :rememberable,
        :validatable,
        :jwt_authenticatable
      )
    end
  end

  describe 'callbacks' do
    describe '#add_points' do
      it 'creates user_points with 5000 points after user creation' do
        user = create(:user)
        expect(user.user_point).to be_present
        expect(user.user_point.points).to eq(5000)
      end
    end
  end

  describe 'JWT authentication' do
    it 'uses JTIMatcher as JWT revocation strategy' do
      expect(User.jwt_revocation_strategy).to eq(User)
    end
  end
end
