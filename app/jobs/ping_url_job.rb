class PingUrlJob < ApplicationJob
  queue_as :default

  def perform(monitored_url_id)
    monitored_url = MonitoredUrl.find(monitored_url_id)

    start_time = Time.now

    begin
      response = HTTParty.get(monitored_url.url)
      response_time = Time.now - start_time
      status = response.code == 200 ? "up" : "down"


      monitored_url.url_checks.create!({
        status: status,
        response_time: response_time,
        checked_at: start_time,
        error_message: status == "down" ? "HTTP #{response.code}" : nil
      })

      monitored_url.update(last_status: status, last_checked_at: start_time)

    rescue StandardError => e
      monitored_url.url_checks.create!({
        status: "down",
        response_time: nil,
        checked_at: start_time,
        error_message: e.message
      })

      Rails.logger.error "Ping failed for URL #{monitored_url.url}: #{e.message}"
    end

    monitored_url.update(last_status: status || "down", last_checked_at: start_time)
  end
end
