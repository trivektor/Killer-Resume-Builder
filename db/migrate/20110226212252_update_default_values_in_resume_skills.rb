class UpdateDefaultValuesInResumeSkills < ActiveRecord::Migration
  def self.up
    change_table :resume_skills do |t|
      t.change :skills, :text, :default => ""
      t.change :status, :string, :default => :active
    end
    
    skills = ResumeSkill.find(:all)
    
    skills.each do |s|
      s = ResumeSkill.find(s.id)
      s.update_attributes(:status => :active)
      if s.skills.nil?
        s.update_attributes(:skills => "")
      end
    end
  end

  def self.down
  end
end
