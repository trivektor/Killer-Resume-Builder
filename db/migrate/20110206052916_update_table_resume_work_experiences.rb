class UpdateTableResumeWorkExperiences < ActiveRecord::Migration
  def self.up
    change_table :resume_work_experiences do |t|
      t.change :begin_date, :string
      t.change :end_date, :string
    end
  end

  def self.down
    change_table :resume_work_experiences do |t|
      t.change :begin_date, :string
      t.change :end_date, :string
    end
  end
end
