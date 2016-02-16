require 'rails_helper'

RSpec.describe Crop, type: :model do
  let(:user) { create(:user) }
  let(:crop) { create(:crop, user: user, ripe_on: Date.today - 2.days, expires_on: Date.today + 20.days) }
  let(:crop2) { create(:crop, user: user, ripe_on: Date.today + 5.days, expires_on: Date.today + 30.days) }
  let(:crop3) { create(:crop, user: user, expires_on: Date.today + 2.days) }
  let(:trade) { create(:trade, crop: crop, accepted: nil) }
  let(:trade2) { create(:trade, crop: crop, accepted: true) }

  describe "validations" do
    it "must have user_id to be valid" do
      expect(build(:crop, user_id: nil)).to_not be_valid
    end

    it "must have description to be valid" do
      expect(build(:crop, description: "")).to_not be_valid
    end

    it "must have weight to be valid" do
      expect(build(:crop, weight: "")).to_not be_valid
    end

    it "must have crop type to be valid" do
      expect(build(:crop, crop_type_id: nil)).to_not be_valid
    end

    it "must have ripe on date to be valid" do
      expect(build(:crop, ripe_on: "")).to_not be_valid
    end

    it "must have expiry date to be valid" do
      expect(build(:crop, expires_on: "")).to_not be_valid
    end
  end

  describe "trades pending" do
    it "returns trades that are not yet accepted or rejected" do
      expect(crop.trades.pending).to eq [trade]
    end
  end

  describe "trades accepted" do
    it "returns trades that are accepted" do
      expect(crop.trades.accepted).to eq [trade2]
    end
  end

  describe "#is_ripe" do
    it "returns true if a crop is ripe and not yet expired" do
      expect(crop.is_ripe?).to eq true
      expect(crop2.is_ripe?).to eq false
    end
  end

  describe "#about_to_expire" do
    it "returns true if a crop is 3 days or less from expiring" do
      expect(crop2.about_to_expire?).to eq false
      expect(crop3.about_to_expire?).to eq true
    end
  end

  describe ".available_crops" do
    it "returns all crops that are currently available" do
      expect(Crop.available_crops(user)).to eq [crop2, crop3]
    end
  end
end
#
# def self.available_crops(user)
#   available_crops = Crop.where('expires_on >= ? AND user_id != ?', Date.today, user.id)
#   available_crops.reject { |crop | crop.trades.accepted == true }
#   available_crops
# end
