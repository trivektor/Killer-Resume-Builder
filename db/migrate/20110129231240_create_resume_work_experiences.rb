class CreateResumeWorkExperiences < ActiveRecord::Migration
  def self.up
    create_table :resume_work_experiences do |t|
      t.integer :resume_id
      t.string :organization_name
      t.datetime :begin_date
      t.datetime :end_date
      t.string :title
      t.text :details
      t.integer :weight
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :resume_work_experiences
  end
end
