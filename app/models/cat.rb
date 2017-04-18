class Cat < ApplicationRecord
  validates :birth_date, :color, :name, :sex, presence: true
  validates :color, inclusion: { in: %w(black white grey orange blue) }
  validates :sex, inclusion: { in: %w(M F) }

  has_many :cat_rental_requests,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: 'CatRentalRequest'

  
end
