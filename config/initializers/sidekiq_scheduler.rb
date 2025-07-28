require "sidekiq-scheduler"

Sidekiq.configure_server do |config|
  config.on(:startup) do
    schedule_file = Rails.root.join("config/sidekiq.yml")

    if File.exist?(schedule_file)
      schedule = YAML.load_file(schedule_file)
      Sidekiq::Scheduler.dynamic = false
      Sidekiq.schedule = schedule[:schedule] || schedule["schedule"]
      Sidekiq::Scheduler.reload_schedule!
    end
  end
end
