class AddPhoneNumberToResumePersonalInformations < ActiveRecord::Migration
  def self.up
    add_column :resume_personal_informations, :phone_number, :string
  end

  def self.down
    remove_column :resume_personal_informations, :phone_number
  end
end
