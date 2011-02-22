class UpdateDefaultValuesForFirstNameAndLastNameInProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.change :first_name, :string, :default => ""
      t.change :last_name, :string, :default => ""
    end
    
    profiles = Profile.find(:all)
    
    profiles.each do |p|
      p = Profile.find(p.id)
      p.update_attributes(:first_name => "", :last_name => "")
    end
  end

  def self.down
  end
end
