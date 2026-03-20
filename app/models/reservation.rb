class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in, :check_out, :people, presence: true
  validates :people, numericality: { only_integer: true, greater_than: 0 }
  validate :check_out_after_check_in
  validate :check_in_not_in_past

  def days
    return 0 if check_in.blank? || check_out.blank?
    (check_out - check_in).to_i
  end

  def total_price
    return 0 unless room && people && days > 0
    room.price.to_i * people.to_i * days
  end

  private

  def check_out_after_check_in
    return if check_in.blank? || check_out.blank?

    if check_out <= check_in
      errors.add(:check_out, "はチェックインより後の日付にしてください")
    end
  end

  def check_in_not_in_past
    return if check_in.blank?

    if check_in < Date.today
      errors.add(:check_in, "は今日以降の日付にしてください")
    end
  end
end
