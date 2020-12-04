class CreateDownloads < ActiveRecord::Migration[6.0]
  def change
    create_table :downloads do |t|
      t.string :url, null: false
      t.string :status, null: false, default: "initial"
      t.string :http_username
      t.string :http_password
      t.datetime :queued_at
      t.datetime :started_at
      t.datetime :finished_at
      t.text :error
      t.datetime :cancelled_at
      t.string :file_filter
      t.boolean :audio_only, null: false, default: false
      t.string :audio_format, null: false, default: "mp3"
      t.boolean :download_subs, null: false, default: false
      t.boolean :srt_subs, null: false, default: false

      t.timestamps
    end
  end
end
