class CreateResumePersonalInformations < ActiveRecord::Migration
  def self.up
    create_table :resume_personal_informations do |t|
      t.integer :resume_id
      t.string :full_name
      t.string :address
      t.string :city
      t.string :state
      t.string :postal_code
      t.integer :country
      t.string :fax_number
      t.string :email
      t.string :website
      t.string :facebook
      t.string :twitter
      t.string :flickr
      t.string :linked_in
      t.text :bio
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :resume_personal_informations
  end
end
