class UpdateTableResumeEducation < ActiveRecord::Migration
  def self.up
    change_table :resume_educations do |t|
      t.change :begin_date, :string
      t.change :end_date, :string
    end
  end

  def self.down
    change_table :resume_educations do |t|
      t.change :begin_date, :datetime
      t.change :end_date, :datetime
    end
  end
end
