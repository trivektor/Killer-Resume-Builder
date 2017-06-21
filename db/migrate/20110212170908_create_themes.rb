class CreateThemes < ActiveRecord::Migration
  def self.up
    create_table :themes do |t|
      t.string :theme
      t.string :slug
      t.string :style, :default => "1 column"
      t.string :style_slug, :default => "1_column"
      t.string :status, :default => :active
      t.boolean :default, :default => false
      t.timestamps
    end
    
    Theme.create :theme => "Black & White", :slug => "black_and_white"
    Theme.create :theme => "Orange", :slug => "orange"
    Theme.create :theme => "Orange Brick", :slug => "orange"
    Theme.create :theme => "Wooden", :slug => "wood", :style => "2 column", :style_slug => "2_column", :default => 1
    Theme.create :theme => "Classic Paper Stack", :slug => "classic_paper_stack"
    Theme.create :theme => "Black White Red", :slug => "bwr"
    Theme.create :theme => "Thin Beige", :slug => "thin_beige"
    
  end

  def self.down
    drop_table :themes
  end
end
