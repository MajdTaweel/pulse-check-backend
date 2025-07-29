class MonitoredUrl < ApplicationRecord
  belongs_to :user
  has_many :url_checks, dependent: :destroy

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
      greater_than_or_equal_to: 30,
      less_than_or_equal_to: 3600
    }

  STATUSES = %w[pending up down].freeze

  validates :last_status,
    presence: true,
    inclusion: { in: STATUSES }

  validate :last_checked_at_required_if_checked

  def due_for_check?
    last_checked_at.nil? || Time.current - last_checked_at >= check_interval
  end

  def as_json(options = {})
    super(options).merge(
      uptime: uptime_summary
    )
  end

  private

  def uptime_summary
    {
      last_24h: uptime_percentage(duration: 24.hours),
      last_7d: uptime_percentage(duration: 7.days)
    }
  end

  def uptime_percentage(duration:)
    from_time = Time.now - duration

    checks = url_checks.where("checked_at >= ?", from_time)
    return nil if checks.empty?

    up_count = checks.where(status: "up").count
    total = checks.count

    (up_count.to_f / total * 100).round(2)
  end

  def last_checked_at_required_if_checked
    if last_status != "pending" && last_checked_at.blank?
      errors.add(:last_checked_at, "must be set if status is not pending")
    end
  end
end
