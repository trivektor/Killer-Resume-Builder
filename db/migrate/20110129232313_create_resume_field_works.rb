class CreateResumeFieldWorks < ActiveRecord::Migration
  def self.up
    create_table :resume_field_works do |t|
      t.integer :resume_id
      t.text :field_works
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :resume_field_works
  end
end
