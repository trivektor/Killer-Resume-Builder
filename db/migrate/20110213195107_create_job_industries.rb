class CreateJobIndustries < ActiveRecord::Migration
  def self.up
    create_table :job_industries do |t|
      t.string :industry
      t.string :status, :default => :active
      t.timestamps
    end
    
    JobIndustry.create(:industry => "Accounting")
    JobIndustry.create(:industry => "Airlines/Aviation")
    JobIndustry.create(:industry => "Apparel & Planning")
    JobIndustry.create(:industry => "Aerospace")
    JobIndustry.create(:industry => "Banking")
    JobIndustry.create(:industry => "Biotechnology")
    JobIndustry.create(:industry => "Broadcast Media")
    JobIndustry.create(:industry => "Chemicals")
    JobIndustry.create(:industry => "Civil Engineering")
    JobIndustry.create(:industry => "Commercial Real Estate")
    JobIndustry.create(:industry => "Computer & Network Security")
    JobIndustry.create(:industry => "Computer Hardware")
    JobIndustry.create(:industry => "Computer Networking")
    JobIndustry.create(:industry => "Computer Software")
    JobIndustry.create(:industry => "Construction")
    JobIndustry.create(:industry => "Consumer Electronics")
    JobIndustry.create(:industry => "Consumer Services")
    JobIndustry.create(:industry => "Design")
    JobIndustry.create(:industry => "Education Management")
    JobIndustry.create(:industry => "Entertainment")
    JobIndustry.create(:industry => "Environmental Sciences")
    JobIndustry.create(:industry => "Events Services")
    JobIndustry.create(:industry => "Executive Office")
    JobIndustry.create(:industry => "Farming")
    JobIndustry.create(:industry => "Fine Art")
    JobIndustry.create(:industry => "Food & Beverages")
    JobIndustry.create(:industry => "Fundraising")
    JobIndustry.create(:industry => "Government Administration")
    JobIndustry.create(:industry => "Graphic Design")
    JobIndustry.create(:industry => "Health Wellness and Fitness")
    JobIndustry.create(:industry => "Higher Education")
    JobIndustry.create(:industry => "Hospitality")
    JobIndustry.create(:industry => "Human Resources")
    JobIndustry.create(:industry => "Import & Export")
    JobIndustry.create(:industry => "Industrial Automation")
    JobIndustry.create(:industry => "Information Services")
    JobIndustry.create(:industry => "Information Technology Services")
    JobIndustry.create(:industry => "Insurance")
    JobIndustry.create(:industry => "International Affairs")
    JobIndustry.create(:industry => "Internet")
    JobIndustry.create(:industry => "Investment Banking")
    JobIndustry.create(:industry => "Investment Management")
    JobIndustry.create(:industry => "Legal Services")
    JobIndustry.create(:industry => "Legislative Offices")
    JobIndustry.create(:industry => "Libraries")
    JobIndustry.create(:industry => "Logistics")
    JobIndustry.create(:industry => "Market Research")
    JobIndustry.create(:industry => "Mechanical or Industrial Engineering")
    JobIndustry.create(:industry => "Media Production")
    JobIndustry.create(:industry => "Mental Health Care")
  end

  def self.down
    drop_table :job_industries
  end
end
