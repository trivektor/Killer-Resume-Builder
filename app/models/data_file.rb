class DataFile < ActiveRecord::Base
  
  def self.save(upload)
    name = upload['datafile'].original_filename
    
    name = name.gsub(" ", "_")
    
    directory  = "public/images/upload"
    
    path = File.join(directory, name)
    
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
    
    ext = File.extname("public/images/upload/#{name}")
    
    image = MiniMagick::Image.from_file("public/images/upload/#{name}")
    #image.resize "500x500>"
    image.resize "120x120"
    image.gravity "center"
    image.write("public/images/upload/#{name}")
    
    name
    
  end
  
end
