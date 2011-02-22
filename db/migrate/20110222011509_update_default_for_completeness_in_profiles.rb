class UpdateDefaultForCompletenessInProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.change :completeness, :boolean, :default => 0
    end
  end

  def self.down
  end
end
