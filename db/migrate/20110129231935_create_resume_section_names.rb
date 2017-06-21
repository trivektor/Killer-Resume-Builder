class CreateResumeSectionNames < ActiveRecord::Migration
  def self.up
    create_table :resume_section_names do |t|
      t.integer :resume_id
      t.string :section
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :resume_section_names
  end
end
