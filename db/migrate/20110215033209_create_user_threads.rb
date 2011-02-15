class CreateUserThreads < ActiveRecord::Migration
  def self.up
    create_table :user_threads do |t|
      t.integer :user_id
      t.integer :target_id
      t.string :thread_type, :default => :profile
      t.text :content
      t.string :status, :default => :active
      t.integer :private, :default => 0
      t.integer :reported, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :user_threads
  end
end
