class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :acceptable_image
  private

    def acceptable_image
      return unless image.attached?

      unless image.blob.byte_size <= 5.megabytes
        errors.add(:image, "should be less than 5MB")
      end

      acceptable_types = ["image/jpeg", "image/gif", "image/png"]
      unless acceptable_types.include?(image.content_type)
        errors.add(:image, "must be a JPEG, GIF, or PNG")
      end
    end
end
