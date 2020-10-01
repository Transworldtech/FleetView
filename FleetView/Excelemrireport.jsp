<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"SLI Buzzer.xls";
    response.addHeader("Content-Disposition", "attachment;filename="+filename);
%>
<%@ include file="Connections/conn.jsp" %>
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
	
%>	
	
	<%
//out.print(vehcode);

	
fromdate=request.getParameter("data");

todate=request.getParameter("data1");

//out.print(fromdate);

	
%>	
 <table width="100%" align="center" border="0"  class="bodytext">
	
		
	




<tr><td colspan="8">
<table  border="0" width="100%">
	<tr><td colspan="8" align="center" >
		<font size="2" color="maroon"><b>EMRI KEYPAD REPORT  of Vehicle 4668 From <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(fromdate))%> to <%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(todate))%></font>
 		<div align="right">
         		<a href="#" onclick="javascript:window.print();" title="Print Report">
         		<img src="images/print.jpg" width="15px" height="15px"></a>&nbsp; &nbsp; <a href="Excelemrireport.jsp?fromdate=<%=fromdate%>&todate=<%=todate%>" title="Export to Excel"><img src="images/excel.jpg" width="15px" height="15px"></a>&nbsp;&nbsp;&nbsp;
				<font size="2">Date : <% Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
				String sdt = fmt.format(new java.util.Date());
				out.print(sdt); %>
		</div>
	</td></tr>
</table>
</td></tr>
<tr><td colspan="8">
<table  border="0" width="100%"  class="sortable">
	<tr >
		<th align="center"><b><font size="2" Color="black"> Sr. </b></th>
		<th align="center" colspan="2"><b><font size="2" Color="black" >Updated Date Time</b></th>
		<th align="center" colspan="2"><b><font size="2" Color="black">Stamp Type</b></th>
		<th align="center" colspan="2"><b><font size="2" Color="black" >Location</b></th>
	
</tr>
<%
	int diff=0;
	boolean flag = false;
		int i=1;
		String sql="select * from t_veh3119 where TheFiledTextFileName like 'K%' and TheFieldDataDate >='"+fromdate+" 00:00:00' and TheFieldDataDate <='"+todate+" 23:59:59' order by concat(TheFieldDataDate,TheFieldDataTime) asc ";
		//out.print(sql);
		rst=st.executeQuery(sql);
		while(rst.next())
		{
			String stamp=rst.getString("TheFiledTextFileName");
			//String datatime=rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime");
			java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime"));
			Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
			thedate = formatter1.format(ShowDate1);
			String loc=rst.getString("TheFieldSubject");
		%>	
						<tr>
							<td align="center"><font size="2"><%=i%></td>
							<td align="center" colspan="2"><font size="2" ><%=thedate %>></td>
							<td align="center" colspan="2"><font size="2" ><%=stamp %></td>
							<td align="center" colspan="2"><font size="2" ><%=loc %></td>
							
					
							
						</tr>
						<%
						i++;
			
						
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
        <%@ include file="footernew.jsp" %>
