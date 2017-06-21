class AddGithubToResumePersonalInformations < ActiveRecord::Migration
  def self.up
    add_column :resume_personal_informations,  :github, :string, :after => :linked_in
  end

  def self.down
    remove_column :resume_personal_informations, :github
  end
end
