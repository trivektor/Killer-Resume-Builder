class DataFile < ActiveRecord::Base
  
  def self.save(upload)
    name = upload['datafile'].original_filename
    
    name = name.gsub(" ", "_")
    
    directory  = "public/images/uploads"
    
    path = File.join(directory, name)
    
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
    
    name
    
  end
  
end
