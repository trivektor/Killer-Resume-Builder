class CreateBlogTags < ActiveRecord::Migration
  def self.up
    create_table :blog_tags do |t|
      t.column :blog_id, :integer
      t.column :tag, :string
    end
  end

  def self.down
    drop_table :blog_tags
  end
end
