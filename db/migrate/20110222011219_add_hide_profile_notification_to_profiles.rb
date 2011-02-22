class AddHideProfileNotificationToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :hide_profile_notification, :boolean, :default => 0, :after => :completeness
  end

  def self.down
    remove_column :profiles, :hide_profile_notification
  end
end
