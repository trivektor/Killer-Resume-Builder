class UpdateDefaultValuesInResumeWorkExperiences < ActiveRecord::Migration
  def self.up
    change_table :resume_work_experiences do |t|
      t.change :weight, :integer, :default => 0
      t.change :status, :string, :default => :active
    end
    
    work_experiences = ResumeWorkExperience.find(:all)
    
    work_experiences.each do |w|
      w = ResumeWorkExperience.find(w.id)
      w.update_attributes(:status => :active)
      
      if w.weight.nil?
        w.update_attributes(:weight => 0)
      end
    end
    
  end

  def self.down
  end
end
