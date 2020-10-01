<%@ include file="header.jsp" %>


<script type="text/javascript">  


function gotoPrint(divName)  
{  
	 
	  var printContents = document.getElementById(divName).innerHTML; 
	  var originalContents = document.body.innerHTML; 
	  
		  
	  document.body.innerHTML = printContents;  
	  window.print();
	  document.body.innerHTML = originalContents;  
}
function gotoExcel(elemId, frmFldId)  
{  
	
          var obj = document.getElementById(elemId);  
          var oFld = document.getElementById(frmFldId); 
          oFld.value = obj.innerHTML;  
          document.roundtripdata.action ="excel.jsp";
          document.forms["roundtripdata"].submit();
}  
</script>  


<script type="text/javascript">
  var tableToExcel = (function()
		   {
	  			
	        	var uri = 'data:application/vnd.ms-excel;base64,'
    						, template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
    						, base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))) }
    						, format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; }) }
    return function(table, name) 
    {
    if (!table.nodeType) table = document.getElementById(table)
    var ctx = {worksheet: name || 'Worksheet', table: table.innerHTML
    }
    window.location.href = uri + base64(format(template, ctx))
  }
})()
</script>

<script>
function Table2Excel()
{
    //javascript:window.open('data:application/vnd.ms-excel,'+document.getElementById("mytable").innerHTML);
   
    var strCopy = document.getElementById("mytable").innerHTML;
    alert("strcopy"+strcopy);
    window.clipboardData.setData("Text", strCopy);
    var objExcel = new ActiveXObject ("Excel.Application");
    alert("objExcel"+objExcel);
    objExcel.visible = true;
   
    //var objWorkbook = objExcel.Workbooks.Add;
   // objWorkbook.Selection.TypeText(textToWrite);
    //objWorkbook.ActiveWorkbook.SaveAs("C:\\Eureka.doc");
    //objWorkbookQuit();
   // objExcel.visible = FALSE
	//var x=mytable.rows

	//var xls = new ActiveXObject("Excel.Application")
	//xls.visible = true
	//xls.Workbooks.Add
	//for (i = 0; i < x.length; i++)
	//{
//		var y = x[i].cells

//		for (j = 0; j < y.length; j++)
	//	{
		//	xls.Cells( i+1, j+1).Value = y[j].innerText
	//	}
//	}

}
</script>
<%
Connection conn,conn1;
Statement st,st1,st2,sttime;
String sql,tripid,sql1,sqltime;
String vehcode,begindate="2011-11-01",enddate="2011-11-09",begindateCal="",enddateCal="";
String startplace="";
String endplace="";
String vehregno="";
vehcode="";
begindate=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
enddate=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
begindateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
enddateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());

tripid="";

begindateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
enddateCal=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());

if (!(null == request.getParameter("begindate"))) 
{
    begindate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("begindate")));
    begindateCal=request.getParameter("begindate");
    
}
if (!(null == request.getParameter("enddate")))
{
    enddate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("enddate")));
    enddateCal=request.getParameter("enddate");
    
}
%>
<html>

<body>
<form name="roundtripmain"  method="get" action="" autocomplete="off" >

<div id = "main" >
     <table align="center" class="sortable_entry">
     <tr><td colspan="5"><h2><div align="center">Round Trip Transit Report</div></h2></td></tr>
     <tr align="center">
     <td>
      <strong>From :</strong>
    </td>
     <td>
     <input type="text" id="begindate" name="begindate" value="<%=begindateCal %>" size="15" readonly/>
	 <script type="text/javascript">
	 Calendar.setup(
	 {
	      inputField  : "begindate",         // ID of the input field
	      ifFormat    : "%d-%b-%Y",     // the date format
	      button      : "begindate"       // ID of the button
	  }
	  );
	</script>
	</td>
	<td>
   <strong>to :</strong>
    </td>
     <td>
    <input type="text" id="enddate"  name="enddate" value="<%=enddateCal %>" size="15" readonly />
	 <script type="text/javascript">
	 Calendar.setup(
	 {
	      inputField  : "enddate",         // ID of the input field
	      ifFormat    : "%d-%b-%Y",     // the date format
	      button      : "enddate"       // ID of the button
	  }
	  );
	</script>
	</td>
	
	<td>
	<input type="submit" name="submit" id="submit"
	value="Submit"  /></td>
     </tr>
     <tr align="center">
     <td colspan="5">
       <h3>Please select the dates to display the report.</h3>
     </td>
     </tr>
     
   </table>
</div>

</form>
 

<%
if (request.getQueryString()!=null)
{
     // direct transfer 
	// <input type="button" name="excel" id="excel" onclick ="tableToExcel('mytable', 'Excel Export ')" style="border: outset;" value="excel" />
 //<input type="submit" onclick="gotoExcel('mytable', 'tableHTML');" value="Excel" />  
 //<button type="submit" onclick="gotoExcel('mytb', 'tableHTML')" value="Excel"> <img src="images/excel.jpg" width="15px" height="15px" /> </button>
//<input type="submit" onclick="gotoExcel('mytb', 'tableHTML');" value="Excel" style="background: url('images/excel.jpg') width:22px; height:22px;"/>
 String exportFileName=session.getAttribute("user").toString()+"_roundtrip.xls";
%>
<form name="roundtripdata" action="" method="post"  autocomplete="off" >
<div id="topheading">
<table border="0" width="100%" align="center" bgcolor="white">
<tr><td align="center">
<table border="0" width="100%" align="center" bgcolor="white" class="stats">
<tr><td align="center">

<div align="right">


<input type="hidden" id="tableHTML" name="tableHTML" value="" />  
<input type="hidden" id="fileName" name="fileName" value="<%= exportFileName%>" />  

<a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
<img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a> 
		    

<a href="#" style="font-weight: bold; color: black; " onclick="gotoExcel('mytb', 'tableHTML');">
<img src="images/excel.jpg" width="15px" height="15px" style="border-style: none"></img>
</a> 
<font size="2">Date : <%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new java.util.Date()) %></font>
</div>
</td>
</tr>
</table>
</td>
</tr>
</table>
</div>

<div id="mytb">
<table id="mytable" border="1" width="100%" align="center" class="sortable">
<tr><td colspan="8" align="center"><font size="3">Round Trip Transit Report from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(begindate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(enddate))%> </font></td></tr>
<tr>
<td class="hed">Trip Id</td>
<td class="hed">Vehicle Reg No</td>
<td class="hed">Form Date</td>
<td class="hed">From Location</td>
<td class="hed">To Date</td>
<td class="hed">To Location</td>
<td class="hed">Duration</td>
<td class="hed">Stoppage Duration</td>
</tr>
<%
try
{
        Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st1=conn.createStatement();
		st2=conn.createStatement();
		sttime=conn.createStatement();
		sql="select DISTINCT * from db_gps.t_completedjourney where gpname='"+session.getAttribute("usertypevalue")+"'  and startdate between '"+begindate+"' and '"+enddate+"' GROUP BY tripid order by tripid";
		ResultSet rst1=st1.executeQuery(sql);
		String mfromdate="";
		String mbegindate="";
		String menddate="";
		String mtodate="";
		String mvehcode="";
		String mfromlocation="";
		String mtolocation="";
		String mstartlocation="";
		String mendlocation="";
		String mtripid="";
		String mLocationtype="";
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  

        java.util.Date d1 = null;
        java.util.Date d2 = null;
        int az=1;
        String mColorCode="#98AFC7";
        while(rst1.next())
		{
        	if (az==1)
        	{
        		mColorCode="#82CAFF";
        		System.out.println(az);
        	}
        	if (az==2)
        	{
        		mColorCode="#FFF8C6";
        
        		System.out.println(az);
        	}
        	
        	mtripid=rst1.getString("tripid");
			mfromdate=rst1.getString("startdate");
			mbegindate=rst1.getString("startdate");
			mvehcode=rst1.getString("vehregno");
			mstartlocation = rst1.getString("startplace");
		    mendlocation=rst1.getString("endplace");
			mfromlocation = rst1.getString("startplace");
		    mtolocation=rst1.getString("endplace");
		    mtodate=rst1.getString("enddate");
		    menddate=rst1.getString("enddate");
		    sql1="select * from db_gps.t_RoundTripStop where transporter='"+session.getAttribute("usertypevalue")+"' and tripid='"+mtripid+"' order by fromdate";
			ResultSet rst2=st2.executeQuery(sql1);
		    String mdiff="";
		    String mDuration="00:00:00";
		    String firstflag = "Y";
			ResultSet rstime;
	
		    while(rst2.next())
			{
				if (firstflag == "Y")
				{
					
					// code for begining of journey //
					 
					mDuration="00:00:00";
					mtodate=rst2.getString("fromdate");
					d1 = format.parse(mbegindate);
		            d2 = format.parse(mtodate);
		            long diff = d2.getTime() - d1.getTime();
		            long timeMillis = diff;  
		            long time = timeMillis / 1000;  
			        String seconds = Integer.toString((int)(time % 60));  
		            String minutes = Integer.toString((int)((time % 3600) / 60));  
		            String hours = Integer.toString((int)(time / 3600));  
		            String days = Integer.toString((int)(time / 3600)/24);
		            for (int i = 0; i < 2; i++)
	                {  
				    	if (seconds.length() < 2)
	                	{  
	                    	seconds = "0" + seconds;  
	                	}  
	               		if (minutes.length() < 2)
	               		{  
	              	     	minutes = "0" + minutes;  
	               		}  	
	              		if (hours.length() < 2) 
	              		{  
	                  	    hours = "0" + hours;  
	              		}
	                }
                	mdiff = hours+":"+minutes+":"+seconds;
                	//out.println("start:mduration----mdiff"+mdiff+"-----"+mDuration+"<br>");
	                sqltime = "SELECT ADDTIME('"+mDuration+"','"+mdiff+"') as timetotal";
	                rstime=sttime.executeQuery(sqltime);
	                if (rstime.next())
	                {
	                	mDuration=rstime.getString("timetotal");
	                }
	                //out.println("first duration"+mDuration);
	                firstflag="N";
	                mtolocation=rst2.getString("location");
	                mLocationtype=rst2.getString("locationtype");
	                if (!mDuration.substring(0,8).contains("00:00:00"))
	    			{
	    			%>
	    			<tr>
	    			<td style="background-color:<%=mColorCode%>;"><%=mtripid%></td>
	    			<td style="background-color:<%=mColorCode%>;"><%=mvehcode%></td>
	    			<td style="background-color:<%=mColorCode%>;"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(mbegindate))%></td>
	    			<td style="background-color:<%=mColorCode%>;"><%=mstartlocation%></td>
	    			<td style="background-color:<%=mColorCode%>;"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(mtodate))%></td>
	    			<td style="background-color:<%=mColorCode%>;"><%=mtolocation%></td>
	    			<td style="background-color:<%=mColorCode%>;"><%=mDuration%></td>
	    			<td style="background-color:<%=mColorCode%>;"><%=rst2.getString("duration")%></td>
	    			</tr>
	    			<%
	    			 mfromdate=rst2.getString("todate");
	    			}
	                mDuration="00:00:00";
				}
	            else
	            {    	
	            	// code for stoppages //
	            	
	            	mtodate=rst2.getString("fromdate");
	            	mLocationtype=rst2.getString("locationtype");
	            	mfromlocation = rst2.getString("location");
	                d1 = format.parse(mfromdate);
	               	d2 = format.parse(mtodate);
	               	if (d2.compareTo(d1)>0)
	    	        {
	               		long diff = d2.getTime() - d1.getTime();
	               		long timeMillis = diff;  
	               		long time = timeMillis / 1000;  
		            	String seconds = Integer.toString((int)(time % 60));  
	                	String minutes = Integer.toString((int)((time % 3600) / 60));  
	                	String hours = Integer.toString((int)(time / 3600));  
	                	String days = Integer.toString((int)(time / 3600)/24);
	                	for (int i = 0; i < 2; i++)
	                	{  
					    	if (seconds.length() < 2)
	                		{  
		                    	seconds = "0" + seconds;  
	                		}  
	               			if (minutes.length() < 2)
	               			{  
		              	     	minutes = "0" + minutes;  
		               		}  	
	              			if (hours.length() < 2) 
	              			{  
	                  	    	hours = "0" + hours;  
	              			}
	                	}
	                	mdiff = hours+":"+minutes+":"+seconds;
	                	//out.println("inner["+z+"]:mduration----mdiff--->>>time"+mDuration+"<----->"+mdiff+time+"<br>");
                		sqltime = "SELECT ADDTIME('"+mDuration+"','"+mdiff+"') as timetotal";
                	
                		rstime=sttime.executeQuery(sqltime);
                		if (rstime.next())
                		{
	                		mDuration=rstime.getString("timetotal");
                		}
                		if (!mDuration.substring(0,8).contains("00:00:00"))
	    				{
							%>
							<tr>
							<td style="background-color:<%=mColorCode%>;"><%=mtripid%></td>
							<td style="background-color:<%=mColorCode%>;"><%=mvehcode%></td>
							<td style="background-color:<%=mColorCode%>;"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(mfromdate))%></td>
							<td style="background-color:<%=mColorCode%>;"><%=mtolocation%></td>
							<td style="background-color:<%=mColorCode%>;"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(mtodate))%></td>
							<td style="background-color:<%=mColorCode%>;"><%=mfromlocation%></td>
							<td style="background-color:<%=mColorCode%>;"><%=mDuration%></td>
							<td style="background-color:<%=mColorCode%>;">
							<%
							d1 = format.parse(menddate);
			               	d2 = format.parse(rst2.getString("fromdate"));
			                if (d2.compareTo(d1)<0)
			                {%>
			                     <%=rst2.getString("duration")%>
							<%
							}
			                %>
			                </td>
			                </tr>
			                <%
						}
                	}
	               	mfromdate=rst2.getString("todate");
	             	mtolocation=rst2.getString("location");
	       	   }
		    }
	
		    // code for end journey

		    d1 = format.parse(menddate);
	        d2 = format.parse(mfromdate);
	        if (d2.compareTo(d1)<0)
	        {
	        	long diff = d2.getTime() - d1.getTime();
	        	if (diff>0)
	        	{
	        	long timeMillis = diff;  
               	long time = timeMillis / 1000;  
	            String seconds = Integer.toString((int)(time % 60));  
                String minutes = Integer.toString((int)((time % 3600) / 60));  
                String hours = Integer.toString((int)(time / 3600));  
                String days = Integer.toString((int)(time / 3600)/24);
                for (int i = 0; i < 2; i++)
                {  
			    	if (seconds.length() < 2)
                	{  
                    	seconds = "0" + seconds;  
                	}  
               		if (minutes.length() < 2)
               		{  
              	     	minutes = "0" + minutes;  
               		}  	
              		if (hours.length() < 2) 
              		{  
                  	    hours = "0" + hours;  
              		}
                }
	        	mdiff = hours+":"+minutes+":"+seconds;
	        	mDuration="00:00:00";
        		sqltime = "SELECT ADDTIME('"+mDuration+"','"+mdiff+"') as timetotal";
        		rstime=sttime.executeQuery(sqltime);
        		if (rstime.next())
        		{	
	        		mDuration=rstime.getString("timetotal");
        		}
        		mDuration=mdiff;//hours+":"+minutes+":"+seconds;
    			if (!mDuration.substring(0,8).contains("00:00:00"))
				{
	    		%>
				<tr >
				<td style="background-color:<%=mColorCode%>;"><%=mtripid%></td>
				<td style="background-color:<%=mColorCode%>;"><%=mvehcode%></td>
				<td style="background-color:<%=mColorCode%>;"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(mtodate))%></td>
				<td style="background-color:<%=mColorCode%>;"><%=mtolocation%></td>
				<td style="background-color:<%=mColorCode%>;"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(menddate))%></td>
				<td style="background-color:<%=mColorCode%>;"><%=mendlocation%></td>
				<td style="background-color:<%=mColorCode%>;"><%=mDuration%></td>
				<td style="background-color:<%=mColorCode%>;"><%=mLocationtype%></td>
				</tr>
				<%
				}
	        	}
			}
	        az=az+1;
	        if (az>=3)
	    	{
	    		az=1;
	    	}
	    }
    }
	catch(Exception e)
	{
		out.print("Exception --->"+e);
	}
	finally
	{
		//conn.close();
	}
	%>
	</table>
	</div>
	<%
}
%>
<br></br><br></br>
<br></br>
<br></br>
<br></br>
<br></br>
<br></br>
<br></br><br></br>
<br></br>
<br></br>
<!-- footer starts here-->
<%@ include file="footernew.jsp" %>

</form>
</body>
</html>