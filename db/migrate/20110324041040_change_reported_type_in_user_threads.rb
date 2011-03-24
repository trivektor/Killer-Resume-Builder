class ChangeReportedTypeInUserThreads < ActiveRecord::Migration
  def self.up
    change_table :user_threads do |t|
      t.change :reported, :boolean, :default => false
    end
  end

  def self.down
    change_table :user_threads do |t|
      t.change :reported, :integer, :default => 0
    end
  end
end
