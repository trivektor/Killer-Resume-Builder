class UpdateDefaultValuesInProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.change :city, :string, :default => ""
      t.change :state, :string, :default => ""
      t.change :country_id, :integer, :default => 0
      t.change :postal_code, :string, :default => ""
      t.change :job_category_id, :integer, :default => 0
      t.change :job_industry_id, :integer, :default => 0
      t.change :website, :string, :default => ""
      t.change :looking_for, :string, :default => ""
    end
    
    profiles = Profile.find(:all)
    
    profiles.each do |p|
      p = Profile.find(p.id)
      p.update_attributes(:job_category_id => 0, :job_industry_id => 0, :website => "", :looking_for => "")
      if p.city.nil?
        p.update_attributes(:city => "")
      end
      
      if p.state.nil?
        p.update_attributes(:state => "")
      end
      
      if p.postal_code.nil?
        p.update_attributes(:postal_code => "")
      end
      
      if p.country_id.nil?
        p.update_attributes(:country_id => 0)
      end
    end
    
  end

  def self.down
  end
end
