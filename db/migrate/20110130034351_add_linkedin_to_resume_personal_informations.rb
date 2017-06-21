class AddLinkedinToResumePersonalInformations < ActiveRecord::Migration
  def self.up
    add_column :resume_personal_informations, :linkedin, :string
  end

  def self.down
    remove_column :resume_personal_informations
  end
end
