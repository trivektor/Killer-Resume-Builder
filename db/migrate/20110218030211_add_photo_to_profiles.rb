class AddPhotoToProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.string :photo, :default => "", :after => :hidden
    end
  end

  def self.down
    change_table :profiles do |t|
      remove_column :photo
    end
  end
end
