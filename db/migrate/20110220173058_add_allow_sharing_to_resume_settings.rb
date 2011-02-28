class AddAllowSharingToResumeSettings < ActiveRecord::Migration
  def self.up
    add_column :resume_settings, :allow_sharing, :boolean, :default => true, :after => :show_last_updated
  end

  def self.down
    remove_column :resume_settings, :allow_sharing
  end
end
