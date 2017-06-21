class CreateResumeKeywords < ActiveRecord::Migration
  def self.up
    create_table :resume_keywords do |t|
      t.integer :resume_id
      t.text :keywords
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :resume_keywords
  end
end
