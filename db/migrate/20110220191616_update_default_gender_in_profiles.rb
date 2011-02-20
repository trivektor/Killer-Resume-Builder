class UpdateDefaultGenderInProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.change :gender, :string, :default => "male"
    end
    
    profiles = Profile.find(:all)
    
    profiles.each do |p|
      p.update_attributes(:gender => "male")
    end
  end

  def self.down
    change_table :profiles do |t|
      t.change :gender, :string, :default => ""
    end
  end
end
