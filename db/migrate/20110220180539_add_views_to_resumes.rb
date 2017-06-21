class AddViewsToResumes < ActiveRecord::Migration
  def self.up
    add_column :resumes, :views, :integer, :default => 0, :after => :status
  end

  def self.down
    remove_column :resumes, :views
  end
end
