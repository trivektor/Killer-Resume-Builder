class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :state
      t.integer :country_id
      t.string :postal_code
      t.integer :job_category_id
      t.integer :job_industry_id
      t.string :job_title
      t.string :website
      t.string :gender
      t.text :looking_for
      t.boolean :hidden
      t.string :status
      t.boolean :completeness
      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
