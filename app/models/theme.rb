class Theme < ActiveRecord::Base
  
  def self.default_theme
    begin
      default = Theme.where(:default => 1, :status => :active).first
      
      if default
        default
      else
        self.first
      end
      
    rescue
      self.first
    end
  end
  
  def self.get_all_themes
    themes = Theme.where(:status => :active).find(:all)
    themes_hash = {}
    
    for theme in themes
      themes_hash[theme.theme] = theme.id
    end
    
    themes_hash
  end
  
end
