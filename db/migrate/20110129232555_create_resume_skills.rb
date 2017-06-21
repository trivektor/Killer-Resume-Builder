class CreateResumeSkills < ActiveRecord::Migration
  def self.up
    create_table :resume_skills do |t|
      t.integer :resume_id
      t.text :skills
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :resume_skills
  end
end
