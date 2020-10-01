<%@page contentType="application/vnd.ms-excel; charset=gb2312" import="java.sql.*" import="java.text.*"%>
<% response.setContentType("application/vnd.ms-excel");

String filename="TripData.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);

  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);
  %>
<table  border="0">
<tr>

<th>Sr.No</th>
<th>TripID</th>
<th>TripDateTime</th>
<th>Vehicle Reg.No</th>
<th>Transporter</th>
<th>TripFrom</th>
<th>TripTo</th>
<th>DriverID</th>
<th>DriverName</th>
<th>DriverID</th>
<th>DriverName</th>
<th>ETA</th>
<th>Weight</th>
<th>Vendor</th>
<th>Trip Type</th>
<th>Advance</th>
<th>Freight</th>
<th>Fixed Km</th>
<th>Fixed Time</th>
<th>ReportDateTime</th>
<th>Load Delay Reason</th>
<th>Comments</th>
</tr>
<tr>

<th>Numebr Only</th>
<th>Digits and Alphabets</th>
<th>For Excel-dd-MMM-yyyy HH:mm:ss<br>
For CSV-dd/MM/yy HH:mm
</th>
<th>Digits and Alphabets</th>
<th>Digits and Alphabets</th>
<th>Digits and Alphabets</th>
<th>Digits and Alphabets</th>
<th>Digits and Alphabets</th>
<th>Alphabets</th>
<th>Digits and Alphabets</th>
<th>Alphabets</th>
<th>For Excel-dd-MMM-yyyy HH:mm:ss<br>
For CSV-dd/MM/yy HH:mm
</th>
<th>Numebr Only</th>
<th>Alphabets</th>
<th>Alphabets</th>
<th>Numebr Only</th>
<th>Numebr Only</th>
<th>Numebr Only</th>
<th>Digits and Alphabets</th>
<th>For Excel-dd-MMM-yyyy HH:mm:ss<br>
For CSV-dd/MM/yy HH:mm
</th>
<th>Alphabets</th>
<th>Alphabets</th>
</tr>		
</table>

<!--contents of download.jsp-->
<%@ page import="java.util.*,java.io.*"%>
<!--Assumes that file name is in the request objects query Parameter -->
<%
	//read the file name.
	
	/*File f = new File ("/home/" + request.getParameter("file") );
	//set the content type(can be excel/word/powerpoint etc..)
	response.setContentType ("application/vnd.ms-excel");
	//set the header and also the Name by which user will be prompted to save
	response.setHeader ("Content-Disposition", "attachment;filename=\"TripData.xsl\"");
	
	//get the file name
	String name = f.getName().substring(f.getName().lastIndexOf("/") + 1,f.getName().length());
	//OPen an input stream to the file and post the file contents thru the 
	//servlet output stream to the client m/c
	
		InputStream in = new FileInputStream(f);
		ServletOutputStream outs = response.getOutputStream();
		
		
		int bit = 256;
		int i = 0;


    		try {


        			while ((bit) >= 0) {
        				bit = in.read();
        				outs.write(bit);
        			}
        			//System.out.println("" +bit);


            		} catch (IOException ioe) {
            			ioe.printStackTrace(System.out);
            		}
            //		System.out.println( "\n" + i + " byt
            //     es sent.");
            //		System.out.println( "\n" + f.length(
            //     ) + " bytes sent.");
            		outs.flush();
            		outs.close();
            		in.close();*/	
            %>
