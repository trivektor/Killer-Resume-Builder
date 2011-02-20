class CreateVisitorInfos < ActiveRecord::Migration
  def self.up
    create_table :visitor_infos do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :visitor_infos
  end
end
