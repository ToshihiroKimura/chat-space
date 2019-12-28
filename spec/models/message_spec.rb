require 'rails_helper'
describe Message do
  describe '#create' do
    context 'can save' do
      it "is valid with a text" do
        message = build(:message, image: nil)
        message.valid?
        expect(message).to be_valid
      end

      it "is valid with a image" do
        message = build(:message, text: nil)
        message.valid?
        expect(message).to be_valid
      end

      it "is valid with a text, image" do
        message = build(:message)
        message.valid?
        expect(message).to be_valid
      end
    end

    context 'can not save' do
      it "is invalid without a name, image" do
        message = build(:message, text: nil, image: nil)
        message.valid?
        expect(message.errors[:text]).to include("を入力してください")
      end  

      it "is invalid without a user_id" do
        message = build(:message, user: nil)
        message.valid?
        expect(message.errors[:user]).to include("を入力してください")
      end  

      it "is invalid without group_id" do
        message = build(:message, group: nil)
        message.valid?
        expect(message.errors[:group]).to include("を入力してください")
      end
    end
  end
end