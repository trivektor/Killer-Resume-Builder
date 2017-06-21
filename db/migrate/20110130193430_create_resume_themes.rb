class CreateResumeThemes < ActiveRecord::Migration
  def self.up
    create_table :resume_themes do |t|
      t.integer :resume_id
      t.integer :theme_id
      t.timestamps
    end
  end

  def self.down
    drop_table :resume_themes
  end
end
