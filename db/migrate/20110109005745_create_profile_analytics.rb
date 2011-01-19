class CreateProfileAnalytics < ActiveRecord::Migration
  def self.up
    create_table :profile_analytics do |t|
      
      t.timestamps
    end
  end

  def self.down
    drop_table :profile_analytics
  end
end
