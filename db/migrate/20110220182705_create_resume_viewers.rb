class CreateResumeViewers < ActiveRecord::Migration
  def self.up
    create_table :resume_viewers do |t|
      t.integer :resume_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :resume_viewers
  end
end
