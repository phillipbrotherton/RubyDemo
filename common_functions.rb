#Common functions 

module CHWCommonFunctions
  
  def open_new_browser
    @browser=Watir::Browser.new:firefox
  end
  
  def open_url url
    @browser.goto url
  end
    
  def verify_page_contains text
    fail unless @browser.text.include? text
  end

  def close_the_browser 
    @browser.close
  end
  
  def delete_log_files
    #Deleting the old Log files
    if File.exists?("/Users/Sneha/RubyProjects/RubyAutomation/CHW_Automation.log")
      File.delete("CHW_Automation.log")
    end
    if File.exists?("/Users/Sneha/RubyProjects/RubyAutomation/CHW_Automation.pdf")
      File.delete("CHW_Automation.pdf")
    end
  end

end 