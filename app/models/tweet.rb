class Tweet < ApplicationRecord
  belongs_to :user
  has_one_attached :media

  validates :content, presence: true, length: { maximum: 270 }
end
