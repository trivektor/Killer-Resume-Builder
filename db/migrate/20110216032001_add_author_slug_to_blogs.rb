class AddAuthorSlugToBlogs < ActiveRecord::Migration
  def self.up
    change_table :blogs do |t|
      t.string :author_slug, :after => :author
    end
  end

  def self.down
    change_table :blogs do |t|
      remove_column :author_slug
    end
  end
end
