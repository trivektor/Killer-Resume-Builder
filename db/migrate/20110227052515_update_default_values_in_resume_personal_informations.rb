class UpdateDefaultValuesInResumePersonalInformations < ActiveRecord::Migration
  def self.up
    change_table :resume_personal_informations do |t|
      t.change :status, :string, :default => :active
    end
    
    personal_informations = ResumePersonalInformation.find(:all)
    personal_informations.each do |p|
      p = ResumePersonalInformation.find(p.id)
      p.update_attributes(:status => :active)
    end
  end

  def self.down
  end
end
