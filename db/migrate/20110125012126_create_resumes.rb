class CreateResumes < ActiveRecord::Migration
  def self.up
    create_table :resumes do |t|
      t.integer :user_id
      t.string :title
      t.string :url
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :resumes
  end
end
