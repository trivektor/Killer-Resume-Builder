class CreateResumeSectionOrders < ActiveRecord::Migration
  def self.up
    create_table :resume_section_orders do |t|
      t.integer :resume_id
      t.text :orders
      t.timestamps
    end
  end

  def self.down
    drop_table :resume_section_orders
  end
end
