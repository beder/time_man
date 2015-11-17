class Activity < ActiveRecord::Base
  scope :happened_after, lambda { |date_from|
    date_from.present? ? where('date >= ?', date_from) : where({})
  }

  scope :happened_before, lambda { |date_to|
    date_to.present? ? where('date <= ?', date_to) : where({})
  }
end
