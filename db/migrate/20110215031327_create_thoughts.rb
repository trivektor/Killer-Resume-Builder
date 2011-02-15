class CreateThoughts < ActiveRecord::Migration
  def self.up
    create_table :thoughts do |t|
      t.integer :user_id
      t.text :thought
      t.string :status, :default => :active
      t.timestamps
    end
  end

  def self.down
    drop_table :thoughts
  end
end
