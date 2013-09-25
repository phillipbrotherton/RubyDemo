#Check MyVanilla Debit Card Balance
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

include CHWCommonFunctions

browsers = ["chrome","ff","safari"]
 
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

browsers.each do |browser_new| 
  $LOG.info "********************  MyVanilla CHW - #{browser_new} - Start Execution **************************" 
    pdf.text "Browser - #{browser_new}", :style => :bold_italic
    pdf.move_down 20
    pdf.text "#{Time.now} : MyVanilla - #{browser_new} - Ruby Automation Script - Start Execution"

    #Using Terminal Notifier
    TerminalNotifier.notify "MyVanilla CHW - #{browser_new} - Start Execution"

    #Using TestData.xls to fetch Id,pwd
    $LOG.info "Entering into - 'Create Excel object' .. " 
    pdf.text "#{Time.now} : Entering into - 'Create Excel object' .. " 
    TerminalNotifier.notify "Creating Excel Object"
    excel_file = File.join(File.dirname(__FILE__), "", "testdata.xls") 
    excel_book = Spreadsheet.open excel_file
    sheet1 = excel_book.worksheet(0) # first sheet
    TerminalNotifier.notify "Fetching Test Data from XLS"

    #Open New Browser
    TerminalNotifier.notify "Opening a new Browser Instance"

    browser=Watir::Browser.new:"#{browser_new}"
    $LOG.info "Opening new #{browser_new} Browser instance......" 
    pdf.text "#{Time.now} : Opening new #{browser_new} Browser instance......"
    browser.driver.manage.window.maximize

    #Access MyVanilla CHW
    TerminalNotifier.notify "Opening MyVanilla CHW"

    browser.goto url

    #Browser wait
    browser.wait_until {browser.div(:id, "signup_form").exists? }

    #Check if CHW is loaded
    $LOG.info "Go to - #{url}" 
    pdf.text "#{Time.now} : Go to - #{url}"
    TerminalNotifier.notify "Checking MyVanilla CHW"

    $LOG.info "Entering into - 'Check if CHW is loaded' .. " 
    pdf.text "#{Time.now} : Entering into - 'Check if CHW is loaded' .. "
    if browser.div(:id, "signup_form").exists?
      $LOG.info "MyVanilla CHW is loaded.." 
      pdf.text "#{Time.now} : MyVanilla CHW is loaded.."
    else
      $LOG.error "Error accessing MyVanilla CHW" 
      pdf.text "#{Time.now} : Error accessing MyVanilla CHW"
    end  
  
    #Login in MyVanilla CHW
      $LOG.info "Entering into - 'Login Module' .. " 
      pdf.text "#{Time.now} : Entering into - 'Login Module' .. "
    #Fetch userid,passwd
      $LOG.info "Entering into - 'Get Test Data' .. "
      pdf.text "#{Time.now} : Entering into - 'Get Test Data' .. " 
      sheet1.each_with_index do |row, idx|
    next if idx == 0 # ignore first row
      login, password = row[1], row[2] 
      $LOG.info "Fetching UserID and Password..... " 
      pdf.text "#{Time.now} : Fetching UserID and Password..... " 
      TerminalNotifier.notify "Setting MyVanilla CHW uid and pwd"

      browser.div(:id, "signup_form").flash
      browser.text_field(:id=>'user_id').set(login)
      $LOG.info "Setting User Name... :  #{login}" 
      pdf.text "#{Time.now} : Setting User Name... :  #{login}"
  
      browser.text_field(:id=>'password').set(password)
      $LOG.info "Setting Password... : *********** " 
      pdf.text "#{Time.now} : Setting Password... : *********** "
      browser.button(:id => 'sign_in').click
      end 
    #Validating CHW Account page
      TerminalNotifier.notify "Validating MyVanilla CHW - Account Module"

      $LOG.info "Entering into - 'CHW Account Module' .." 
      pdf.text "#{Time.now} : Entering into - 'CHW Account Module' .."
      browser.wait_until {browser.div(:id, "summary").exists? }
      if browser.div(:id, "summary").exists?
        $LOG.info "MyVanilla CHW - Login successful" 
        pdf.text "#{Time.now} : MyVanilla CHW - Login successful" 
        TerminalNotifier.notify "MyVanilla CHW - Login successful"
      else
        $LOG.error "MyVanila CHW - Login failed - Please Check" 
        pdf.text "#{Time.now} : MyVanila CHW - Login failed - Please Check"
        TerminalNotifier.notify "MyVanilla CHW - Login Failed"
      end  

    #Checking Balance
    #$LOG.info "Entering Into 'CHW Account Balance - Check' Module "
    browser.table(:id, "card_info").flash
    strAccBal = browser.element(:xpath => "//*[@id='summary']").text
    if strAccBal.include? "$30.00"
     $LOG.info "CHW Account Balance - Check' successful -  #{strAccBal}"
     pdf.text "#{Time.now} : CHW Account Balance - Check  - #{strAccBal}"

     TerminalNotifier.notify "Balance Check - Success" 
    else
     $LOG.error "CHW Account Balance - Check' failed"
     pdf.text "#{Time.now} : CHW Account Balance - Check' failed"
      TerminalNotifier.notify "Balance Check - Failed"
    end


      strCardStatus = browser.element(:xpath => "/html/body/div[2]/div/section/dl/dd[3]").text
      if strCardStatus.include? "active"
        $LOG.info "CHW Card Status - Check' successful -  Card Status - Active"
        pdf.text "#{Time.now} : CHW Card Status - Check' successful -  Card Status - Active"
        TerminalNotifier.notify "Card Status - Active" 
      else
        $LOG.error "CHW Card Status - Check' Failed -  Card Status - Inactive/Unknown"
        pdf.text "#{Time.now} : CHW Card Status - Check' Failed -  Card Status - Inactive/Unknown"
        TerminalNotifier.notify "Card Status - Failed"
      end

      if browser.element(:xpath => "/html/body/header/div/nav[2]/ul/li/ul/li[3]/a").exists?
        browser.element(:xpath => "/html/body/header/div/nav[2]/ul/li/ul/li[3]/a").click
        sleep 5
        $LOG.info "Card Holder Information Page loaded"
        pdf.text "#{Time.now} : Card Holder Information Page loaded"
        TerminalNotifier.notify "Card Holder Information Page loaded" 
      else
        $LOG.error "Card Holder Information Page - Error"
        pdf.text "#{Time.now} : Card Holder Information Page Error"
        TerminalNotifier.notify "Card Holder Information Page - Error"
      end
    
        strFirstName = browser.element(:xpath => "/html/body/div[2]/div/section/form/fieldset/ul/li/div").text
        strLastName = browser.element(:xpath => "/html/body/div[2]/div/section/form/fieldset/ul/li/div[2]").text
  
        if strFirstName.include? "Raghuram" 
          if strLastName.include? "Pulijala"
          $LOG.info "#{strFirstName} #{strLastName} - Check successful"
          pdf.text "#{Time.now} :  #{strFirstName} #{strLastName} - Check successful"
          TerminalNotifier.notify "#{strFirstName} #{strLastName} - Card Holder Info - Name Check"
          end
        else
          $LOG.info "Name - Check Failed"
          pdf.text "#{Time.now} : Name - Check Failed"
          TerminalNotifier.notify "Card Holder Info - Name Check failed"
        end  
   
 
     strEmail = browser.element(:xpath => "//*[@id='emailAddress']").value
      if strEmail.include? "raghuram.pulijala@hotmail.com"
        $LOG.info "Email - #{strEmail} - Check successful"
        pdf.text "#{Time.now} : Email - #{strEmail} - Check successful"
        TerminalNotifier.notify "Email - Check successful"
      else
        $LOG.info "Email - #{strEmail} - Check Failed"
        pdf.text "#{Time.now} : Email - #{strEmail} - Check Failed"
        TerminalNotifier.notify "Email - Check failed"
      end
  
    sleep 5

    #Signing Out of CHW

    TerminalNotifier.notify "Signing out of CHW"
    pdf.text "#{Time.now} : Signing out of CHW"
    browser.link(:text, "Sign Out").click
    browser.wait_until {browser.div(:id, "signup_form").exists? }
    if browser.div(:id, "signup_form").exists?
      $LOG.info "CHW MyVanilla - Sign Out complete"
      pdf.text "#{Time.now} : CHW MyVanilla - Sign Out complete"
    else
      $LOG.error "CHW MyVanilla - Sign Out error"
      pdf.text "#{Time.now} : CHW MyVanilla - Sign Out error"
    end  
  
    #Close Browser
    TerminalNotifier.notify "#{browser_new} - Closing the Browser"

    sleep 3
    $LOG.info "Entering into - 'Close Browser' Module" 
    pdf.text "#{Time.now} : Entering into - #{browser_new} - 'Close Browser' Module" 
    browser.close

    #finalizing comments
    $LOG.info "CHW Automation for Card Check Complete"
    $LOG.info "********************  MyVanilla CHW - #{browser_new} - End Execution **************************"
    pdf.text "#{Time.now} : CHW Automation for Card Check Complete"
    pdf.text "#{Time.now} : MyVanilla CHW - #{browser_new} - End Execution"
    TerminalNotifier.notify "MyVanilla CHW - #{browser_new} - End Execution"
    pdf.move_down 10
    pdf.stroke_horizontal_rule
    pdf.move_down 10
    
end

#Send Email
TerminalNotifier.notify "Sending Results in an email"
$LOG.info "Sending Results in an email"
pdf.text "#{Time.now} : Sending Results in an email"
pdf.move_down 10
pdf.stroke_horizontal_rule
pdf.bounding_box([pdf.bounds.right - 50, pdf.bounds.bottom], :width => 60, :height => 20) do
  pagecount = pdf.page_count
  pdf.text "Page #{pagecount}"
end

pdf.render_file "CHW_Automation.pdf"

to_addresses = [
  'rpulijala@incomm.com'
]
cc_addresses = [
'raghuram.pulijala@gmail.com'
]

Pony.mail(
  :to => to_addresses,
  :cc => cc_addresses,
  :from => 'raghuram.pulijala@gmail.com', 
  :subject => 'MyVanilla CHW Automation Results - PDF Report',
  :html_body => '
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"><html><head><META http-equiv="Content-Type" content="text/html; charset=utf-8"></head><body>


<div bgcolor="#DEDEDE" lang="EN-US" link="blue" vlink="purple">



<div>



<table border="0" cellspacing="0" cellpadding="0" width="100%">

 <tr>

  <td style="padding:0in 0in 0in 0in">

  <div align="center">

  <table border="0" cellspacing="0" cellpadding="0" width="640">

   <tr style="height:15.0pt">

    <td width="640" style="width:480.0pt;padding:0in 0in 0in 0in;height:15.0pt"></td>

   </tr>

   <tr>

    <td width="640" style="width:480.0pt;padding:0in 0in 0in 0in">

    <table border="0" cellspacing="0" cellpadding="0" width="640" style="width:480.0pt;background:#c7c7c7;border-collapse:collapse">

     <tr>

      <td width="15" style="width:11.25pt;padding:0in 0in 0in 0in"></td>

      <td width="350" style="width:262.5pt;padding:0in 0in 0in 0in">

      <table border="0" cellspacing="0" cellpadding="0" width="350">

       <tr style="height:6.0pt">

        <td width="350" style="width:262.5pt;padding:0in 0in 0in 0in;height:6.0pt"></td>

       </tr>

      </table>

      <div>

      <p><span style="font-size:9.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#ededed"> </span></p>

      </div>

      <table border="0" cellspacing="0" cellpadding="0" width="350">

       <tr style="height:6.0pt">

        <td width="350" style="width:262.5pt;padding:0in 0in 0in 0in;height:6.0pt"></td>

       </tr>

      </table>

      </td>

      <td width="30" style="width:22.5pt;padding:0in 0in 0in 0in"></td>

      <td width="255" style="width:191.25pt;padding:0in 0in 0in 0in">

      <div align="right">

      <table border="0" cellspacing="0" cellpadding="0" width="255">

       <tr style="height:6.0pt">

        <td width="255" style="width:191.25pt;padding:0in 0in 0in 0in;height:6.0pt"></td>

       </tr>

      </table>

      </div>

      <p align="right" style="text-align:right"><span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#ededed"> </span></p>

      <div align="right">

      <table border="0" cellspacing="0" cellpadding="0" style="border-collapse:collapse">

       <tr>

        <td style="padding:0in 0in 0in 0in"></td>

       </tr>

      </table>

      </div>

      <p align="right" style="text-align:right"><span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#ededed"> </span></p>

      <div align="right">

      <table border="0" cellspacing="0" cellpadding="0" width="255">

       <tr style="height:6.0pt">

        <td width="255" style="width:191.25pt;padding:0in 0in 0in 0in;height:6.0pt"></td>

       </tr>

      </table>

      </div>

      </td>

      <td width="15" style="width:11.25pt;padding:0in 0in 0in 0in"></td>

     </tr>

    </table>

    </td>

   </tr>

   <tr>

    <td width="640" style="width:480.0pt;background:white;padding:0in 0in 0in 0in">

    <div align="center">

    <table border="0" cellspacing="0" cellpadding="0" width="640" style="width:480.0pt;border-collapse:collapse">

     <tr style="height:22.5pt">

      <td width="30" style="width:22.5pt;padding:0in 0in 0in 0in;height:22.5pt"></td>

      <td width="580" style="width:435.0pt;padding:0in 0in 0in 0in;height:22.5pt"></td>

      <td width="30" style="width:22.5pt;padding:0in 0in 0in 0in;height:22.5pt"></td>

     </tr>

     <tr>

      <td width="30" style="width:22.5pt;padding:0in 0in 0in 0in"></td>

      <td width="580" style="width:435.0pt;padding:0in 0in 0in 0in">

      <p align="center" style="margin-bottom:22.5pt;text-align:center"><strong><span style="font-size:27.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#444444">Ruby - MyVanilla CHW

      Automation Demo</span></strong><span style="font-size:27.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#444444"> </span></p>

      </td>

      <td width="30" style="width:22.5pt;padding:0in 0in 0in 0in"></td>

     </tr>

    </table>

    </div>

    </td>

   </tr>

   <tr style="height:22.5pt">

    <td width="640" style="width:480.0pt;background:white;padding:0in 0in 0in 0in;height:22.5pt"></td>

   </tr>

   <tr>

    <td width="640" style="width:480.0pt;background:white;padding:0in 0in 0in 0in">

    <table border="0" cellspacing="0" cellpadding="0" width="640" style="width:480.0pt;border-collapse:collapse">

     <tr>

      <td width="30" style="width:22.5pt;padding:0in 0in 0in 0in"></td>

      <td width="580" style="width:435.0pt;padding:0in 0in 0in 0in">

      <table border="0" cellspacing="0" cellpadding="0" width="580">

       <tr>

        <td width="580" style="width:435.0pt;padding:0in 0in 0in 0in">

        <p>This is an automatic

        generated email, attached is the Ruby CHW Automation Script results and

        logs</p>

        <p><span style="color:windowtext">Below is the Ruby

        Automation – Logic flow</span></p>

        <p><span><img width="576" height="675" src="https://raw.github.com/rpulijala/RubyDemo/master/RubyDemoLogicFlow.jpg"></span></p>

        </td>

       </tr>

       

       <tr style="height:7.5pt">

        <td width="580" style="width:435.0pt;padding:0in 0in 0in 0in;height:7.5pt"></td>

       </tr>

      </table>

      <p><span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

      

      <table border="0" cellspacing="0" cellpadding="0" width="580">

       <tr>

        <td width="580" style="width:435.0pt;padding:0in 0in 0in 0in">

        <p> </p>

        </td>

       </tr>

       <tr>

        <td width="580" style="width:435.0pt;padding:0in 0in 0in 0in">

        <p><span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

        </td>

       </tr>

       <tr style="height:11.25pt">

        <td width="580" style="width:435.0pt;padding:0in 0in 0in 0in;height:11.25pt">

        <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

        </td>

       </tr>

       <tr>

        <td width="580" style="width:435.0pt;padding:0in 0in 0in 0in">

        <div style="margin-bottom:13.5pt">

        <p style="line-height:13.5pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#444444"> </span></p>

        </div>

        </td>

       </tr>

       <tr style="height:7.5pt">

        <td width="580" style="width:435.0pt;padding:0in 0in 0in 0in;height:7.5pt">

        <p><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

        </td>

       </tr>

      </table>

      <p><span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

      

      <table border="0" cellspacing="0" cellpadding="0" width="580">

       <tr>

        <td width="580" style="width:435.0pt;padding:0in 0in 0in 0in">

        <div style="margin-bottom:13.5pt">

        <p style="line-height:13.5pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#444444"> </span></p>

        </div>

        </td>

       </tr>

       <tr style="height:7.5pt">

        <td width="580" style="width:435.0pt;padding:0in 0in 0in 0in;height:7.5pt">

        <p><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

        </td>

       </tr>

      </table>

      <p><span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

      

      <table border="0" cellspacing="0" cellpadding="0" width="580">

       <tr>

        <td width="580" style="width:435.0pt;padding:0in 0in 0in 0in">

        <div style="margin-bottom:13.5pt">

        <p style="line-height:13.5pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#444444"> </span></p>

        </div>

        </td>

       </tr>

       <tr style="height:7.5pt">

        <td width="580" style="width:435.0pt;padding:0in 0in 0in 0in;height:7.5pt">

        <p><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

        </td>

       </tr>

      </table>

      <p><span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

      

      <table border="0" cellspacing="0" cellpadding="0" width="580">

       <tr>

        <td width="275" valign="top" style="width:206.25pt;padding:0in 0in 0in 0in">

        <table border="0" cellspacing="0" cellpadding="0" width="275" style="width:206.25pt;border-collapse:collapse">

         <tr>

          <td width="275" style="width:206.25pt;padding:0in 0in 0in 0in">

          <div style="margin-bottom:13.5pt">

          <p style="line-height:13.5pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#444444"> </span></p>

          </div>

          </td>

         </tr>

         <tr style="height:7.5pt">

          <td width="275" style="width:206.25pt;padding:0in 0in 0in 0in;height:7.5pt">

          <p><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

          </td>

         </tr>

        </table>

        </td>

        <td width="30" style="width:22.5pt;padding:0in 0in 0in 0in"></td>

        <td width="275" valign="top" style="width:206.25pt;padding:0in 0in 0in 0in">

        <table border="0" cellspacing="0" cellpadding="0" width="275" style="width:206.25pt;border-collapse:collapse">

         <tr>

          <td width="275" style="width:206.25pt;padding:0in 0in 0in 0in">

          <div style="margin-bottom:13.5pt">

          <p style="line-height:13.5pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#444444"> </span></p>

          </div>

          </td>

         </tr>

         <tr style="height:7.5pt">

          <td width="275" style="width:206.25pt;padding:0in 0in 0in 0in;height:7.5pt">

          <p><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

          </td>

         </tr>

        </table>

        </td>

       </tr>

      </table>

      <p><span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

      

      <table border="0" cellspacing="0" cellpadding="0" width="580">

       <tr>

        <td width="180" valign="top" style="width:135.0pt;padding:0in 0in 0in 0in">

        <table border="0" cellspacing="0" cellpadding="0" width="180" style="width:135.0pt;border-collapse:collapse">

         <tr>

          <td width="180" style="width:135.0pt;padding:0in 0in 0in 0in">

          <p><span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

          </td>

         </tr>

         <tr style="height:7.5pt">

          <td width="180" style="width:135.0pt;padding:0in 0in 0in 0in;height:7.5pt">

          <p><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

          </td>

         </tr>

         <tr>

          <td width="180" style="width:135.0pt;padding:0in 0in 0in 0in">

          <div style="margin-bottom:13.5pt">

          <p style="line-height:13.5pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#444444"> </span></p>

          </div>

          </td>

         </tr>

         <tr style="height:7.5pt">

          <td width="180" style="width:135.0pt;padding:0in 0in 0in 0in;height:7.5pt">

          <p><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

          </td>

         </tr>

        </table>

        </td>

        <td width="20" style="width:15.0pt;padding:0in 0in 0in 0in"></td>

        <td width="180" valign="top" style="width:135.0pt;padding:0in 0in 0in 0in">

        <table border="0" cellspacing="0" cellpadding="0" width="180" style="width:135.0pt;border-collapse:collapse">

         <tr>

          <td width="180" style="width:135.0pt;padding:0in 0in 0in 0in">

          <p><span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

          </td>

         </tr>

         <tr style="height:7.5pt">

          <td width="180" style="width:135.0pt;padding:0in 0in 0in 0in;height:7.5pt">

          <p><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

          </td>

         </tr>

         <tr>

          <td width="180" style="width:135.0pt;padding:0in 0in 0in 0in">

          <div style="margin-bottom:13.5pt">

          <p style="line-height:13.5pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#444444"> </span></p>

          </div>

          </td>

         </tr>

         <tr style="height:7.5pt">

          <td width="180" style="width:135.0pt;padding:0in 0in 0in 0in;height:7.5pt">

          <p><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

          </td>

         </tr>

        </table>

        </td>

        <td width="20" style="width:15.0pt;padding:0in 0in 0in 0in"></td>

        <td width="180" valign="top" style="width:135.0pt;padding:0in 0in 0in 0in">

        <table border="0" cellspacing="0" cellpadding="0" width="180" style="width:135.0pt;border-collapse:collapse">

         <tr>

          <td width="180" style="width:135.0pt;padding:0in 0in 0in 0in">

          <p><span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

          </td>

         </tr>

         <tr style="height:7.5pt">

          <td width="180" style="width:135.0pt;padding:0in 0in 0in 0in;height:7.5pt">

          <p><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

          </td>

         </tr>

         <tr>

          <td width="180" style="width:135.0pt;padding:0in 0in 0in 0in">

          <div style="margin-bottom:13.5pt">

          <p style="line-height:13.5pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;;color:#444444"> </span></p>

          </div>

          </td>

         </tr>

         <tr style="height:7.5pt">

          <td width="180" style="width:135.0pt;padding:0in 0in 0in 0in;height:7.5pt">

          <p><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

          </td>

         </tr>

        </table>

        </td>

       </tr>

      </table>

      </td>

      

      <td width="30" style="width:22.5pt;padding:0in 0in 0in 0in"></td>

     </tr>

    </table>

    </td>

   </tr>

   <tr style="height:11.25pt">

    <td width="640" style="width:480.0pt;background:white;padding:0in 0in 0in 0in;height:11.25pt"></td>

   </tr>

   <tr>

    <td width="640" style="width:480.0pt;padding:0in 0in 0in 0in">

    <table border="0" cellspacing="0" cellpadding="0" width="640" style="width:480.0pt;background:#c7c7c7;border-collapse:collapse">

     <tr style="height:22.5pt">

      <td width="30" style="width:22.5pt;padding:0in 0in 0in 0in;height:22.5pt"></td>

      <td width="360" style="width:3.75in;padding:0in 0in 0in 0in;height:22.5pt"></td>

      <td width="60" style="width:45.0pt;padding:0in 0in 0in 0in;height:22.5pt"></td>

      <td width="160" style="width:120.0pt;padding:0in 0in 0in 0in;height:22.5pt"></td>

      <td width="30" style="width:22.5pt;padding:0in 0in 0in 0in;height:22.5pt"></td>

     </tr>

     <tr>

      <td width="30" style="width:22.5pt;padding:0in 0in 0in 0in"></td>

      <td width="360" valign="top" style="width:3.75in;padding:0in 0in 0in 0in">

      <p><span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"> </span></p>

      </td>

      <td width="60" style="width:45.0pt;padding:0in 0in 0in 0in"></td>

      <td width="160" valign="top" style="width:120.0pt;padding:0in 0in 0in 0in"></td>

      <td width="30" style="width:22.5pt;padding:0in 0in 0in 0in"></td>

     </tr>

     <tr style="height:11.25pt">

      <td width="30" style="width:22.5pt;padding:0in 0in 0in 0in;height:11.25pt"></td>

      <td width="360" style="width:3.75in;padding:0in 0in 0in 0in;height:11.25pt"></td>

      <td width="60" style="width:45.0pt;padding:0in 0in 0in 0in;height:11.25pt"></td>

      <td width="160" style="width:120.0pt;padding:0in 0in 0in 0in;height:11.25pt"></td>

      <td width="30" style="width:22.5pt;padding:0in 0in 0in 0in;height:11.25pt"></td>

     </tr>

    </table>

    </td>

   </tr>

   <tr style="height:45.0pt">

    <td width="640" style="width:480.0pt;padding:0in 0in 0in 0in;height:45.0pt"></td>

   </tr>

  </table>

  </div>

  </td>

 </tr>

</table>



<p><span> </span></p>



</div>



</div>





</body></html>', 
  :attachments => {"CHW_Automation.pdf" => File.read("/Users/Sneha/RubyProjects/RubyAutomation/CHW_Automation.pdf")}
)


#Open Log file
file_to_open = "CHW_Automation.log"
system %{open "#{file_to_open}"}


#Automation Script Complete
puts "MyVanilla CHW - Ruby Automation Demo - Complete"

