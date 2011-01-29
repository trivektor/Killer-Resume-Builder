class CreateResumeEducations < ActiveRecord::Migration
  def self.up
    create_table :resume_educations do |t|
      t.integer :resume_id
      t.string :institution
      t.datetime :begin_date
      t.datetime :end_date
      t.string :degree
      t.string :field_of_study
      t.string :gpa
      t.string :location
      t.integer :weight
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :resume_educations
  end
end
