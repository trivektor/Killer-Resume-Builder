class CreateResumeSettings < ActiveRecord::Migration
  def self.up
    create_table :resume_settings do |t|
      t.integer :resume_id
      t.string :status, :default => "active"
      t.boolean :hide_personal_info, :default => false
      t.boolean :alert_copy, :default => true
      t.boolean :email_notification, :default => true
      t.boolean :display_personal_photo, :default => true
      t.boolean :show_last_updated, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :resume_settings
  end
end
