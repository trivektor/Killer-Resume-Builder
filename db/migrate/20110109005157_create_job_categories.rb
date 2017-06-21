class CreateJobCategories < ActiveRecord::Migration
  def self.up
    create_table :job_categories do |t|
      t.string :category_name
      t.string :status, :default => :active
      t.timestamps
    end
    
    JobCategory.create (:category_name => "Accounting")
    JobCategory.create (:category_name => "Admin & Clerical")
    JobCategory.create (:category_name => "Banking & Finance")
    JobCategory.create (:category_name => "Customer Service")
    JobCategory.create (:category_name => "Engineering")
    JobCategory.create (:category_name => "Government")
    JobCategory.create (:category_name => "Health Care")
    JobCategory.create (:category_name => "Human Resources")
    JobCategory.create (:category_name => "Hospitality")
    JobCategory.create (:category_name => "Information Technology")
    JobCategory.create (:category_name => "Sales & Marketing")
    JobCategory.create (:category_name => "Science & Biotech")
    JobCategory.create (:category_name => "Transportation")
    JobCategory.create (:category_name => "Telecommunications")
    JobCategory.create (:category_name => "Restaurant")
    JobCategory.create (:category_name => "Real Estate")
    JobCategory.create (:category_name => "Management")
    JobCategory.create (:category_name => "Insurance")
  end

  def self.down
    drop_table :job_categories
  end
end
