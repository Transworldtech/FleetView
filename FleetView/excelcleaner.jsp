<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<%@page import="java.util.Date"%>
<% response.setContentType("application/vnd.ms-excel");
String filename=session.getAttribute("user").toString();
int cnt= 0;
cnt = filename.indexOf(' ');
if(cnt>1)
{
	filename = filename.substring(0,cnt)+"_my_report.xls";
}
else
{
	filename = filename=session.getAttribute("user").toString()+"_my_report.xls";
}
System.out.println("Filename"+filename);
response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
  <%@ include file="Connections/conn.jsp" %>

<%! 
Connection conn,conn1;
String data1,sql,sql1,data2,jcode,origin,destination,startdate;
Statement st,st1,st2;
%>

<%
try{
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st1=conn1.createStatement();
st2=conn1.createStatement();
st=conn.createStatement();

String sql="",sql1="";
String Save=request.getParameter("save");
if(Save!=null)
{
	%>
	<script type="text/javascript">
	alert("Record Save Successfully");
	</script>
	<%
}
%>


<body>
<form id="cleanermgt" name="cleanermgt" action="insertnewcleaner.jsp">
<div style="margin-left: 400px">
		<table border="0" align="center">
		<tr><td align="center"><div align="center"><font face="Arial" size="3"><b>Report For Cleaner Management</b></font></div></td></tr>
		
</table></div>
<div style="margin-left: 100px;height: 300px;overflow:scroll">
<br></br>
<table border="1" class="sortable" style="width: 975px">
<tr>
<th>Sr.</th>

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
try{
	
	
	String GPName="",Transporter="",mobno="",dobfile="",addfile="",newdobfile="",newaddfile="";
	String[] dobfile1,addfile1;


		
		String RejectedBy=session.getAttribute("mainuser").toString();
		

		String usertypevalue=session.getAttribute("usertypevalue").toString();
		System.out.println(" User ");
		String typeofuser=session.getAttribute("TypeofUser").toString();
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
sql="select * from db_gps.t_cleaners where Owner in "+SrchTrans+" order by Cleanerid ";
ResultSet rs=st.executeQuery(sql);
while(rs.next())
{
	
	
	mobno=rs.getString("MobileNo");
	
	dobfile=rs.getString("DOBFile");

	addfile=rs.getString("AddressFile");



if(dobfile.equals("") || dobfile.length()==0)
{
	newdobfile=dobfile;
}
else
{
	dobfile1=dobfile.split("_");
	newdobfile=dobfile1[1];

}

if(addfile.equals("") || addfile.length()==0)
{
	newaddfile=addfile;
}
else
{
	addfile1=addfile.split("_");
	newaddfile=addfile1[1];

}
%>



<tr>
<td align="right"><%=i%></td>
<td align="right"><%=rs.getString("Cleanerid") %></td>
<td align="left"><%=rs.getString("Cleanername") %></td>
<td align="left"><%=rs.getString("Address1") %></td>
<td align="left"><%=rs.getString("DOB") %></td>
<%
if(mobno=="" || mobno.equals(""))
{
%>
<td align="left">NA </td>

<%	
}
else{
	%>
	<td align="right"><%=mobno%></td>
	
	<%
}
%>



<td align="left"><%=rs.getString("Owner") %></td>
<td align="left"><%=rs.getString("Status") %></td>


<%
	if(newdobfile=="" || newdobfile.equals(""))
	{
	%>
					<td align="left">NA</td>
	
	<%
	}
	else{
		%>
				<td align="left"><%=newdobfile%></td>
				
		
		<%
	}
	%>
	<%
	if(newaddfile=="" || newaddfile.equals(""))
	{
	%>
					<td align="left">NA</td>
	
	<%
	}
	else{
		%>
	<td align="left"><%=newaddfile%></td>
		
		<%
	}
	%>




<td align="left"><%=rs.getString("Entryby") %></td>

<%
i++;

}}catch(Exception e)
{
	e.printStackTrace();
}
%>
</tr>
</table>

</div>
</form>
<%}catch(Exception e)
{
e.printStackTrace();
}finally{
	try{
		conn.close();
	}catch(Exception e){}
	try{
		conn1.close();
	}catch(Exception e){}
}
%>
</body>
</html>