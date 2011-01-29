class CreateResumeReferences < ActiveRecord::Migration
  def self.up
    create_table :resume_references do |t|
      t.integer :resume_id
      t.string :name
      t.string :title
      t.string :organization
      t.string :department
      t.string :address
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country
      t.string :phone_number
      t.string :fax_number
      t.string :email
      t.string :website
      t.text :details
      t.integer :weight
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :resume_references
  end
end
