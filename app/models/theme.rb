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
  
end
