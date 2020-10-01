
<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% 
	response.setContentType("application/vnd.ms-excel");
	Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
	String showdatex = formatterx.format(new java.util.Date());
	String filename=session.getAttribute("user").toString()+showdatex+"SMS_Report.xls";
	response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="../Connections/conn.jsp" %>
<%!
Connection conn, con1;
Statement st,st1,st2,st3;
String date1=null, date2=null,datenew1,datenew2,sql,owner,from;
String dateformat,transporter;
String Transporter;
%>
<%
date1=request.getParameter("data");
date2=request.getParameter("data1");
String transporter = request.getParameter("transporter");
//out.println("transporter-->"+transporter);
//out.println("date1--->"+date1);
//out.println("date2--->"+date2);
try
{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	con1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	st2=conn.createStatement();
	st3=con1.createStatement();
	//session.setAttribute("reportno","Report No:13.0");
	//session.setAttribute("reportname","SMS Report");
	//session.setAttribute("date1",date1);
	//session.setAttribute("date2",date2);
	
	//session.setAttribute("transporter",transporter);
	//System.out.println("transporter---> "+ transporter);
	if(transporter==null)
	{
		transporter="All";
	}
	
	
%>

			<table width="100%" align="center" class="sortable">
			<tr>
			<td align="center" class="sorttable_nosort">
			<div align="left"><font size="3">Report No:13.0</font></div>
			<font color="block" size="3" ><b></>SMSReport</b></font>
			
			</td>
			</tr>
					
			</table>
			<table width="100%" border="1" align="center" class="sortable">
	
				<th> <b> Sr. </b></th>
				<th> <b>Transporter</b></th>
				<th> <b>NDRequest</b></th>
				<th> <b>Intimation</b></th>
		
				<%	
				int count=1;
				if(transporter.equals("All"))
				{
					
					try{
						String sql="select p.VehRegno as Transporter,q.count as count from (select Distinct(VehRegno) as VehRegno from t_group where GPName='castrol')as p LEFT OUTER JOIN (select count(*) as count,Transporter from t_ndaproved where `StoredDate` BETWEEN '"+date1+"'AND '"+date2+"' group by Transporter) as q on p.VehRegno=q.Transporter order by Transporter Asc";
						ResultSet rst=st1.executeQuery(sql);
						String Transporter;
						while(rst.next())
						{
							%>
							<tr>
							<td style=" text-align: left"><%= count++ %></td>
							<td style=" text-align: left"><%= rst.getString("Transporter") %></td>
							<%if (rst.getInt("count")==0)
							{%>
									
								<td><div align="left">0</div></td>			 
							<% 
							}
							else
							{
							%>
							<td style=" text-align: left"><%= rst.getInt("count") %></td>
							
							<%
							}
							String sql1="select count(*) as Intimation from t_ndaproved where Intimation='yes' and transporter like '"+rst.getString("Transporter") +"' and `StoredDate` BETWEEN '"+date1+"'AND '"+date2+"' order by Transporter Asc";
							//System.out.println(sql1);
							ResultSet rst1=st2.executeQuery(sql1);
						
							while(rst1.next())
							{
								if(rst1.getInt("Intimation")==0)
								{%>
								
								<td><div align="left">0</div></td>			 
							<% 
							}
							else
							{	
							%>
							<td style=" text-align: left"><%= rst1.getInt("Intimation") %></td>
							</tr>
						<%
							}
							}
					 	}
					
						}catch(Exception e)
							{
							 	out.print("Exception::"+e);
							}
				
				}
				else if(transporter.equals(transporter))
				{

					try{
						String sql="select p.VehRegno as Transporter,q.count as count from (select Distinct(VehRegno) as VehRegno from t_group where VehRegno='"+transporter+"')as p LEFT OUTER JOIN (select count(*) as count,Transporter from t_ndaproved where `StoredDate` BETWEEN '"+date1+"'AND '"+date2+"' group by Transporter) as q on p.VehRegno=q.Transporter";
						//System.out.println("sql--->" + sql);
						ResultSet rst=st1.executeQuery(sql);
						String Transporter;
						while(rst.next())
						{
							%>
							<tr>
							<td style=" text-align: left"><%= count++ %></td>
							<td style=" text-align: left"><%= rst.getString("Transporter") %></td>
							<%if (rst.getInt("count")==0)
							{%>
									
								<td><div align="left">0</div></td>			 
							<% 
							}
							else
							{
							%>
							<td style=" text-align: left"><%= rst.getInt("count") %></td>
							
							<%
							}
							String sql1="select count(*) as Intimation from t_ndaproved where Intimation='yes' and transporter like '"+rst.getString("Transporter") +"' and `StoredDate` BETWEEN '"+date1+"'AND '"+date2+"' order by Transporter Asc";
							//System.out.println(sql1);
							ResultSet rst1=st2.executeQuery(sql1);
						
							while(rst1.next())
							{
								if(rst1.getInt("Intimation")==0)
								{%>
								
								<td><div align="left">0</div></td>			 
							<% 
								}
							else
							{
							%>
							<td style=" text-align: left"><%= rst1.getInt("Intimation") %></td>
							</tr>
						<%
							}
							}//end of while
						}//end of while
					
						}catch(Exception e)
							{
							 	out.print("Exception::"+e);
							}
				
				}//end of else if
				else
				{

					try{
						String sql="select p.VehRegno as Transporter,q.count as count from (select Distinct(VehRegno) as VehRegno from t_group where GPName='castrol')as p LEFT OUTER JOIN (select count(*) as count,Transporter from t_ndaproved where `StoredDate` BETWEEN '"+date1+"'AND '"+date2+"' group by Transporter) as q on p.VehRegno=q.Transporter order by Transporter Asc";
						ResultSet rst=st1.executeQuery(sql);
						String Transporter;
						while(rst.next())
						{
							%>
						
							<tr>
							<td style=" text-align: left"><%= count++ %></td>
							<td style=" text-align: left"><%= rst.getString("Transporter") %></td>
							<%if (rst.getInt("count")==0)
							{%>
									
								<td><div align="left">0</div></td>			 
							<% 
							}
							else
							{
							%>
							<td style=" text-align: left"><%= rst.getInt("count") %></td>
							
							<%
							}
						
							String sql1="select count(*) as Intimation from t_ndaproved where Intimation='yes' and transporter like '"+rst.getString("Transporter") +"'  and `StoredDate` BETWEEN '"+date1+"'AND '"+date2+"' order by Transporter Asc";
							//System.out.println(sql1);
							ResultSet rst1=st2.executeQuery(sql1);
						
							while(rst1.next())
							{
								if(rst1.getInt("Intimation")==0)
								{%>
								
								<td><div align="left">0</div></td>			 
							<% 
							}
								else
								{
							%>
									<td style=" text-align: left"><%= rst1.getInt("Intimation") %></td>
									</tr>
						<%
								}//end of else
					 			}//end of if
						}
					
						}catch(Exception e)
							{
							 	out.print("Exception::"+e);
							}
				
				}//end of else
				
}catch(Exception e)
{
	out.print("Exception::"+e);	
}
	finally
	{
		try
		{
			con1.close();
		}catch(Exception e)
		{}
		try
		{
			conn.close();
		}catch(Exception e)
		{}
	}

%>
</td></tr>
</table>

<%@ include file="footernew.jsp" %>


