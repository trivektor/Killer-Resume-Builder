class DataFile < ActiveRecord::Base
  
  def self.save(upload)
    name = upload['datafile'].original_filename
    
    name = name.gsub(" ", "_")
    
    directory  = "public/images/uploads"
    
    path = File.join(directory, name)
    
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
    
    image = MiniMagick::Image.from_file("public/images/uploads/#{name}")
    image.resize("600x400")
    image.write("public/images/uploads/test.png") 
    #image.save()
    
    name
    
  end
  
end
