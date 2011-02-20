module EmailHelper
  
  
  def string_to_ascii(string)
		
		asciiString = "";

		string.each_byte do |c|
		  asciiString += "&##{c};"
	  end

		asciiString
	end
	
	def obfuscate_email(email)
	  
		email_obfuscated = string_to_ascii (email)
		
		email_obfuscated = '<script type="text/javascript">document.write("<a hr"+"ef=&#109;&#97;&#105;&#108;&#116;&#111;&#58;");document.write("' + email_obfuscated + '>' + email_obfuscated + '</a>");</script>'
	
    email_obfuscated.html_safe
	end
  
  
  
end