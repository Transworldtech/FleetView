<%@ page contentType="application/vnd.ms-excel; charset=gb2312" %>
<% response.setContentType("application/vnd.ms-excel");
Format formatterx = new SimpleDateFormat("dd-MMM-yyyy");
String showdatex = formatterx.format(new java.util.Date());

String filename=session.getAttribute("user").toString()+showdatex+"Crane Working.xls";
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
	String vehcode=request.getParameter("vehcode");
	String vehregno=request.getParameter("vehregno");
	String cranemodno=request.getParameter("cranemodno");
	//String todey=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());

if(!(null==request.getParameter("fromdate")||null==request.getParameter("todate")))
{
fromdate=request.getParameter("fromdate");
todate=request.getParameter("todate");
//out.print(fromdate);
}
else
{
fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
todate=fromdate;
//out.print(todate);
}
	
%>
<table border="2" width="100%" class="stats">
<tr><td colspan="5" align="right"><font size="2">Date : <% Format fmt = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
			String sdt = fmt.format(new java.util.Date());
			out.print(sdt); %></td>
</tr>
<tr><td colspan="5" align="center"><b><font size="3" color="maroon"> Crane working Report of Crane <%=cranemodno%> </td></tr>
<tr><td colspan="5">
<table  border="0" width="100%" >
<tr bgcolor="gray">
	<th align="center" colspan="2"><b><font size="2" Color="white">Sr.No</th>
	<th align="center" colspan="2"><b><font size="2" Color="white">Crane Reg No.</th>
	<th align="center" colspan="2"><b><font size="2" Color="white">Crane Model No.</th>
	<th align="center" colspan="2"><b><font size="2" Color="white">Start Date Time</th>
	<th align="center" colspan="2"><b><font size="2" Color="white">End Date Time </th>
	<th align="center" colspan="2"><b><font size="2" Color="white">Worked Time(HH:MM:SS) </th>
</tr>
<%
	int diff=0;
	boolean flag = false;
		int i=1;
		String sdate,edate,stime,etime,time="";
		//int millisecdiff;
		int millisecdiff=0,miliseconds1=0,miliseconds2=0,secdiff=0,mindiff=0,hrdiff=0;
		String sql="select * from t_veh"+vehcode+" where TheFiledTextFileName in('CE','CD') and TheFieldDataDate >='"+fromdate+" 00:00:00' and TheFieldDataDate <='"+todate+" 23:59:59' order by concat(TheFieldDataDate,TheFieldDataTime) asc ";
		//out.print(sql);
		rst=st.executeQuery(sql);
		while(rst.next())
		{
			String stamp=rst.getString("TheFiledTextFileName");
			if(stamp.equals("CE"))
			{
				sdate=rst.getString("TheFieldDataDate");
				stime=rst.getString("TheFieldDataTime");
				if(null==stime)
				{
				stime="00:00:00";
				}
				try
				{
					java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate+" "+stime);
					miliseconds1=(int)fd.getTime();
				}catch(Exception e1)
				{
					try
					{
						java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(sdate);
						miliseconds1=(int)fd.getTime();
					}
					catch(Exception e4)
					{
						java.util.Date fd=new SimpleDateFormat("yyyy-MM-dd").parse(sdate);
						miliseconds1=(int)fd.getTime();
					}
				}
			java.util.Date ShowDate1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime"));
				Format formatter1 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
				thedate = formatter1.format(ShowDate1);
				
				//String thedata=rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime");
				if(rst.next())
				{
					stamp=rst.getString("TheFiledTextFileName");
					if(stamp.equals("CD"))
					{
						edate=rst.getString("TheFieldDataDate");
						etime=rst.getString("TheFieldDataTime");
						if(null==etime)
						{
						etime="00:00:00";
						}
						try
						{
							java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate+" "+etime);
							miliseconds2=(int)fd1.getTime();
						}catch(Exception e1)
						{
							try
							{
								java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(edate);
								miliseconds2=(int)fd1.getTime();
							}
							catch(Exception e4)
							{
								java.util.Date fd1=new SimpleDateFormat("yyyy-MM-dd").parse(edate);
								miliseconds2=(int)fd1.getTime();
							}
						}
						
					java.util.Date ShowDate2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime"));
					Format formatter2 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
					thedate1 = formatter2.format(ShowDate2);
					millisecdiff=miliseconds2-miliseconds1;
					//out.print(millisecdiff);
					int seconds= millisecdiff / 1000;
					if(seconds> 0){
					String sec;
					sec= ""+ (seconds%60);
					if(seconds % 60 <10){
					sec= "0"+ (seconds%60);
					}
					String min;
					if(seconds > 60){
					min= "" +(seconds/60%60);
					if((seconds/60%60)<10){
					min= "0" +(seconds/60%60);
					}
					}
					else{
					min= "00";
					}
					String hours;
					if(seconds/60 > 60){
					hours= "" +(seconds/60/60);
					if((seconds/60/60) < 10){
					hours= "0"+ (seconds/60/60);
					}

					}
					else{
					hours= "00";
					}

					time=hours +":"+ min +":" + sec;
					}
					
					/*secdiff=millisecdiff/1000;
					mindiff=secdiff/60;
					hrdiff=mindiff/60; */
					//out.print(thedate1);
					}
				}
				else
				{
					thedate1="-";
					time="-";
				}
			
						//String thedate1=rst.getString("TheFieldDataDate")+" "+rst.getString("TheFieldDataTime");
						%>
						<tr>
							<td align="center" colspan="2"><font size="2"><%=i%></td>
							<td align="center" colspan="2"><font size="2"><%=vehregno%></td>
							<td align="center" colspan="2"><font size="2"><%=cranemodno%></td>
							<td align="center" colspan="2"><font size="2"><%=thedate%></td>
							<td align="center" colspan="2"><font size="2"><%=thedate1%></td>
							<td align="center" colspan="2"><font size="2"><%=time%></td>
						
							
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

<tr><td colspan="5">
		<table border="1" width="100%" > 
		<tr>
			<td class="copyright" width="100%" colspan="8" align="center">
			<b><font color="maroon" size="1">Copyright &copy; 2008 by Transworld 
			Compressor Technologies Ltd. All Rights Reserved.</font></center>
		</td></tr>
		</table>
	</td></tr>
</table>
	

<font color="maroon" size="1">TW SLI Version 1.1</font>
</body>
</html>