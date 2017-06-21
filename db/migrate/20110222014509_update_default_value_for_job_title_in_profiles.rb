class UpdateDefaultValueForJobTitleInProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.change :job_title, :string, :default => ""
    end
    
    profiles = Profile.find(:all)
    
    profiles.each do |p|
      p = Profile.find(p.id)
      p.update_attributes(:job_title => "")
    end
  end

  def self.down
  end
end
