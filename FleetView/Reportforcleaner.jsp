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


function getFTPImage(ftpFile)		{			try			{
	window.open('showCleanerDocs.jsp?ftpFile='+ftpFile+'','mywindow','width=1000, height=850, toolbar=false, location=false, status=no, menubar=no, resizable=no, scrollbars=yes');
}
catch(e)			{
	alert(e);			}
}
</script>
		
		<div style="margin-left: 100px;margin-right: 100px;" align="center">
	</div>

<div align="center" >
<form name="cleanermgt" name="cleanermgt" action="insertnewcleaner.jsp" method="get">
<div id="table1" style="text-align: center; margin-left: 100px;margin-right: 100px;">
<%! 
Connection conn,conn1;
String data1,sql,sql1,data2,jcode,origin,destination,startdate;
Statement st,st1,st2;
%>
<%
try
{
	Class.forName(MM_dbConn_DRIVER);
		conn = fleetview.ReturnConnection();
		conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st1=conn1.createStatement();
		st2=conn1.createStatement();
		st=conn.createStatement();

		String sql="",sql1="";
%>
		<table border="0" style="width: 850px;"  class="stats">
		<tr><td><div class="bodyText" align="center"><font face="Arial" size="4">Report For Cleaner Management</font></div></td></tr>
		<tr>
		
		<td>
		<div class="bodyText" align="left">
		<font face="Arial" size="2"><a href="cleanerentry.jsp" style="font-weight: bold; color: blue; " >Add New Cleaner</a></font>
		</div>
		<div class="bodyText" align="right">
	         <input type="hidden" id="tableHTML" name="tableHTML" value="" />  
	      
	
	         <a href="#" style="font-weight: bold; color: black; " onclick="gotoPrint('table1');">
	         <img src="images/print.jpg" width="15px" height="15px" style="border-style: none"></img></a>
	
	         <a href="excelcleaner.jsp"  title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>
	         <%=fleetview.PrintDate() %>
	         </div>
		</td>
		</tr>
		</table>
        <%
        String Save=request.getParameter("save");
        String Save1=request.getParameter("save1");
        if(Save1!=null)
        {
        	%>
        	<script type="text/javascript">
        	alert("Record Saved Successfully");
        	window.location="Reportforcleaner.jsp";
        	
        	</script>
        	<%
        }
        if(Save!=null)
        {
        	%>
        	<script type="text/javascript">
        	alert("Record Saved Successfully");
        	window.location="Reportforcleaner.jsp";
        	
        	</script>
        	<%
        }
        %>
        <table width="100%" align="center" style="width: 850px;"><tr><td align="center">
		<table align="center" class="sortable" style="width: 850px;">
		<tr>
		<th>Sr.</th>
<th>Edit</th>

<th>Cleaner Id</th>
<th>Cleaner Name</th>

<th>Address</th>
<th>DOB</th>
<th>MobileNo</th>


<th>Transporter</th>
<th>Status</th>
<th>DOB Proof</th>
<th>Address Proof</th>

<th>Entry By</th>
		</tr>
		<%
		String GPName="",Transporter="",mobno="",dobfile="",newdobfile="",addfile="",newaddfile="";
		String[] dobfile1,addfile1;
		String RejectedBy=session.getAttribute("mainuser").toString();
		System.out.println(" User mainuser " +RejectedBy);


		String usertypevalue=session.getAttribute("usertypevalue").toString();
		System.out.println(" User Suyog " +usertypevalue);
		
		
		String typeofuser=session.getAttribute("TypeofUser").toString();
		System.out.println(" User Suyog " +typeofuser);

		String SrchTrans="";
		System.out.println(usertypevalue+" User "+typeofuser);
		String loginusr=session.getAttribute("mainuser").toString();
		String usrrole="";
	String sqlsub="select TypeofUser from db_gps.t_security where Username='"+loginusr+"'";
	System.out.println("usr role query     " +sqlsub);

	ResultSet rssub=st.executeQuery(sqlsub);
	if(rssub.next())
	{
		usrrole=rssub.getString("TypeofUser");	
	}
	System.out.println("usr role is     " +usrrole);
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
		 if(usrrole.equalsIgnoreCase("Subuser"))
		 {
			 System.out.println("IN Group ");
				sql="SELECT VehRegno FROM db_gps.t_group WHERE GPName='Castrol' group by VehRegno";
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
		 if(!(typeofuser.equalsIgnoreCase("Group")) && !(usrrole.equalsIgnoreCase("Subuser")))
		 {
			System.out.println("IN Else ");
			SrchTrans="('"+usertypevalue+"')";	
		}
		
		
	
		
		
	int i=1;
	sql="select * from db_gps.t_cleaners where Owner in "+SrchTrans+" order by Cleanerid ";
	System.out.println("sql is"+sql);
	ResultSet rs=st.executeQuery(sql);

	while(rs.next())
	{
		mobno=rs.getString("MobileNo");
		
		
		dobfile=rs.getString("DOBFile");

		addfile=rs.getString("AddressFile");
	System.out.println("Dob file length"+dobfile.length());
	
	
	
	if(dobfile.equals("") || dobfile.length()==0)
	{
		newdobfile=dobfile;
	}
	else
	{
		dobfile1=dobfile.split("_");
		newdobfile=dobfile1[1];

	}
	System.out.println("newdobfile"+newdobfile);
	
	if(addfile.equals("") || addfile.length()==0)
	{
		newaddfile=addfile;
	}
	else
	{
		addfile1=addfile.split("_");
		newaddfile=addfile1[1];

	}
	System.out.println("newaddfile"+newaddfile);

	%>



	<tr>
	<td align="right"><div align="right"><%=i%></div></td>
	<td style="width: 2%"><a href="cleaneredit.jsp?clean=true&id=<%=rs.getString("Cleanerid")%>&name=<%=rs.getString("Cleanername")%>&add=<%=rs.getString("Address1") %>&Gender=<%=rs.getString("Gender")%>&dob=<%=rs.getString("DOB")%>&mobno=<%=rs.getString("MobileNo")%>&fathernm=<%=rs.getString("FatherNm")%>&owner=<%=rs.getString("Owner")%>&status=<%=rs.getString("Status") %>&gpname=<%=rs.getString("GPname") %>&entryby=<%=rs.getString("Entryby") %>&Address2=<%=rs.getString("Address2")%>&DOiN=<%=rs.getString("DateOfInduction")%>&DProof=<%=newdobfile%>&Aproof=<%=newaddfile%>&marrid=<%=rs.getString("Marital")%>&driver_license=<%=rs.getString("driver_license")%>&license_type=<%=rs.getString("license_type")%>&how_long=<%=rs.getString("how_long")%>&Education=<%=rs.getString("Education")%>" style="font-weight: bold; color: black; "><img src="images/edittt1.jpeg" width="20px" height="18px" style="border-style: none"></img></a></td>
	<td align="right"><div align="right"><%=rs.getString("Cleanerid") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("Cleanername") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("Address1") %></div></td>
	<td align="left"><div align="left"><%=rs.getString("DOB") %></div></td>
	<%
	if(mobno=="" || mobno.equals(""))
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
	<td align="left"><div align="left"><%=rs.getString("Status") %></div></td>
	<%
	if(newdobfile=="" || newdobfile.equals(""))
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
	if(newaddfile=="" || newaddfile.equals(""))
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
	
	
	<td align="left"><div align="left"><%=rs.getString("Entryby") %></div></td>
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

