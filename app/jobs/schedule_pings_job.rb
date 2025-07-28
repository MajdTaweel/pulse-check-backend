class SchedulePingsJob < ApplicationJob
  queue_as :default

  def perform
    MonitoredUrl.find_each do |url|
      PingUrlJob.perform_later(url.id) if url.due_for_check?
    end
  end
end
