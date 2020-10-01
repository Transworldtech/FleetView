<%@ include file="headernew.jsp" %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<script type="text/javascript">


function gotoPrint(divName)  
{  
	  
    var printContents = document.getElementById(divName).innerHTML; 
    var originalContents = document.body.innerHTML;       
    document.body.innerHTML = printContents;  
    window.print();
    document.body.innerHTML = originalContents;  
}

function confirmDelete()
{
	  //alert("a");
	  var  agree=confirm("Are you sure you want to Deactivate this ?");
	  //alert("B") ;
	  if(agree)
	  {
		 //alert("C") ;	
		 return true ;
	  }	  	   
	  else
	  {
		 //alert("D") ; 
	     return false ;
	  }	  	   
}


function getFTPImage(ftpFile)		
{			
	try			
	{
		window.open('showCleanerDocs.jsp?ftpFile='+ftpFile+'','mywindow','width=1000, height=850, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes');
	}
	catch(e)			
	{
		alert(e);			
	}
}
</script>
		
	<!-- 	<div style="margin-left: 100px;margin-right: 100px;" align="center">
	</div>

 <div align="center" >
<form name="drivermgt" name="drivermgt" method="get">
<div id="table1" style="text-align: center; margin-left: 20px;margin-right: 100px;"> -->
<%-- <%! 
Connection conn,conn1;
String data1,sql,sql1,data2,jcode,origin,destination,startdate,ck;
Statement st,st1,st2;
%> --%>

		<%-- <table border="0" style="width: 1300px;"  class="stats">
		<tr><td><div class="bodyText" align="center"><font face="Arial" size="4">Report For Driver Management</font></div></td></tr>
		<tr>
		
		<td>
		<div class="bodyText" align="left">
		<font face="Arial" size="2"><a href="driverentrynew.jsp" style="font-weight: bold; color: blue; " >Add New Driver</a></font>
		</div>
		<div class="bodyText" align="right">
                           <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
                        
     
                           <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a>
      
                           <a href="exceldriver.jsp"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
                           <%=fleetview.PrintDate()%>
                           </div>
		</td>
		</tr>
		</table> --%>
      <%--   <%
        String Save=request.getParameter("save");
        String Save1=request.getParameter("save1");
        ck = request.getParameter("ck");
        if(ck != null)
        {
        	%> <script type="text/javascript">  alert("Sorry the DriverID you have enterd is already Exists , please enter another ID  ");</script>      <% 
        }
        if(Save1!=null)
        {
        	%>
        	<script type="text/javascript">
        	alert("Record Saved Successfully");
        	window.location="Reportfordriver.jsp";
        	
        	</script>
        	<%
        }
        if(Save!=null)
        {
        	%>
        	<script type="text/javascript">
        	alert("Record Saved Successfully");
        	window.location="Reportfordriver.jsp";
        	
        	</script>
        	<%
        }
        %> --%>
        
       <!--  <table  align="center" style="width: 100%;"><tr><td align="center">
		<table align="center" class="sortable" style="width: 100%;">
		<tr>
		<th>Sr.</th>
<th>Edit/Deactivate</th>

<th>Driver Id</th>
<th>Driver Name</th>

<th>Address</th>
<th>DOB</th>
<th>MobileNo</th>


<th>Transporter</th>
<th>Status</th>
<th>Reason</th>


<th>DOB Proof</th>
<th>Address Proof</th>

<th>Entry By</th>
		</tr> -->
	<%-- 	<%
		String GPName="",Transporter="",mobno="",dobfile="",newdobfile="",addfile="",newaddfile="",licfile="",newlicfile="";
		String[] dobfile1,addfile1,licfile1;
		
		String expirydate="";
		String RejectedBy=session.getAttribute("mainuser").toString();
		System.out.println(" User mainuser " +RejectedBy);


		String usertypevalue=session.getAttribute("usertypevalue").toString();//
		System.out.println(" User Suyog " +usertypevalue);
		
		
		String typeofuser=session.getAttribute("TypeofUser").toString();//Group
		System.out.println(" User Suyog " +typeofuser);

		String SrchTrans="";
		System.out.println(usertypevalue+" User "+typeofuser);
		
		if(typeofuser.equalsIgnoreCase("Group"))
		{System.out.println("IN Group ");
			sql="SELECT VehRegno FROM db_gps.t_group WHERE GPName='"+usertypevalue+"' group by VehRegno";
			System.out.println("*****8     "+sql);
			ResultSet rstGrp=st2.executeQuery(sql);
			SrchTrans="(";
			int k = 0;
			while(rstGrp.next())
			{
				SrchTrans=SrchTrans+"'"+rstGrp.getString("VehRegno")+"',";
				k++;
			}
			SrchTrans=SrchTrans.substring(0,SrchTrans.length()-1)+")";

		}
		else
		{
			System.out.println("IN Else ");
			SrchTrans="('"+usertypevalue+"')";	
		}
		
		
	
		
		
	int i=1;
	sql="select * from db_gps.t_drivers where Owner in "+SrchTrans+" order by DriverID ";
	System.out.println("sql is"+sql);
	ResultSet rs=st.executeQuery(sql);

	while(rs.next())
	{
		mobno=rs.getString("MobileNo");
		
		expirydate=rs.getString("licenseexpdate");
		dobfile=rs.getString("DOBFile");

		addfile=rs.getString("AddressFile");
		System.out.println("dobfile" +dobfile);
		licfile=rs.getString("licensefile");
		System.out.println("licensefile" +licfile);

	System.out.println("Dob file length"+dobfile.length());
	
	if(expirydate==null)
	{
		expirydate="0000-00-00";
	}
	else
	{
		expirydate=rs.getString("licenseexpdate");
	}
	
	
	if(dobfile.equals("") || dobfile.length()==1)
	{
		newdobfile=dobfile;
	}
	else
	{
		dobfile1=dobfile.split("_");
		newdobfile=dobfile1[1];

	}
	System.out.println("newdobfile"+newdobfile);
	
	if(addfile.equals("") || addfile.length()==1)
	{
		newaddfile=addfile;
	}
	else
	{
		addfile1=addfile.split("_");
		newaddfile=addfile1[1];

	}
	System.out.println("newaddfile"+newaddfile);
	

	if(licfile.equals("") || licfile.length()==1)
	{
		newlicfile=licfile;
	}
	else
	{
		licfile1=licfile.split("_");
		newlicfile=licfile1[1];

	}
	System.out.println("newlicfile"+newlicfile);

	%>



	<tr>
	<td align="right"><div align="right"><%=i%></div></td>
	<td style="width: 2%"><a href="driveredit.jsp?clean=true&id=<%=rs.getString("DriverID")%>&name=<%=rs.getString("DriverName")%>&add=<%=rs.getString("Address1") %>&Gender=<%=rs.getString("Gender")%>&dob=<%=rs.getString("DOB")%>&mobno=<%=rs.getString("MobileNo")%>&fathernm=<%=rs.getString("FatherNm")%>&owner=<%=rs.getString("Owner")%>&status=<%=rs.getString("ACTIVESTATUS") %>&gpname=<%=rs.getString("GPNAME") %>&entryby=<%=rs.getString("EntryBy") %>&Address2=<%=rs.getString("Address2")%>&DOiN=<%=rs.getString("DateOfInduction")%>&DProof=<%=newdobfile%>&Aproof=<%=newaddfile%>&LProof=<%=newlicfile%>&marrid=<%=rs.getString("Marital")%>&licno1=<%=rs.getString("licenseno")%>&licexp=<%=expirydate%>&dreason=<%=rs.getString("DeactReason")%>"   style="font-weight: bold; color: black; "><img src="images/edittt1.jpeg" width="20px" height="18px" style="border-style: none"></img></a>
	
	/<a href="driver_status_change.jsp?rid=<%=rs.getString("Rid")%>&driverid=<%=rs.getString("DriverID")%>&name=<%=rs.getString("DriverName")%>&add=<%=rs.getString("Address1") %>&Gender=<%=rs.getString("Gender")%>&dob=<%=rs.getString("DOB")%>&mobno=<%=rs.getString("MobileNo")%>&fathernm=<%=rs.getString("FatherNm")%>&owner=<%=rs.getString("Owner")%>&status=<%=rs.getString("ACTIVESTATUS") %>&gpname=<%=rs.getString("GPNAME") %>&entryby=<%=rs.getString("EntryBy") %>&Address2=<%=rs.getString("Address2")%>&DOiN=<%=rs.getString("DateOfInduction")%>&DProof=<%=newdobfile%>&Aproof=<%=newaddfile%>&marrid=<%=rs.getString("Marital")%>&dreason=<%=rs.getString("DeactReason")%>&licno1<%=rs.getString("licenseno")%>&licexp<%=rs.getString("licenseexpdate")%>" onClick="return confirmDelete();">
		
	<img src="images/delete.jpeg" width="15px" height="15px" style="border-style: none" ></img>
	
	</a>
	
    	
	
	</td>
	<td align="right"><div align="right"><%=rs.getString("DriverID") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("DriverName") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("Address1") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("DOB") %></div></td>
	<%
	if(mobno=="" || mobno.equals("") || mobno.equals("-"))
		{
%>
	<td align="left"><div align="left">NA</div></td>

<%			
		}
	else{
		%>
			<td align="right"><div align="right"><%=mobno%></div></td>
		
		<%
		
	}
	 %>
	

	<td align="left"><div align="left"><%=rs.getString("Owner") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("ACTIVESTATUS") %></div></td>
	
		<%
		
		String Dreason=rs.getString("DeactReason");
		if(Dreason=="" || Dreason.equals("") ||  Dreason.equals("-"))
		{
		
	
	%>
					<td align="left" style="width: 20px"><div align="left">NA</div></td>
	
	<%
	}
	else{
		%>
				<td align="left" style="width: 10%">
				<div align="left"><%=Dreason %></div></td>
				<%} %>
	
	
	
	<%
	if(newdobfile=="" || newdobfile.equals("") ||  newdobfile.equals("-"))
	{
	%>
					<td align="left"><div align="left">NA</div></td>
	
	<%
	}
	else{
		%>
				<td align="left">
				
				<div align="left"><a href="#" onclick="getFTPImage('<%=rs.getString("DOBFile")%>')">
					<%=newdobfile %></a>
				
				
				
				
				
				
				
				</div></td>
		
		<%
	}
	%>
	<%
	if(newaddfile=="" || newaddfile.equals("") ||  newdobfile.equals("-"))
	{
	%>
					<td align="left"><div align="left">NA</div></td>
	
	<%
	}
	else{
		%>
	<td align="left"><div align="left">
	<a href="#" onclick="getFTPImage('<%=rs.getString("AddressFile")%>')">
					
	
	<%=newaddfile%></a></div></td>
		
		<%
	}
	%>
	
	
	<td align="left"><div align="left"><%=rs.getString("EntryBy") %></div></td>
	</tr>
	<%
	i++;
     }%> 
         
      </table></td></tr></table>
        </div>
         </form>
         </div>
         <br>
         <%
}
catch(Exception e)
{
	//out.print("Exception "+e);
	e.printStackTrace();
}
finally
{
	try
	{
		conn.close();conn1.close();
	}catch(Exception e)
	{e.printStackTrace();}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{e.printStackTrace();}
}
%>

</jsp:useBean>
<%@ include file="footernew.jsp" %>	
 --%>

 
 <%! 
Connection conn,conn1;
String data1,sql,sql1,data2,jcode,origin,destination,startdate,ck;
Statement st,st1,st2;
%>
 
 <% 
 Class.forName(MM_dbConn_DRIVER); 
 conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
 String GPName="",Transporter="",mobno="",dobfile="",newdobfile="",addfile="",newaddfile="",licfile="",newlicfile="";
	String[] dobfile1,addfile1,licfile1;
	
	String expirydate="";
	String RejectedBy=session.getAttribute("mainuser").toString();
	System.out.println(" User mainuser " +RejectedBy);

   // String typeofuser="xyz";
	String usertypevalue=session.getAttribute("usertypevalue").toString();//
	System.out.println(" User Suyog-------------- " +usertypevalue);
	
	
	String typeofuser=session.getAttribute("TypeofUser").toString();//Group
	System.out.println(" User Suyog****************** " +typeofuser);

	String SrchTrans="";
	System.out.println(usertypevalue+" User "+typeofuser);
	Statement st3=conn.createStatement();
	if(typeofuser.equalsIgnoreCase("Group"))
		
	{
		typeofuser="GROUP";
		System.out.println("IN Group ");
		sql="SELECT VehRegno FROM db_gps.t_group WHERE GPName='"+usertypevalue+"' group by VehRegno";
		System.out.println("*****8     "+sql);
		ResultSet rstGrp=st3.executeQuery(sql);
		//SrchTrans="(";
		int k = 0;
		while(rstGrp.next())
		{
			SrchTrans+="'"+rstGrp.getString("VehRegno")+"',";
			k++;
		}
		//SrchTrans+=")";
		SrchTrans=SrchTrans.substring(0,SrchTrans.length()-1);

	}
	else
	{
		//typeofuser="Transporter";
		//System.out.println("IN Else------------- "+typeofuser);
		//usertypevalue=usertypevalue;	
	}           // typeofuser


 String todate=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date());
 
 
 %>
 
 <table border="0" style="width: 1300px;"  class="stats">
		<tr><td><div class="bodyText" align="center"><font face="Arial" size="4">Driver Master Report</font></div></td></tr>
		<tr>
		
		<td>
		<div class="bodyText" align="left">
		<font face="Arial" size="2"><a href="driverentrynew.jsp" style="font-weight: bold; color: blue; " >Add New Driver</a></font>
		</div>
		<div class="bodyText" align="right">
                        <!--    <input type="hidden" id="tableHTML" name="tableHTML" value="" />   -->
                        
     
                           <!-- <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
                           <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a>
      
                           <a href="exceldriver.jsp"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a> -->
                           <%=todate%> 
                           </div>
		</td>
		</tr>
		</table>
 	
 	<div id="reportData1">
<iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birttest/frameset?__report=DriverEntry_report.rptdesign&Trans=<%=usertypevalue%>&Typeofuser=<%=typeofuser%>&__showtitle=false"> 
<!-- <iframe id="myIframe" width="100%" height="850px" src=""> --> 
</iframe> 
 	</jsp:useBean>
 
<%--  <%@ include file="footernew.jsp" %>	 --%>