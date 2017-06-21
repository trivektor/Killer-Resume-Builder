class UpdateDefaultForCompletenessInProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.change :completeness, :boolean, :default => false
    end
  end

  def self.down
  end
end
