class UpdateDefaultForGenderAndPhotoInProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.change :gender, :string, :default => :male
      t.change :photo, :string, :default => "male.png"
    end
    
    profiles = Profile.find(:all)
    
    profiles.each do |p|
      p = Profile.find(p.id)
      p.update_attributes(:gender => :male)
      if (p.photo.empty?)
        p.update_attributes(:photo => "male.png")
      end
    end
    
  end

  def self.down
  end
end
