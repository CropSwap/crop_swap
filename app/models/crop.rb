class Crop < ActiveRecord::Base
  belongs_to :user
  belongs_to :crop_type

  has_and_belongs_to_many :swap_types
  has_many :wishlists
  has_many :swaps do
    def pending
      where(accepted: nil)
    end
    def accepted
      where(accepted: true)
    end
  end

  validates_presence_of :user_id, :description, :weight, :crop_type_id, :ripe_on, :expires_on

  has_attached_file :crop_pic
  validates_attachment_content_type :crop_pic, content_type: /\Aimage\/.*\Z/

  def self.available_crops(user)
    available_crops = Crop.where('expires_on >= ? AND user_id != ?', Date.today, user.id)
    available_crops.reject { |crop | crop.swaps.accepted == true }
    available_crops
  end
end
