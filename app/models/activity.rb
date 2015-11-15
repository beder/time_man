class Activity < ActiveRecord::Base
  scope :happened_after, lambda { |date_from|
    date_from ? where('date >= ?', date_from) : where({})
  }

  scope :happened_before, lambda { |date_to|
    date_to ? where('date <= ?', date_to) : where({})
  }
end
