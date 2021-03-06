class CatRentalRequest < ApplicationRecord
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED) }
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validate :does_not_overlap_approved_request


  belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: 'Cat',
    dependent: :destroy

  def approve!
    raise "not currently pending" unless self.status == "PENDING"
    transaction do
      self.status = "APPROVED"
      self.save!
      overlapping_pending_requests.update_all(status: "DENIED")
    end
  end

  def deny!
    self.status = 'DENIED'
    self.save!
  end

  def overlapping_pending_requests
    overlapping_requests.where("status = 'PENDING'")
  end

  # private
  def overlapping_requests
    CatRentalRequest
      .where.not(id: self.id)
      .where(cat_id: cat_id)
      .where(<<-SQL, start_date: start_date, end_date: end_date)
        NOT( (start_date > :end_date) OR (end_date < :start_date) )
    SQL

  end

  def overlapping_approved_requests
    overlapping_requests.where("status = 'APPROVED'")
  end

  def does_not_overlap_approved_request
    unless overlapping_approved_requests.empty?
      errors[:base] << "Request conflicts with existing approved request"
    end
  end

end
