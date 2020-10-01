<%@ include file="cargoheader.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<form name="dateform" action="" method="get" onsubmit="return validate();">
<%!
	Connection conn;
	Statement st,st1,st2;
	ResultSet rst=null,rst1=null,rst2=null;
	String user;
%>
<%
try{
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
	String stat="",location="",StartDate="",EndDate="",EndTime="",StartTime="",fromdate="",todate="",thedate="",thedate1="";
	String fromdate1="",todate1="";
	//String todey=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String vehcode=request.getParameter("vehcode");
	String vehregno=request.getParameter("vehregno");
	String cranemodno=request.getParameter("cranemodno");
%>	
	<input type="hidden" name="vehcode" value="<%=vehcode%>">
	<input type="hidden" name="vehregno" value="<%=vehregno%>">
	<input type="hidden" name="cranemodno" value="<%=cranemodno%>">
	<%
//out.print(vehcode);
if(vehcode==null||vehregno==null)
{
	vehcode=request.getParameter("vehcode");
	vehregno=request.getParameter("vehregno");
	cranemodno=request.getParameter("cranemodno");
}
if(!(null==request.getParameter("data")))
{
	
fromdate1=request.getParameter("data");
fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(fromdate1));
todate1=request.getParameter("data1");
todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(todate1));
//out.print(fromdate);
}
else
{
	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	todate=fromdate;
	fromdate1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	todate1=fromdate1;
//out.print(todate);
}
	
%>	
 <table width="100%" align="center" border="0"  class="bodytext">
	<tr>
		<td colspan="1"><a href="javascript:history.go(-1)"  onMouseOver="self.status=document.referrer;return true"><font size="2"><img  src="images/arrow.bmp" width="7%" height="7%" title="Go to Back Page"></a></td>
		<td align="left" class="sorttable_nosort" colspan="7">
		<font color="block" size="3" ><b></>Crane Bypass Key Report</font></td>
		</tr>
		<tr><td colspan="8">
			<!-- if date range is not required please remove this code start from this comment to -->
			
			<script language="javascript">
 			function validate()
  			{
  				if(document.getElementById("data").value=="")
  				{
  			  		alert("Please select the from date");
  					return false;
  				}
  				if(document.getElementById("data1").value=="")
  				{
			  		alert("Please select the to date");
  					return false;
  				}
				return true;
  				//return datevalidate();
  		  }
  		 function datevalidate()
		 {
		 	var date1=document.getElementById("data").value;
			var date2=document.getElementById("data1").value;
			var dm1,dd1,dy1,dm2,dd2,dy2;
			dy1=date1.substring(0,4);
			dy2=date2.substring(0,4);
			dm1=date1.substring(5,7);
			dm2=date2.substring(5,7);
			dd1=date1.substring(8,10);
			dd2=date2.substring(8,10);
			var date=new Date();
			var month=date.getMonth()+1;
			var day=date.getDate();
			var year=date.getFullYear();
			if(dy1>year || dy2>year)
			{
				alert("selected date should not be greater than todays date");
				document.getElementById("data").value="";
				document.getElementById("data1").value="";
				document.getElementById("data").focus;
				return false;
			}
			else if(year==dy1 && year==dy2)
			{
	  			if(dm1>month || dm2>month)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			if(dm1==month)
			{
				if(dd1>day || dd2>day)
				{
					alert("selected date should not be greater than todays date");
					document.getElementById("data").value="";
					document.getElementById("data1").value="";
					document.getElementById("data").focus;
					return false;
				}
			}
			
			return true;
		}

  	</script>
  				

			<table border="0" width="100%">
			
			<tr bgcolor="lightgrey">
			<td align="right">
			  <input type="text" id="data" name="data" value="<%=fromdate1 %>" size="15" class="formElement" readonly/>
  			</td>
  			<td align="left">
				<input type="button" name="From Date" value="From Date" id="trigger" class="formElement" >
				<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",     // the date format
      			button      : "trigger"       // ID of the button
    			}
  				);	
				</script>
			</td>
			<td align="right">
			  	<input type="text" id="data1" name="data1" value="<%=todate1 %>" class="formElement"  size="15" readonly/></td><td align="left">
  			  	<input type="button" name="To Date" value="To Date" id="trigger1" class="formElement" >
				<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data1",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",    // the date format
      			button      : "trigger1"       // ID of the button
    			}
  				);
				</script>
			</td>
			<td colspan="3">
				<input type="submit" name="submit" id="submit" value="submit" class="formElement" >
			</td>
		</tr>
		</form>
		</table>
		<!-- if date range is not requred please remove this code start from this comment to -->
		</td></tr>
	




<tr><td colspan="8">
<table  border="0" width="100%">
	<tr><td colspan="5" align="center" bgcolor="">
		<font size="3" color="maroon"><b>Crane No <%=cranemodno%> Bypass (Override) Key Report from <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></font>
 		<div align="right">
         		<a href="#" onclick="javascript:window.print();" title="Print Report">
         		<img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="Exceloverkey.jsp?vehcode=<%=vehcode%>&cranemodno=<%=cranemodno %>&fromdate=<%=fromdate%>&todate=<%=todate%>&vehregno=<%=vehregno%>" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
				<font size="2">Date : <% Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
				String sdt = fmt.format(new java.util.Date());
				out.print(sdt); %>
		</div>
	</td></tr>
</table>
</td></tr>
<tr><td colspan="8">
<table  border="0" width="100%"  class="sortable">
<tr bgcolor="lightgrey">
	<th align="center"><b><font size="2" Color="black">Sr.No</th>
	<th align="center"><b><font size="2" Color="black">Crane Reg No.</th>
	<th align="center"><b><font size="2" Color="black">Crane Model No.</th>
	<th align="center"><b><font size="2" Color="black">Start Date Time</th>
	<th align="center"><b><font size="2" Color="black">End Date Time </th>
	
</tr>
<%
	int diff=0;
	boolean flag = false;
		int i=1;
		String sql="select * from t_veh"+vehcode+" where TheFiledTextFileName in('KE','KD') and TheFieldDataDate >='"+fromdate+" 00:00:00' and TheFieldDataDate <='"+todate+" 23:59:59' order by concat(TheFieldDataDate,TheFieldDataTime) asc ";
		//out.print(sql);
		rst=st.executeQuery(sql);
		while(rst.next())
		{
			String stamp=rst.getString("TheFiledTextFileName");
			if(stamp.equals("KE"))
			{
			java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime"));
				Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
				thedate = formatter1.format(ShowDate1);
				//String thedata=rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime");
				if(rst.next())
				{
					stamp=rst.getString("TheFiledTextFileName");
					if(stamp.equals("KD"))
					{
					java.util.Date ShowDate2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime"));
					Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
					thedate1 = formatter2.format(ShowDate2);
					//out.print(thedate1);
					}
				}
				else
				{
					thedate1="-";
				}
			
						//String thedate1=rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime");
						%>
						<tr>
							<td align="center"><font size="2"><%=i%></td>
							<td align="center"><font size="2"><%=vehregno%></td>
							<td align="center"><font size="2"><%=cranemodno%></td>
							<td align="center"><font size="2"><%=thedate%></td>
							<td align="center"><font size="2"><%=thedate1%></td>
					
							
						</tr>
						<%
						i++;
			}
			else
			{
				
			}
						
		}
	}catch(Exception e)
	{
		out.print("Exception "+e);
	}
	finally
	{
		conn.close();
	}
%>
</form>
</table>
</td></tr>
</table>			
			
			
			
			
			
			
			
		
			</jsp:useBean>
        <%@ include file="footernew.jsp" %>
   
