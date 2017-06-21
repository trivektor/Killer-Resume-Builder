class AddHideProfileNotificationToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :hide_profile_notification, :boolean, :default => false, :after => :completeness
  end

  def self.down
    remove_column :profiles, :hide_profile_notification
  end
end
