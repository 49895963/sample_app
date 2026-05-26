class Micropost < ApplicationRecord

  scope :search, ->(keyword) {
    if keyword.present?
      escaped_keyword = sanitize_sql_like(keyword.to_s.downcase)
      where("LOWER(content) LIKE :keyword", keyword: "%#{escaped_keyword}%")
    else
      all
    end
  }
  belongs_to :user
  has_many :reactions, dependent: :destroy
  has_many :reacting_users, through: :reactions, source: :user
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :acceptable_image
  private

    def acceptable_image
      return unless image.attached?

      unless image.blob.byte_size <= 5.megabytes
        errors.add(:image, "は5MB未満にしてください")
      end

      acceptable_types = ["image/jpeg", "image/gif", "image/png"]
      unless acceptable_types.include?(image.content_type)
        errors.add(:image, "はJPEG、GIF、PNG形式にしてください")
      end
    end
end
