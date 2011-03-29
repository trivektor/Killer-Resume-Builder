class ChangeReportedTypeInUserThreads < ActiveRecord::Migration
  def self.up
    change_table :user_threads do |t|
      t.remove :reported
      t.boolean :reported, :default => false
    end
  end

  def self.down
  end
end
