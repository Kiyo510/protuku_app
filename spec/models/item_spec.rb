require 'rails_helper'
include NotificationsHelper

RSpec.describe Item, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:item) { FactoryBot.create(:item) }

  describe User do
    # factory_botが有効かどうか検査
    it 'has a valid factory' do
      expect(user).to be_valid
      expect(item).to be_valid
    end
  end

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_length_of(:title).is_at_most(35) }
  it { is_expected.to validate_presence_of :region }
  it { is_expected.to validate_length_of(:content) }
  it { is_expected.to validate_length_of(:content).is_at_most(10_000) }

  describe 'post_item_image' do
    it 'shoul indicate item_image' do
      item.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'images', 'test.jpg')), filename: 'test.jpg', content_type: 'image/jpg')
      expect(item).to be_valid
    end

    it 'should not be over than 5MB' do
      item.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'images', 'test_5mb.jpg')), filename: 'test_5mb.jpg', content_type: 'image/jpg')
      expect(item).to be_invalid
    end

    it 'should be only images file' do
      item.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'images', 'test.pdf')), filename: 'test.pdf', content_type: 'application/pdf')
      expect(item).to be_invalid
    end
  end
end
