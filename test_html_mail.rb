

require 'rubygems'                  # For Ruby Scripting
require 'watir-webdriver'           # For driving Web Browsers
require 'pony'                      # For handling smtp mail server


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
  :attachments => {"CHW_Automation.pdf" => File.read("/Users/Sneha/RubyProjects/CHW_Automation.pdf")}
)