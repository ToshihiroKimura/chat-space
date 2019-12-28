require 'rails_helper'
describe Group do
  describe '#create' do
    context 'can save' do
      it "is valid with a name" do
        group = build(:group)
        group.valid?
        expect(group).to be_valid
      end
    end

    context 'can not save' do
      it "is invalid without a name" do
        group = build(:group, name: nil)
        group.valid?
        expect(group.errors[:name]).to include("を入力してください")
      end  
    end
  end
end