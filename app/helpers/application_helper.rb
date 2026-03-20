module ApplicationHelper
  def yen(amount)
    number_to_currency(amount, unit: "¥", format: "%u%n", precision: 0)
  end
end
