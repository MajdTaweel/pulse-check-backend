class CreateUrlChecks < ActiveRecord::Migration[8.0]
  def change
    create_table :url_checks do |t|
      t.references :monitored_url, null: false, foreign_key: true
      t.string :status, null: false
      t.float :response_time
      t.string :error_message
      t.datetime :checked_at, null: false

      t.index [ :monitored_url_id, :checked_at ]
    end
  end
end
