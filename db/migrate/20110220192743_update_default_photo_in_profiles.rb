class UpdateDefaultPhotoInProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.change :gender, :string, :default => "male.png"
    end
    
    profiles = Profile.find(:all)
    
    profiles.each do |p|
      if p.photo.nil? || p.photo.empty?
        p.update_attributes(:photo => "male.png")
      end
    end
  end

  def self.down
    change_table :profiles do |t|
      t.change :gender, :string, :default => ""
    end
  end
end
