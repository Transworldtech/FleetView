<%@ include file="headernew.jsp" %>
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">

<%

System.out.println("in the select user .jsp page at start ");
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>

<script type="text/javascript" src="js/tblscript.js"></script>
<script type="text/javascript">

function getchart()
{
	//alert("pohochalo re bho");
	
	var RakeID=document.getElementById("rakeid1").value;
	//alert("rakeid:-"+RakeID);
	document.getElementById('myFrame').src="http://103.8.126.138:8080/birt/frameset?__report=ad_report_7.rptdesign&RakeID="+RakeID+"&__showtitle=false";
	//alert("zale re bho");
	}
</script>

 <%!String data1, data2, showdate, showdate1;
 	String VehRegNo = "";%>
	
<%
Connection conn1 = null;

Statement st = null,st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null,st11=null,st12=null,st13=null,st14=null,st15=null,st16=null;

try{
	String location="";
	String prevDayDate = null;
	String repDate = null;
	String ownerName = null;
     
	int distanceDifference = 0;

	//Class.forName(MM_dbConn_DRIVER);
	conn1 = fleetview.ReturnConnection();
	st = conn1.createStatement();
	st1 = conn1.createStatement();
	st2 = conn1.createStatement();
	st3 = conn1.createStatement();
	st4 = conn1.createStatement();
	st5=conn1.createStatement();
	st6=conn1.createStatement();
	st7=conn1.createStatement();
	st8=conn1.createStatement();
	st9=conn1.createStatement();
	st10=conn1.createStatement();
	st11=conn1.createStatement();
	st12=conn1.createStatement();
	st13=conn1.createStatement();
	st14=conn1.createStatement();
	st15=conn1.createStatement();
	st16=conn1.createStatement();
}catch(Exception e){
	e.printStackTrace();
}
%>
<%try{

	String id=request.getParameter("id");
}catch(Exception e){
	e.printStackTrace();
}%>

<%
String fromDate = "", toDate = "";
String dd = request.getQueryString();
if (dd == null) {
	Calendar cal = Calendar.getInstance();
	String today_dt = new SimpleDateFormat("dd-MMM-yyyy")
			.format(cal.getTime());
	data2 = today_dt;
	String temp = data2;
	toDate = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

	cal.add(Calendar.DATE, -1);
	String yesterday_dt = new SimpleDateFormat("dd-MMM-yyyy")
			.format(cal.getTime());
	data1 = yesterday_dt;
	temp = data1;

	fromDate = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy").parse(temp));

} else {

	data1 = request.getParameter("data");
    System.out.println("data1:--"+data1);
	fromDate = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy")
					.parse(data1));
	System.out.println("fromDate:--"+fromDate);
	data2 = request.getParameter("data1");
	System.out.println("data2:--"+data2);
	toDate = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy")
					.parse(data2));
	toDate=toDate.trim();
	System.out.println("toDate:--"+toDate);
} //end of else
 %>
<html>

<form name="data" method="post" action="" >

<input type="hidden" name="id" value="id">
<br>
<div align="center"><b>Rake Delay Report</b></div>
<br></br>
	<div style="margin-top:0.2%;margin-left: 30%; ">
	<table> 
	<tr>
	
	<td id="frmDT" align="left" style="display:'' "><b><font size="2">Rake Start Date : </font></b>&nbsp;&nbsp; <input
			type="text" size="10" id="data" name="data"
			value="<%if(request.getParameter("data")!=null){%><%= request.getParameter("data")%><% }else%><%= new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(toDate))%>" size="15" readonly /></td>
		<td align="right"><script type="text/javascript">
		  Calendar.setup(
		    {
		      inputField  : "data",         // ID of the input field
		      ifFormat    : "%d-%b-%Y",      // the date format
		      button      : "data"       // ID of the button
		    }
		  );
		</script></td>
		
	
	<td >&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;<b>Enter Rake Id :</b></td>
	<td><input type="text" name="rakeid" id="rakeid" style="width:130px; border-radius:0px;" value="" /> 
	&nbsp;&nbsp;&nbsp;
	
</td>

<td>
	<input type="submit" name="submit" id="submit" style="border: outset;" value="Submit" onclick="" />
	</td>
	</tr>
</table>

</div>

<%
String rakeid=request.getParameter("rakeid");
//String nextday="select DATE_ADD(now(),INTERVAL 3 DAY)";
if(rakeid!=null){
	
 			rakeid=request.getParameter("rakeid");
			System.out.println("rakeid is->"+rakeid);	
	
			
			data1 = request.getParameter("data");
			System.out.println("data1:--"+data1);
			fromDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy").parse(data1));
			System.out.println("fromDate:--"+fromDate);

			/* String nextICD="select DATE_ADD(now(),INTERVAL 3 DAY)";
		    ResultSet rsicd=.executeQuery(nextICD);
		    while(rsicd.next()){
		    	nextICDdays=rsicd.getString("");
		    }
			String nextLSP="select DATE_ADD(now(),INTERVAL 3 DAY)";
			String nextTPLANT="select DATE_ADD(now(),INTERVAL 3 DAY)";
			String nextPLANT="select DATE_ADD(now(),INTERVAL 3 DAY)";
			String nextTPORT="select DATE_ADD(now(),INTERVAL 3 DAY)";
			String nextPORT="select DATE_ADD(now(),INTERVAL 3 DAY)"; */
			
			String Stage="",DateTime="",DO="";
			int noofrakeid=0;
			int i=0;
			String Datefirst="",Datelast="";
			String sql="select * from t_serversidehistory where DO='"+rakeid+"'";
			ResultSet rsst = st3.executeQuery(sql);
			while(rsst.next())
			{
				Stage=rsst.getString("Stage");
				System.out.println("Stage:--------"+Stage);
				DateTime=rsst.getString("DateTime");
				DO=rsst.getString("DO");
				System.out.println("DO:-"+DO);
				System.out.println("Stage:-"+Stage);
				
				String datefirst="select DateTime from t_serversidehistory where DO='"+rakeid+"' and Stage='"+Stage+"' order by DateTime asc limit 1";
				 ResultSet rsstrt=st.executeQuery(datefirst);
				 if(rsstrt.next()){
					 Datefirst=rsstrt.getString("DateTime");
					 System.out.println("Datefirst:-"+Datefirst);
				 }
				
				String dateend="select DateTime from t_serversidehistory where DO='"+rakeid+"' and Stage='"+Stage+"' order by DateTime desc limit 1";
				ResultSet rsend=st1.executeQuery(dateend);
				 if(rsend.next()){
					 Datelast=rsend.getString("DateTime");
					 System.out.println("Datelast:-"+Datelast);
				 }
				 
				 String sqlup="update t_abggroupdelayreport set actualstart='"+Datefirst+"', actualend='"+Datelast+"' where Stage='"+Stage+"' and RakeID='"+DO+"' ";
					System.out.println("sqlup:-"+sqlup);
					st10.executeUpdate(sqlup);
			
						
					
					
			}
			String Stages="",duration="";
			String abginfo="select * from db_gps.t_abgstagesinfo order by SrNo";
			ResultSet rsinfo=st5.executeQuery(abginfo);
			while(rsinfo.next()){
				Stages=rsinfo.getString("stages");
				duration=rsinfo.getString("duration");
				
				if(data1==null){
					
				}else{
					
					if(Stages.equalsIgnoreCase("ICD Agent")){
												
						String sqltp="update t_abggroupdelayreport set planstart='"+fromDate+"',planend=DATE_ADD('"+fromDate+"',INTERVAL "+duration+" Hour) where Stage='"+Stages+"' and RakeID='"+rakeid+"' ";
						System.out.println("sqltp:---"+sqltp);
						st11.executeUpdate(sqltp);
					}
					else if(Stages.equalsIgnoreCase("ICD LSP")){
						String newplanend="";
						String self="select planend from db_gps.t_abggroupdelayreport where Stage='ICD Agent' and RakeID='"+rakeid+"'";
						ResultSet rsself=st2.executeQuery(self);
						if(rsself.next()){newplanend=rsself.getString("planend"); }
						//System.out.println("self:---"+self);
						String sqltp1="update t_abggroupdelayreport set planstart='"+newplanend+"',planend=DATE_ADD('"+newplanend+"',INTERVAL "+duration+" Hour) where Stage='"+Stages+"' and RakeID='"+rakeid+"' ";
						System.out.println("sqltp1:---"+sqltp1);
						st12.executeUpdate(sqltp1);
					}else if(Stages.equalsIgnoreCase("Transit to Plant")){
						String newplanend="";
						String self="select planend from db_gps.t_abggroupdelayreport where Stage='ICD LSP' and RakeID='"+rakeid+"'";
						ResultSet rsself1=st9.executeQuery(self);
						if(rsself1.next()){newplanend=rsself1.getString("planend"); }
						//System.out.println("self:---"+self);
						
						String sqltp2="update t_abggroupdelayreport set planstart='"+newplanend+"',planend=DATE_ADD('"+newplanend+"',INTERVAL "+duration+" Hour) where Stage='"+Stages+"' and RakeID='"+rakeid+"' ";
						System.out.println("sqltp2:---"+sqltp2);
						st13.executeUpdate(sqltp2);
						
					}else if(Stages.equalsIgnoreCase("At Plant")){
						String newplanend="";
						String self="select planend from db_gps.t_abggroupdelayreport where Stage='Transit to Plant' and RakeID='"+rakeid+"'";
						ResultSet rsself2=st6.executeQuery(self);
						if(rsself2.next()){newplanend=rsself2.getString("planend"); }
						//System.out.println("self:---"+self);
						
						String sqltp3="update t_abggroupdelayreport set planstart='"+newplanend+"',planend=DATE_ADD('"+newplanend+"',INTERVAL "+duration+" Hour) where Stage='"+Stages+"' and RakeID='"+rakeid+"' ";
						System.out.println("sqltp3:---"+sqltp3);
						st14.executeUpdate(sqltp3);
					}else if(Stages.equalsIgnoreCase("Transit to Port")){
						String newplanend="";
						String self="select planend from db_gps.t_abggroupdelayreport where Stage='At Plant' and RakeID='"+rakeid+"'";
						ResultSet rsself3=st7.executeQuery(self);
						if(rsself3.next()){newplanend=rsself3.getString("planend"); }
						//System.out.println("self:---"+self);
						
						String sqltp4="update t_abggroupdelayreport set planstart='"+newplanend+"',planend=DATE_ADD('"+newplanend+"',INTERVAL "+duration+" Hour) where Stage='"+Stages+"' and RakeID='"+rakeid+"' ";
						System.out.println("sqltp4:---"+sqltp4);
						st15.executeUpdate(sqltp4);
					}else {
						String newplanend="";
						String self="select planend from db_gps.t_abggroupdelayreport where Stage='Transit to Port' and RakeID='"+rakeid+"'";
						ResultSet rsself4=st8.executeQuery(self);
						if(rsself4.next()){newplanend=rsself4.getString("planend"); }
						//System.out.println("self:---"+self);
						
						 
						String sqltp5="update t_abggroupdelayreport set planstart='"+newplanend+"',planend=DATE_ADD('"+newplanend+"',INTERVAL "+duration+" Hour) where Stage='"+Stages+"' and RakeID='"+rakeid+"' ";
						System.out.println("sqltp5:---"+sqltp5);
						st16.executeUpdate(sqltp5);
					}
				}
			}
			
			String sqldel="delete from t_abggroupdelayreport where RakeID='"+DO+"' ";
			//System.out.println("sqldel:-"+sqldel);
			//st4.executeUpdate(sqldel);
			//String sqlup="update t_abggroupdelayreport set actualstart='"+Datefirst+"', actualend='"+Datelast+"' where Stage='"+Stage+"' and RakeID='"+DO+"' ";
			//System.out.println("sqlup:-"+sqlup);
			//st10.executeUpdate(sqlup);
			if(DO.equalsIgnoreCase(" ")|| DO==null){
				System.out.println("noting");
			}
			else{
				//Datelast="2015-09-02 19:19:27";
			String sqlinsrt="insert into t_abggroupdelayreport(RakeID,Stage,planstart,planend,actualstart,actualend) values('"+DO+"','"+Stage+"','2015-09-02 03:19:27','2015-09-02 18:30:00','"+Datefirst+"','"+Datelast+"')";
			//System.out.println("sqlinsrt:-"+sqlinsrt);
			//st2.executeUpdate(sqlinsrt);
			String sqlinsrt1="insert into db_gps.t_abggroupdelayreport(RakeID,Stage,planstart,planend) values('R1','ICD LSP','2015-09-02 19:50:27','2015-09-02 22:19:27')";
			//st5.executeUpdate(sqlinsrt1);
			String sqlinsrt2="insert into db_gps.t_abggroupdelayreport(RakeID,Stage,planstart,planend) values('R1','Transit to Plant','2015-09-02 22:30:27','2015-09-02 23:50:27')";
			//st6.executeUpdate(sqlinsrt2);
			String sqlinsrt3="insert into db_gps.t_abggroupdelayreport(RakeID,Stage,planstart,planend) values('R1','At Plant','2015-09-03 01:49:27','2015-09-03 09:19:27')";
			//st7.executeUpdate(sqlinsrt3);
			String sqlinsrt4="insert into db_gps.t_abggroupdelayreport(RakeID,Stage,planstart,planend) values('R1','Transit to Port','2015-09-03 09:19:27','2015-09-03 16:19:27')";
			//st8.executeUpdate(sqlinsrt4);
			String sqlinsrt5="insert into db_gps.t_abggroupdelayreport(RakeID,Stage,planstart,planend) values('R1','At Port','2015-09-03 17:19:27','2015-09-03 23:19:27')";
			//st9.executeUpdate(sqlinsrt5);
			out.print("<iframe  id='myFrame' width='100%' height='850px' src=''></iframe>");
			out.print("<input type='hidden' id='rakeid1' name='rakeid1' value="+rakeid+" ></input>");
			out.print("<script>getchart();</script>");
			} 
			
}else{
	System.out.println("\n In nothing loop..........");
}
%>

</form>



</html>
</jsp:useBean>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<br><br>
<%@ include file="footernew.jsp" %>


