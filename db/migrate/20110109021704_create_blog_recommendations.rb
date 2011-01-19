class CreateBlogRecommendations < ActiveRecord::Migration
  def self.up
    create_table :blog_recommendations do |t|
      t.column :blog_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :blog_recommendations
  end
end
