class MonitoredUrl < ApplicationRecord
  belongs_to :user

  validates :url,
    presence: true,
    format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid HTTP/HTTPS URL" },
    uniqueness: { scope: :user_id }

  validates :name,
    presence: true,
    length: { maximum: 100 }

  validates :check_interval,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 15,
      less_than_or_equal_to: 3600
    }

  STATUSES = %w[pending up down].freeze

  validates :last_status,
    presence: true,
    inclusion: { in: STATUSES }

  validate :last_checked_at_required_if_checked

  private

  def last_checked_at_required_if_checked
    if last_status != "pending" && last_checked_at.blank?
      errors.add(:last_checked_at, "must be set if status is not pending")
    end
  end
end
