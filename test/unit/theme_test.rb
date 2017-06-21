require 'test_helper'

class ThemeTest < ActiveSupport::TestCase
  
  test "select default theme if available" do
      
      Theme.create(:theme => "Default Theme Name", :slug => "default_theme_slug", :default => 1)
      
      default = Theme.default_theme
      
      assert_equal "Default Theme Name", default.theme
      assert_equal "default_theme_slug", default.slug
      
      assert_equal true, default.default
  end
  
  test "select first theme if no default theme is available" do
      
      Theme.create(:theme => "Theme 1", :slug => "theme_1_slug", :default => 0)
      
      Theme.create(:theme => "Theme 2", :slug => "theme_2_slug", :default => 0)
        
      d = Theme.default_theme
      
      assert_equal "Theme 1", d.theme
      assert_equal "theme_1_slug", d.slug
        
  end
      
end
