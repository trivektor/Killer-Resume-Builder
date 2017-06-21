class CreateResumeHiddenFields < ActiveRecord::Migration
  def self.up
    create_table :resume_hidden_fields do |t|
      t.integer :resume_id
      t.string :hidden_field
      t.timestamps
    end
  end

  def self.down
    drop_table :resume_hidden_fields
  end
end
