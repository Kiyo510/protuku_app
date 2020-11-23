# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:item) { FactoryBot.create(:item) }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_length_of(:title).is_at_most(50) }
  it { is_expected.to validate_presence_of :prefecture_id }
  it { is_expected.to validate_length_of(:content) }
  it { is_expected.to validate_length_of(:content).is_at_most(10_000) }

  describe '画像の投稿機能' do
    context '有効な画像だったとき' do
      it '画像の投稿に成功すること' do
        item.image.attach(io: File.open(Rails.root.join('spec/fixtures/images/test.jpg')),
                          filename: 'test.jpg', content_type: 'image/jpg')
        expect(item).to be_valid
      end
    end

    context '5MBを超える画像がアップロードされたとき' do
      it '5投稿に失敗すること' do
        item.image.attach(io: File.open(Rails.root.join('spec/fixtures/images/test_5mb.jpg')),
                          filename: 'test_5mb.jpg', content_type: 'image/jpg')
        expect(item).to be_invalid
      end
    end

    context 'images以外の拡張子の画像がアップロードされたとき' do
      it '画像の投稿に失敗すること' do
        item.image.attach(io: File.open(Rails.root.join('spec/fixtures/images/test.pdf')),
                          filename: 'test.pdf', content_type: 'application/pdf')
        expect(item).to be_invalid
      end
    end
  end
end
