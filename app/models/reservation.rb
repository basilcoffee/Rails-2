class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in, :check_out, :people, presence: true
  validates :people, numericality: { greater_than: 0 }
  validate :check_out_after_check_in

  def days
    return 0 if check_in.blank? || check_out.blank?
    (check_out - check_in).to_i
  end

  def total_price
    return 0 if room.blank?
    room.price * people * days
  end

  private

  def check_out_after_check_in
    return if check_in.blank? || check_out.blank?

    if check_out <= check_in
      errors.add(:check_out, "はチェックインより後の日付にしてください")
    end
  end
end
