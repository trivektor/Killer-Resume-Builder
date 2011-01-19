class CreateJobCategories < ActiveRecord::Migration
  def self.up
    create_table :job_categories do |t|
      t.string :category_name
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :job_categories
  end
end
