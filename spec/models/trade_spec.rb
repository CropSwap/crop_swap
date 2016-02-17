require 'rails_helper'

RSpec.describe Trade, type: :model do
  let(:user) { create(:user) }
  let(:user2) { create(:user, email: "consumer1@mail.com") }
  let(:user3) { create(:user, email: "consumer2@mail.com") }
  let(:crop) { create(:crop, user: user) }
  let(:trade) { create(:trade, crop: crop, consumer: user2, accepted: true) }
  let(:trade2) { create(:trade, crop: crop, consumer: user3) }
  let(:trade3) { create(:trade, crop: crop, consumer: user2, accepted: false) }

  describe "#reject!" do
    it "marked the trade as rejected" do
      trade.reject!
      expect(trade.accepted).to eq false
    end
  end

  describe "#reject_other_trades" do
    it "marks all other trades as rejected when one is accepted" do
      t1 = FactoryGirl.create(:trade, crop: crop, consumer: user2)
      t2 = FactoryGirl.create(:trade, crop: crop, consumer: user3)
      t1.accepted = true
      t1.save
      t2.reload
      expect(t2.accepted).to eq false
      expect(t2.message_response). to eq "Sorry - another swap was chosen this time."
    end
  end

  describe ".user_has_accepted_trades" do
    it "returns true if user has accepted trades" do
      trade.reload
      expect(Trade.all.user_has_accepted_trades?).to eq true
    end
  end

  describe ".user_has_rejected_trades" do
    it "returns true if user has rejected trades" do
      trade3.reload
      expect(Trade.all.user_has_rejected_trades?).to eq true
    end
  end
end