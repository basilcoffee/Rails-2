class Room < ApplicationRecord
  validates :name, :introduction, :price, :address, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }

  belongs_to :user
  has_many :reservations
  has_one_attached :image
end
