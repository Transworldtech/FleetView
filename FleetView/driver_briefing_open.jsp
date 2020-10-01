<%@ include file="headernew.jsp" %>
<%//System.out.println("---------check1111111 "); %>

 
<%@page import="sun.util.resources.CalendarData_mk"%><jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%//System.out.println("-check "); %>
<%!
Connection conn, con1;
Statement st,st1, st2,st3;
%>
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
          document.TrainerRun.action ="excel.jsp";
          document.forms["TrainerRun"].submit();
         
}

</script>
<%
	
try{	
	
	//System.out.print("Trainer History Details View");
	
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1 = conn.createStatement();
	st2=conn.createStatement();
	st3=conn.createStatement();
	int UType=0;
	final String UserTypeValue =(String) session.getAttribute("usertypevalue");
	System.out.println("UserTypeValue : "+UserTypeValue);
	String Pdate1="";
	int i = 0;
	//date1 = "2012-06-01 00:00:00";
	//date2 = "2012-06-30 23:59:59";
	
	String TrainerNm = "TrainerNm";
	//System.out.printf(date1+" : "+date2+" : "+TrainerNm);
	String ChType = "ChType",sql1="",DriverId="";
	String datenew1,datenew2, vehcode, vehregno,tbname,sql11="",owner,km,rating,from,to,ndcount,FrDate,ToDate;
	int os,ra,rd,cd,nd,tripid=0;
	String oscount,racount,osdur,rdcount,cdcount,FrDate2,ToDate2;
	String sql="",sql2="",sql3="",Transpo="",VehRegNo="";
int i1=0,i2=0;
	 Calendar cal1=Calendar.getInstance();
  
	 
		
		
     
  
	//category = "Secondary";
	//String typeC = request.getParameter("typeC");

		//if(typeC == null || typeC.equalsIgnoreCase("null"))
		//{
		//	typeC = "Transporter";
		//}

		
		//System.out.println("Type    "+typeC);
		//System.out.println("Date1    "+date1+ "  Date2     "+date2);
		String DriverIdList="";
		/* if(UserTypeValue.equalsIgnoreCase("ALL"))
			{
			sql="SELECT DriverID FROM db_gps.t_drivers";
			} */
		
			sql="SELECT DriverID FROM db_gps.t_drivers where (Owner='"+UserTypeValue+"' or GPNAME='"+UserTypeValue+"') and Activestatus='Active'";			
			
		
		ResultSet rst=st.executeQuery(sql);
		
		System.out.println("Query for Drivers id "+sql);		
		int l=0;
		while(rst.next())
		{
			if(l==0)
			{
				DriverIdList="'"+rst.getString("DriverID")+"'";	
			}
			else{
				DriverIdList=DriverIdList+",'"+rst.getString("DriverID")+"'";}	
			l++;
		}
		//System.out.println(TripIdList);
			
		
			if(UserTypeValue.equalsIgnoreCase("Castrol")||UserTypeValue.equalsIgnoreCase("BS"))
		{UType=1;}
			else if(UserTypeValue.equalsIgnoreCase("Castrol"))
		{UType=2;}
				else
		{UType=3;}
		
			%>

<br>
		<table border="0" width="100%" class="stats">
			<tr>
				<td><h2><a id="C2"></a></h2>
				<div align="center"><font size="2"> <B>
				Open Briefing </B> </font></div>
				</td>
			</tr>
		</table>
<p>
<a href="#C1">View open debriefing</a>

</p>
			
			 <table border="1"  class="sortable" width="100%"  style="text-align: center;">
             
            <tr>
           	<th>Sr.No</th>        	
			<th>Driver Name</th>
			<th>Driver Id</th>
			<th>Transporter</th>
			<th>Briefing Date</th>
			<th>Brief Id</th>
			<th>Trip Id</th>
			<th>Status</th>
			</tr>			
			<%			
		sql1="SELECT Driverid,Briefid,DriverName,tripid,brifdate,startplace,endplace,VehRegNo,Transporter,VehType,CleanerId,CleanerName,updateddt FROM db_gps.t_briefing WHERE Driverid IN ("+DriverIdList+") AND Status='open' order by brifdate desc";
			ResultSet rst1=st1.executeQuery(sql1);
		System.out.println("sql1");
		i1 = 1;
		while(rst1.next())
		{
			String Date11="",dateret="";
%>			
	<tr>
	<td align="right"><div align="right"><%=i1 %></div></td>
	<td align="left"><div align="left">
		
	<a href= "briefing_page.jsp?driverid=<%=rst1.getString("Driverid")%>&briefId=<%=rst1.getString("Briefid")%>&drivername=<%=rst1.getString("DriverName")%>&TripId=<%=rst1.getString("tripid") %>&BrifDate=<%=rst1.getString("brifdate") %>&startP=<%=rst1.getString("startplace") %>&endP11=<%=rst1.getString("endplace") %>&veh=<%=rst1.getString("VehRegNo") %>&transporter=<%=rst1.getString("Transporter") %>&VehType=<%=rst1.getString("VehType")  %>&CleanerId=<%=rst1.getString("CleanerId")%>&CleanerName=<%=rst1.getString("CleanerName")%>" target="_blank" >
	
	<%=rst1.getString("DriverName") %></a></div></td>
	<td align="left"><div align="Right"><%=rst1.getString("Driverid")%></div></td>
	<td align="left"><div align="left"><%=rst1.getString("Transporter") %></div></td>
	<%
	//try{
		//Date11=rst1.getString("brifdate");
		//dateret=new SimpleDateFormat("dd-MMM-yyyy hh:MM:ss ").format(new SimpleDateFormat());
		//System.out.println("brifdate   "  +Date11);
	   //  Date11=new SimpleDateFormat("dd-MMM-YYY HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(Date11));
	
	//}
	//catch(Exception e)
	//{
	///	Date11="-";
	//}
	
	try{
	Date11=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst1.getString("brifdate")));
	}
	catch(Exception e)
	{
	e.printStackTrace();	
	Date11="-";
	}
	 %>
	 
	 
	 
	<td align="left"><div align="Right"><%=Date11%></div></td>
	<td align="left"><div align="Right"><%=rst1.getString("Briefid")%></div></td>
	<td align="left"><div align="Right"><%=rst1.getString("tripid")%></div></td>
	<td align="left"><div align="left">Open Briefing</div></td>
	</tr>
<%
i1++;
		} %>




</table>
<table border="0" width="100%" class="stats">
			<tr>
				<td><h2><a id="C1"></a></h2>
				<div align="center"><font size="2"> <B>
				Open Debriefing </B> </font></div>
				</td>
			</tr>
		</table>


<p>
<a href="#C2">View open briefing</a>
</p>



 <table border="1"  class="sortable" width="100%"  style="text-align: center;">
             
            <tr>
           	<th>Sr.No</th>        	
			<th>Driver Name</th>
			<th>Driver Id</th> 
			<th>Transporter</th>
			<th>DeBriefing Date</th>
			<th>DeBrief Id</th>
			<th>Trip Id</th>
			<th>Status</th>
			</tr>			
			<%			
		sql2="SELECT driverid,debriefid,Briefid,DriverName,tripid,Debriefdate,Transporter,updateddt FROM db_gps.t_debriefing WHERE Driverid IN ("+DriverIdList+") AND Status='open' ORDER BY `t_debriefing`.`Debriefdate` DESC ";
		ResultSet rst2=st2.executeQuery(sql2);
		System.out.println("sql2 "+sql2);
		i2 = 1;
		while(rst2.next())
		{
			String Date12="";
			//System.out.println("Sql 3 : "+rst2.getString("Driverid")+"  "+rst2.getString("DriverName") );
			System.out.println(rst2.getString("driverid")+" Brif Id "+rst2.getString("Briefid")+" Driver NAme "+rst2.getString("DriverName")+" Trip Id "+rst2.getString("tripid")+"  Date ");
			sql3="SELECT Transporter,VehRegNo,probenddate FROM db_gps.t_briefing WHERE Driverid='"+rst2.getString("Driverid")+"' AND Debrifstatus='debriefed' and DeBrifingStatus='open' ORDER BY t_briefing.updateddt DESC";
			System.out.println("Sql 3 : "+sql3);	
		
			ResultSet rst3=st3.executeQuery(sql3);
				
				if(rst3.next())
				{
					Transpo=rst3.getString("Transporter");
					VehRegNo=rst3.getString("VehRegNo"); 
					Pdate1=rst3.getString("probenddate");
					System.out.println("If : "+rst3.getString("probenddate")+"  "+rst3.getString("VehRegNo")+"  "+rst3.getString("Transporter"));	
				}		
%>			
	<tr>
	<td align="right"><div align="right"><%=i2 %></div></td>
	<td align="left"><div align="left">

	
		
	<a href= "driver_debriefing_Update.jsp?driverid=<%=rst2.getString("driverid")%>&briefid=<%=rst2.getString("Briefid")%>&drivername=<%=rst2.getString("DriverName")%>&TripId=<%=rst2.getString("tripid") %>&PDate=<%=Pdate1 %>&veh=<%=VehRegNo %>&transporter=<%=Transpo %>" target="_blank" >
	
	
	
	<%=rst2.getString("DriverName") %></a></div></td>
	<td align="left"><div align="Right"><%=rst2.getString("Driverid")%></div></td>
	
	<td align="left"><div align="left"><%=rst2.getString("Transporter") %></div></td>
	<%
	try{
		Date12=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst2.getString("Debriefdate")));
	}
	catch(Exception e)
	{
		e.printStackTrace();
		Date12="-";
	}
	%>
	
	<td align="left"><div align="Right"><%=Date12%></div></td>
	<td align="left"><div align="Right"><%=rst2.getString("debriefid")%></div></td>
	<td align="left"><div align="Right"><%=rst2.getString("tripid")%></div></td>
	<td align="left"><div align="left">Open DeBriefing</div></td>
	</tr>
<%
i2++;
		} %>

</table>




















		<%	
			
	}
	catch(Exception e)
	{
		out.print("Exception "+e);
	}
	finally
	{
		try
		{
		conn.close();
		} 
		catch(Exception e){}
		try
		{
		con1.close();
		}
		catch(Exception e){}
		try
		{
		fleetview.closeConnection1();
		}
		catch(Exception e){}
		try
		{
		fleetview.closeConnection();
		}
		catch(Exception e){}
	}


	
%>

</jsp:useBean>
<br>
<%@ include file="footernew.jsp"%>
