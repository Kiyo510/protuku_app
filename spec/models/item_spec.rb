require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:item) { FactoryBot.create(:item) }

  describe User do
    # factory_botが有効かどうか検査
    it 'has a valid factory' do
      expect(user).to be_valid
    end
  end

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_length_of(:title).is_at_most(35) }
  it { is_expected.to validate_presence_of :region }
  it { is_expected.to validate_length_of(:content) }
  it { is_expected.to validate_length_of(:content).is_at_most(10_000) }
end
