class UpdateDefaultValuesForHiddenStatusCompletenessInProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.change :hidden, :boolean, :default => false
      t.change :status, :string, :default => :active
      t.change :completeness, :boolean, :default => 0
    end
    
    profiles = Profile.find(:all)
    
    profiles.each do |p|
      p = Profile.find(p.id)
      p.update_attributes(:hidden => 0)
      p.update_attributes(:status => :active)
      p.update_attributes(:completeness => 0)
    end
  end

  def self.down
  end
end
