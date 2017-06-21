class UpdateDefaultValuesInResumeFieldWorks < ActiveRecord::Migration
  def self.up
    change_table :resume_field_works do |t|
      t.change :field_works, :text, :default => ""
      t.change :status, :string, :default => :active
    end
    
    field_works = ResumeFieldWork.find(:all)
    
    field_works.each do |fw|
      fw = ResumeFieldWork.find(fw.id)
      fw.update_attributes(:status => :active)
      if fw.field_works.nil?
        fw.update_attributes(:field_works => "")
      end
    end
    
  end

  def self.down
  end
end
