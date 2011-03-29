class ChangeReportedTypeInUserThreads < ActiveRecord::Migration
  def self.up
    change_table :user_threads do |t|
      t.remove_column :reported
      t.add_column :reported, :boolean, :default => false
    end
  end

  def self.down
  end
end
