class CreateBlogs < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.column :title, :string
      t.column :slug, :string
      t.column :summary, :text
      t.column :body, :text
      t.column :author, :string
      t.column :status, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :blogs
  end
end
