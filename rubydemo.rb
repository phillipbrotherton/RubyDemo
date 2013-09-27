#MyVanilla Ruby - CHW - Automation Driver Script
#Developed by Raghuram Pulijala
#File : rubytest.rb

require 'rubygems'                  # For Ruby Scripting
require 'watir-webdriver'           # For driving Web Browsers
require 'terminal-notifier'         # For Run Time pop up notifications
require 'logger'                    # For Log File
require 'prawn'                     # For PDF Report
require 'spreadsheet'               # For using as Input File - Data Driven
require 'pony'                      # For handling smtp mail server
require_relative 'common_functions' # For reusing Common Functions
require 'date'                    
require 'time'

#Using Common Functions
include CHWCommonFunctions

#Create an array of Browsers
  browsers = ["chrome","ff","safari"]

#MyVanilla URL
  url = "https://www.myvanilladebitcard.com"

#Function to delete log files
  delete_log_files 

#Using Log File
  $LOG = Logger.new('CHW_Automation.log') 

#Using PDF
  pdf = Prawn::Document.new

#Write to PDF
  pdf.font "Helvetica"
  pdf.define_grid(:columns => 5, :rows => 15, :gutter => 10) 
  pdf.grid([0,0], [1,1]).bounding_box do 
    pdf.text "MyVanilla CHW Automation - Results", :size => 18
    pdf.move_down 10
    pdf.text "Date: #{Date.today.to_s}", :align => :left  
  end
  pdf.grid([0,3.6], [1,4]).bounding_box do 
    # Assign the path to your file name first to a local variable.
    logo_path = File.expand_path('/Users/Sneha/RubyProjects/RubyAutomation/myvanilla.png', __FILE__)

    # Displays the image in your PDF. Dimensions are optional.
    pdf.image logo_path, :width => 150, :height => 45, :position => :left
  end
  pdf.text "Logger Details of Ruby Automation Script", :style => :bold_italic
  pdf.stroke_horizontal_rule
  pdf.move_down 10
  pdf.text "Source Code in GitHub at - <b><u><color rgb='2554C7'>https://github.com/rpulijala/RubyDemo</color></u></b>", :style => :italic, :inline_format => true
  pdf.move_down 10
  pdf.text "Ruby - MyVanilla CHW Automation script execution started", :style => :bold_italic
  pdf.move_down 10

browsers.each do |browser_new| 
  $LOG.info "********************  MyVanilla CHW - #{browser_new} - Start Execution **************************" 
    pdf.move_down 30
    pdf.stroke_horizontal_rule
    pdf.move_down 5
    pdf.text "Browser - #{browser_new}", :style => :bold_italic
    pdf.move_down 5
    pdf.stroke_horizontal_rule
    
    pdf.move_down 20
    pdf.text "#{Time.now} : MyVanilla - #{browser_new} - Ruby Automation Script - Start Execution"

  #Using Terminal Notifier
    
    TerminalNotifier.notify "MyVanilla CHW - #{browser_new} - Start Execution", title: "MyVanilla-#{browser_new}-Execution"
    sleep 2
  #Using TestData.xls to fetch Id,pwd
    $LOG.info "Entering into - 'Create Excel object' .. " 
    pdf.text "#{Time.now} : Entering into - 'Create Excel object' .. " 
    TerminalNotifier.notify "Creating Excel Object", title: "MyVanilla-#{browser_new}-Execution"
    sleep 2
    excel_file = File.join(File.dirname(__FILE__), "", "testdata.xls") 
    excel_book = Spreadsheet.open excel_file
    sheet1 = excel_book.worksheet(0) # first sheet
    TerminalNotifier.notify "Fetching Test Data from XLS", title: "MyVanilla-#{browser_new}-Execution"
    sleep 2
  #Open New Browser
    TerminalNotifier.notify "Opening a new Browser Instance", title: "MyVanilla-#{browser_new}-Execution"
    sleep 2

    browser=Watir::Browser.new:"#{browser_new}"
    $LOG.info "Opening new #{browser_new} Browser instance......" 
    pdf.text "#{Time.now} : Opening new #{browser_new} Browser instance......"
    browser.driver.manage.window.maximize

  #Access MyVanilla CHW
    
    TerminalNotifier.notify "Opening MyVanilla CHW", title: "MyVanilla-#{browser_new}-Execution"
    sleep 2
    browser.goto url

  #Browser wait
    browser.wait_until {browser.div(:id, "signup_form").exists? }

  #Check if CHW is loaded
    $LOG.info "Go to - #{url}" 
    pdf.text "#{Time.now} : Go to - #{url}"
    
    TerminalNotifier.notify "Checking MyVanilla CHW", title: "MyVanilla-#{browser_new}-Execution"
    sleep 2
    $LOG.info "Entering into - 'Check if CHW is loaded' .. " 
    pdf.text "#{Time.now} : Entering into - 'Check if CHW is loaded' .. "
    if browser.div(:id, "signup_form").exists?
      $LOG.info "MyVanilla CHW is loaded.." 
      pdf.text "#{Time.now} : MyVanilla CHW is loaded - Check - <color rgb='347235'><b>Success</b></color>",:inline_format => true
    else
      $LOG.error "Error accessing MyVanilla CHW" 
      pdf.text "#{Time.now} : Error accessing MyVanilla CHW"
    end  
  
  #Login in MyVanilla CHW
    $LOG.info "Entering into - 'Login Module' .. " 
    pdf.text "#{Time.now} : Entering into - 'Login Module'"
  
  #Fetch userid,passwd
    $LOG.info "Entering into - 'Get Test Data' .. "
    pdf.text "#{Time.now} : Entering into - 'Get Test Data'" 
    sheet1.each_with_index do |row, idx|
  next if idx == 0 # ignore first row
    login, password = row[1], row[2] 
    $LOG.info "Fetching UserID and Password.." 
    pdf.text "#{Time.now} : Fetching UserID and Password." 
    TerminalNotifier.notify "Setting MyVanilla CHW uid and pwd", title: "MyVanilla-#{browser_new}-Execution"
    sleep 2
  #Set Uid
    browser.div(:id, "signup_form").flash
    browser.text_field(:id=>'user_id').set(login)
    $LOG.info "Setting User Name... :  #{login}" 
    pdf.text "#{Time.now} : Setting User Name... :  #{login}"
  
  #Set Pwd
    browser.text_field(:id=>'password').set(password)
    $LOG.info "Setting Password... : *********** " 
    pdf.text "#{Time.now} : Setting Password... : *********** "
    browser.button(:id => 'sign_in').click
    end 
    
  #Validating CHW Account page
    
    TerminalNotifier.notify "Validating MyVanilla CHW - Account Module", title: "MyVanilla-#{browser_new}-Execution"
    sleep 2
    $LOG.info "Entering into - 'CHW Account Module' .." 
    pdf.text "#{Time.now} : Entering into - 'CHW Account Module' .."
    browser.wait_until {browser.div(:id, "summary").exists? }
    if browser.div(:id, "summary").exists?
      $LOG.info "MyVanilla CHW - Login successful" 
      pdf.text "#{Time.now} : MyVanilla CHW - Login - <color rgb='347235'><b>Success</b></color>",:inline_format => true
      TerminalNotifier.notify "MyVanilla CHW - Login successful", title: "MyVanilla-#{browser_new}-Execution"
      sleep 2    
    else
      $LOG.error "MyVanila CHW - Login failed - Please Check" 
      pdf.text "#{Time.now} : MyVanila CHW - Login failed - Please Check"
      TerminalNotifier.notify "MyVanilla CHW - Login Failed", title: "MyVanilla-#{browser_new}-Execution"
      sleep 2
    end  

  #Checking Balance
    browser.table(:id, "card_info").flash
    strAccBal = browser.element(:xpath => "//*[@id='summary']").text
    if strAccBal.include? "$30.00"
     $LOG.info "CHW Account Balance - Check - #{strAccBal} - Success"
     pdf.text "#{Time.now} : CHW Account Balance - Check  - #{strAccBal} - <color rgb='347235'><b>Success</b></color>",:inline_format => true
     TerminalNotifier.notify "Balance Check - Success", title: "MyVanilla-#{browser_new}-Execution" 
     sleep 2
    else
     $LOG.error "CHW Account Balance - Check' failed"
     pdf.text "#{Time.now} : CHW Account Balance - Check' failed"
     TerminalNotifier.notify "Balance Check - Failed", title: "MyVanilla-#{browser_new}-Execution"
     sleep 2
    end

  #Check Card Status
    browser.element(:xpath => "/html/body/div[2]/div/section/dl/dd[3]").flash
    strCardStatus = browser.element(:xpath => "/html/body/div[2]/div/section/dl/dd[3]").text
    if strCardStatus.include? "active"
      $LOG.info "CHW Card Status - Check' successful -  Card Status - Active"
      pdf.text "#{Time.now} : CHW Card Status - Check- Active - <color rgb='347235'><b>Success</b></color>",:inline_format => true
      TerminalNotifier.notify "Card Status - Active", title: "MyVanilla-#{browser_new}-Execution" 
      sleep 2
    else
      $LOG.error "CHW Card Status - Check' Failed -  Card Status - Inactive/Unknown"
      pdf.text "#{Time.now} : CHW Card Status - Check' Failed -  Card Status - Inactive/Unknown"
      TerminalNotifier.notify "Card Status - Failed", title: "MyVanilla-#{browser_new}-Execution"
      sleep 2
    end
      
  #Check Exp Date  
    browser.element(:xpath => "/html/body/div[2]/div/section/dl/dd[2]").flash
    strExpDate = browser.element(:xpath => "/html/body/div[2]/div/section/dl/dd[2]").text
    if strExpDate.include? "06/15"
      $LOG.info "CHW Exp Date - #{strExpDate} - Check' successful"
      pdf.text "#{Time.now} : CHW Exp Date - #{strExpDate} - Check - <color rgb='347235'><b>Success</b></color>",:inline_format => true
      TerminalNotifier.notify "CHW Exp Date - #{strExpDate} - Check successful", title: "MyVanilla-#{browser_new}-Execution" 
      sleep 2
    else
      $LOG.info "CHW Exp Date  Check' failed"
      pdf.text "#{Time.now} : CHW Exp Date - Check failed"
      TerminalNotifier.notify "CHW Exp Date - Check failed", title: "MyVanilla-#{browser_new}-Execution" 
      sleep 2
    end
      
  #Transactions
    browser.element(:xpath => "/html/body/div[2]/div/aside/nav/ul/li[2]/a").flash
    browser.element(:xpath => "/html/body/div[2]/div/aside/nav/ul/li[2]/a").click   #Statements Link
    sleep 6
    $LOG.info "Statements Page loaded"
    pdf.text "#{Time.now} : Statements Page loaded"
    TerminalNotifier.notify "Statements Page loaded", title: "MyVanilla-#{browser_new}-Execution"
    sleep 2
    browser.element(:xpath => "/html/body/div[2]/div/section/fieldset/table/tbody/tr/td[2]/div").flash
    if browser.element(:xpath => "/html/body/div[2]/div/section/fieldset/table/tbody/tr/td[2]/div").exist?
      strTransInfo = browser.element(:xpath => "/html/body/div[2]/div/section/fieldset/table/tbody/tr/td[2]/div").text
      if strTransInfo.include? "CVS Pharmacy"
        $LOG.info "Trans Details - #{strTransInfo} - Check successful"
        pdf.text "#{Time.now} : Trans Details - #{strTransInfo} - Check - <color rgb='347235'><b>Success</b></color>",:inline_format => true
        TerminalNotifier.notify "Trans Details - #{strTransInfo} - Check successful", title: "MyVanilla-#{browser_new}-Execution" 
        sleep 2
      else
        $LOG.info "Trans Details  Check' failed"
        pdf.text "#{Time.now} : Trans Details - Check failed"
        TerminalNotifier.notify "Trans Details - Check failed", title: "MyVanilla-#{browser_new}-Execution"
        sleep 2
      end
    end  
      
  #Check Profile page
    browser.element(:xpath => "/html/body/header/div/nav[2]/ul/li/ul/li[3]/a").flash
    if browser.element(:xpath => "/html/body/header/div/nav[2]/ul/li/ul/li[3]/a").exists?
      browser.element(:xpath => "/html/body/header/div/nav[2]/ul/li/ul/li[3]/a").click
      sleep 6
      $LOG.info "Card Holder Information Page loaded"
      pdf.text "#{Time.now} : Card Holder Information Page loaded - <color rgb='347235'><b>Success</b></color>",:inline_format => true
      TerminalNotifier.notify "Card Holder Information Page loaded", title: "MyVanilla-#{browser_new}-Execution" 
      sleep 2
    else
      $LOG.error "Card Holder Information Page - Error"
      pdf.text "#{Time.now} : Card Holder Information Page Error"
      TerminalNotifier.notify "Card Holder Information Page - Error", title: "MyVanilla-#{browser_new}-Execution"
      sleep 2
    end
      
  #First Name Last Name Check
    strFirstName = browser.element(:xpath => "/html/body/div[2]/div/section/form/fieldset/ul/li/div").text
    browser.element(:xpath => "/html/body/div[2]/div/section/form/fieldset/ul/li/div").flash
    strLastName = browser.element(:xpath => "/html/body/div[2]/div/section/form/fieldset/ul/li/div[2]").text
    browser.element(:xpath => "/html/body/div[2]/div/section/form/fieldset/ul/li/div[2]").flash

    if strFirstName.include? "Raghuram" 
      if strLastName.include? "Pulijala"
      $LOG.info "#{strLastName} - Check successful"
      pdf.text "#{Time.now} : #{strLastName} - Check - <color rgb='347235'><b>Success</b></color>",:inline_format => true
      TerminalNotifier.notify "#{strLastName} - Card Holder Info - Name Check", title: "MyVanilla-#{browser_new}-Execution"
      sleep 2
      $LOG.info "#{strFirstName} - Check successful"
      pdf.text "#{Time.now} :  #{strFirstName}- Check - <color rgb='347235'><b>Success</b></color>",:inline_format => true
      TerminalNotifier.notify "#{strFirstName} - Card Holder Info - Name Check", title: "MyVanilla-#{browser_new}-Execution"
      sleep 2
      end
    else
      $LOG.info "Name - Check Failed"
      pdf.text "#{Time.now} : Name - Check Failed"
      TerminalNotifier.notify "Card Holder Info - Name Check failed", title: "MyVanilla-#{browser_new}-Execution"
      sleep 2
    end  
   
  #Email Check
   strEmail = browser.element(:xpath => "//*[@id='emailAddress']").value
   browser.element(:xpath => "//*[@id='emailAddress']").flash
    if strEmail.include? "raghuram.pulijala@hotmail.com"
      $LOG.info "Email - #{strEmail} - Check successful"
      pdf.text "#{Time.now} : Email - #{strEmail} - Check - <color rgb='347235'><b>Success</b></color>",:inline_format => true
      TerminalNotifier.notify "Email - Check successful", title: "MyVanilla-#{browser_new}-Execution"
      sleep 2
    else
      $LOG.info "Email - #{strEmail} - Check Failed"
      pdf.text "#{Time.now} : Email - #{strEmail} - Check Failed"
      TerminalNotifier.notify "Email - Check failed", title: "MyVanilla-#{browser_new}-Execution"
      sleep 2
    end
  
  #Mobile Phone Num Check
    strMobNum = browser.element(:xpath => "//*[@id='secondaryPhoneNumber']").value
    browser.element(:xpath => "//*[@id='secondaryPhoneNumber']").flash
     if strEmail.include? "raghuram.pulijala@hotmail.com"
       $LOG.info "Mob Num - #{strMobNum} - Check successful"
       pdf.text "#{Time.now} : Mob Num - #{strMobNum} - Check - <color rgb='347235'><b>Success</b></color>",:inline_format => true
       TerminalNotifier.notify "Mob Num - #{strMobNum} - Check successful", title: "MyVanilla-#{browser_new}-Execution"
       sleep 2
     else
       $LOG.info "Mob Num - #{strMobNum} - Check Failed"
       pdf.text "#{Time.now} : Mob Num - #{strMobNum} - Check Failed"
       TerminalNotifier.notify "Mob Num - #{strMobNum} - Check failed", title: "MyVanilla-#{browser_new}-Execution"
       sleep 2
     end
     
  #City Check
  
  strCity = browser.element(:xpath => "//*[@id='street_city']").value
  browser.element(:xpath => "//*[@id='street_city']").flash
   if strCity.include? "Alpharetta"
     $LOG.info "City - #{strCity} - Check successful"
     pdf.text "#{Time.now} : City - #{strCity} - Check - <color rgb='347235'><b>Success</b></color>",:inline_format => true
     TerminalNotifier.notify "City - #{strCity} - Check successful", title: "MyVanilla-#{browser_new}-Execution"
     sleep 2
   else
     $LOG.info "City - #{strCity} - Check Failed"
     pdf.text "#{Time.now} : City - #{strCity} - Check Failed"
     TerminalNotifier.notify "City - #{strCity} - Check failed", title: "MyVanilla-#{browser_new}-Execution"
   end
    sleep 2

  #Signing Out of CHW

    TerminalNotifier.notify "Signing out of CHW", title: "MyVanilla-#{browser_new}-Execution"
    pdf.text "#{Time.now} : Signing out of CHW"
    browser.link(:text, "Sign Out").click
    browser.wait_until {browser.div(:id, "signup_form").exists? }
    browser.div(:id, "signup_form").flash
    if browser.div(:id, "signup_form").exists?
      $LOG.info "CHW MyVanilla - Sign Out complete"
      pdf.text "#{Time.now} : CHW MyVanilla - Sign Out complete - <color rgb='347235'><b>Success</b></color>",:inline_format => true
    else
      $LOG.error "CHW MyVanilla - Sign Out error"
      pdf.text "#{Time.now} : CHW MyVanilla - Sign Out error"
    end  
  
  #Close Browser
    TerminalNotifier.notify "#{browser_new} - Closing the Browser", title: "MyVanilla-#{browser_new}-Execution"
    sleep 2

    $LOG.info "Entering into - 'Close Browser' Module" 
    pdf.text "#{Time.now} : Entering into - #{browser_new} - 'Close Browser' Module" 
    browser.close

  #finalizing comments
    $LOG.info "CHW Automation for Card Check Complete"
    $LOG.info "********************  MyVanilla CHW - #{browser_new} - End Execution **************************"
    pdf.text "#{Time.now} : CHW Automation for Card Check Complete - <color rgb='347235'><b>Success</b></color>",:inline_format => true
    pdf.text "#{Time.now} : MyVanilla CHW - #{browser_new} - End Execution"
    TerminalNotifier.notify "MyVanilla CHW - #{browser_new} - End Execution", title: "MyVanilla-#{browser_new}-Execution"
    sleep 2
    pdf.move_down 10
    pdf.stroke_horizontal_rule
    pdf.move_down 10
    if browser_new == "safari"
      pdf.text "Ruby - MyVanilla CHW Automation script execution completed", :style => :bold_italic
    end 
    pdf.bounding_box([pdf.bounds.right - 50, pdf.bounds.bottom], :width => 60, :height => 20) do
      pagecount = pdf.page_count
      pdf.text "Page #{pagecount}"
    end  
      
end
  
#Save PDF 
  pdf.render_file "Ruby_Automation_Results.pdf"
  $LOG.info "Saving PDF Results"

#Send Formatted HTML Mail along with Log/Report - Function in CommonFunctions
  send_mail
  TerminalNotifier.notify "Sending Results in an email"
  sleep 2
  $LOG.info "Sending Results in an email"
  
#Open Log file
  file_to_open = "CHW_Automation.log"
  system %{open "#{file_to_open}"}


#Automation Script Complete
  puts "MyVanilla CHW - Ruby Automation Demo - Complete"

