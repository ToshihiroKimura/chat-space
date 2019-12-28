require 'rails_helper'
describe User do
  describe '#create' do
    context "can save" do
      it "is valid with a name, email, password, password_confirmation" do
        user = build(:user)
        user.valid?
        expect(user).to be_valid
      end
      
      it "is valid with a different name, email" do
        user1 = create(:user)
        user2 = build(:user, name: "fuga", email: "fuga@gmail.com")
        user2.valid?
        expect(user2).to be_valid
      end
    end
  
    context 'can not save' do
      it "is invalid without a name" do
        user = build(:user, name: nil)
        user.valid?
        expect(user.errors[:name]).to include("を入力してください")
      end  
      
      it "is invalid without a email" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end  
      
      it "is invalid with a duplicate name" do
        user1 = create(:user, name: "hoge")
        user2 = build(:user, name: "hoge")
        user2.valid?
        expect(user2.errors[:name]).to include("はすでに存在します")
      end
  
      it "is invalid with a duplicate email" do
        user1 = create(:user, email: "hogehoge@gmail.com" )
        user2 = build(:user, email: "hogehoge@gmail.com")
        user2.valid?
        expect(user2.errors[:email]).to include("はすでに存在します")
      end
    end
  end
end