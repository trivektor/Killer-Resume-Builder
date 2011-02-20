class CreateTableVisitorInfos < ActiveRecord::Migration
  def self.up
    create_table :visitor_infos do |t|
      t.integer :resume_id
      t.string :browser, :default => ""
      t.string :version, :default => ""
      t.string :platform, :default => ""
      t.string :domain_name, :default => ""
      t.string :ip_address, :default => ""
      t.timestamps
    end
  end

  def self.down
    drop_table :visitor_infos
  end
end
