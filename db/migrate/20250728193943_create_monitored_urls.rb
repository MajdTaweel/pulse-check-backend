class CreateMonitoredUrls < ActiveRecord::Migration[8.0]
  def change
    create_table :monitored_urls do |t|
      t.string :url, null: false
      t.string :name, null: false
      t.integer :check_interval, null: false
      t.datetime :last_checked_at
      t.string :last_status, null: false, default: "pending"

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :monitored_urls, [ :user_id, :url ], unique: true
  end
end
