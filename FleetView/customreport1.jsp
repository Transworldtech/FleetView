<%@ include file="header.jsp" %>
<%
String userID1 = "";
if (! session.isNew()) 
userID1 = (String) session.getAttribute("user");
if (null == userID1) 
	{
		response.sendRedirect("index.html");
	}

	data1=session.getAttribute("data1").toString();
	data2=session.getAttribute("data2").toString();
	vid=request.getParameter("vid").toString();
	user=session.getAttribute("MM_Username").toString();
	vehno=request.getParameter("vehno").toString();
	session.setAttribute("vid",vid);
	session.setAttribute("vehno",vehno);
	rfff=session.getAttribute("rfff").toString();
	rttt=session.getAttribute("rttt").toString();
%>
<table border="1" width="100%"><tr><td>
<table border="1" width="100%" valign="top" class="stats">
<tr bgcolor="#FAFAD2" ><td class="hed"><a href="javascript: history.go(-1)">Back</a></td><td class="hed"><center> Exception Analysis Report For AVL Mobile Eye 2000 For <%=user.toUpperCase() %> Logistics - <%=vehno %> For The Period :  <%=session.getAttribute("ShowDate").toString()%> to <%=session.getAttribute("ShowDate1").toString()%></center></td></tr>
</table>
<P></P>
<%! 
Connection conn;
Statement st,st1;
String data1,data2,vid,user,vehno,rfff,rttt;
int cntos, cntra, cntrd, cntcr, cntnd, cntst,cntdt;
String sql1,sql2,sql3,sql4,sql5,sql6,sql7,tbname;
ResultSet rst1,rst2,rst3;
int os,ra,rda,cd,nd,dt,sp;
%>

<%
data1=session.getAttribute("data1").toString();
data2=session.getAttribute("data2").toString();
rfff=session.getAttribute("rfff").toString();
rttt=session.getAttribute("rttt").toString();
vid=request.getParameter("vid").toString();
user=session.getAttribute("MM_Username").toString();
vehno=request.getParameter("vehno").toString();
session.setAttribute("vid",vid);
session.setAttribute("vehno",vehno);
user=session.getAttribute("user").toString();
cntos=0;
cntra=0;
cntrd=0;
cntcr=0;
cntnd=0;
cntst=0;
cntdt=0;
try{
	
	Class.forName(MM_dbConn_DRIVER); 
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	tbname="t_veh"+vid;
	st=conn.createStatement();
	st1=conn.createStatement();
	
	%>

<table border="1" width="100%" bgcolor="#F5FFFA" class="stats">
<tr bgcolor="#FAFAD2"><td align="center" class="hed"><b>Date</b></td><td class="hed" align="center"><b>OS</b></td><td align="center" class="hed"><b>RA</b></td><td align="center" class="hed"><b>RD</b></td><td align="center" class="hed"><b>CD</b></td><td class="hed" align="center"><b>ND</b></td><td align="center" class="hed"><b>Distance Traveled</b></td><td align="center" class="hed"><b>Location at EOD</b></td><td align="center" class="hed">No.Of Stops </td></tr>
<%
sql1="select distinct(TheFieldDataDate) from "+tbname+" where concat(TheFieldDataDate,TheFieldDataTime)>=concat('"+data1+"','"+rfff+"') and concat(TheFieldDataDate,TheFieldDataTime)<=concat('"+data2+"','"+rttt+"') order by concat(TheFieldDataDate,TheFieldDataTime) asc"; 

rst1=st.executeQuery(sql1);
while(rst1.next())
{
os=0;
ra=0;
rda=0;
cd=0;
nd=0;
dt=0;
sp=0;
sql2="select * from "+tbname+" where TheFieldDataDate='"+rst1.getString("TheFieldDataDate")+"' and concat(TheFieldDataDate,TheFieldDataTime)>=concat('"+data1+"','"+rfff+"') and concat(TheFieldDataDate,TheFieldDataTime)<=concat('"+data2+"','"+rttt+"') order by concat(TheFieldDataDate,TheFieldDataTime) asc";
rst2=st1.executeQuery(sql2);
while(rst2.next())
{
//over speed stamp.
if(rst2.getString("TheFiledTextFileName").equals("OS"))
{
os++;
}//end if. over speed
//Rapid accelaration.
if(rst2.getString("TheFiledTextFileName").equals("AC"))
{
ra++;
}//end if. Rapid accelaration.

if(rst2.getString("TheFiledTextFileName").equals("DC"))
{
rda++;
}//end if. Rapid Deccelaration.


}//end while rst2.
%>
<tr>
<td class="bodyText"><%=rst1.getString("TheFieldDataDate")%></td>
<td class="bodyText"><%=os%></td>
<td class="bodyText"><%=ra%></td>
<td class="bodyText"><%=rda%></td>
<td class="bodyText"></td>
<td class="bodyText"></td>
<td class="bodyText"></td>
<td class="bodyText"></td>
<td class="bodyText"></td>
</tr>
<%
}//end while rst1.
	}catch(Exception e)
	{
		e.printStackTrace();//System.out.println("Exception"+e);
	}
	finally
	{
		conn.close();
		
	}
	%>

<tr><td colspan="7" align="center"><a href="#" onclick='javascript:window.print();'>Print Report</a></td><td colspan="2" align="center"> <a href="excelcustomreport.jsp">Export To Excel</a></td></tr>
	</table>
</td></tr></table>

<!-- footer start here -->
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>
