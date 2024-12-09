class BlogPost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :description, presence: true
  validates :user, presence: true

  has_one_attached :picture

  validate :image_validation

  private

  def image_validation
    return unless picture.attached?

    if picture.byte_size < 2.megabytes || picture.byte_size > 8.megabytes
      errors.add(:picture, 'must be between 2MB and 8MB')
    end

    return if picture.content_type == 'image/jpeg'

    errors.add(:picture, 'must be a JPEG file')
  end
end
