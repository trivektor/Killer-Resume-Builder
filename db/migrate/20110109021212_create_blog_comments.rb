class CreateBlogComments < ActiveRecord::Migration
  def self.up
    create_table :blog_comments do |t|
      t.column :blog_id, :integer
      t.column :user_id, :integer
      t.column :name, :string
      t.column :website, :string
      t.column :comment, :text
      t.column :reported, :boolean
      t.timestamps
    end
  end

  def self.down
    drop_table :blog_comments
  end
end
