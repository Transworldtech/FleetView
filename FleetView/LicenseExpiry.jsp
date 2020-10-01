<%@ include file="headernew.jsp"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<link rel="stylesheet" type="text/css" href="css/form.css" media="all">
<jsp:useBean id="fleetview" class="com.fleetview.beans.classes"	scope="page"></jsp:useBean>
	
<%! public static Connection con1; %>
<%
	fleetview.getConnection(MM_dbConn_DRIVER, MM_dbConn_STRING,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
	String defaultDate = new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	Class.forName(MM_dbConn_DRIVER);
	String condition="";
	con1 = fleetview.ReturnConnection();
	Statement stmt1 = con1.createStatement();
	Statement stmt2 = con1.createStatement();
	
	ResultSet rs2 = null, rs3 = null, rs4 = null, rs5 = null;
	String TotalDrivers1= request.getParameter("TotalDrivers");
	System.out.println("TotalDrivers"+TotalDrivers1);	
// 	String Group1= request.getParameter("usertypevalue");its not goging through sessoin or insecure  
// 	System.out.println("TotalDrivers"+Group1);
	String Group1= session.getAttribute("usertypevalue").toString();//its going through session
	System.out.println("TotalDrivers"+Group1);
	String Owner1="";
	//= request.getParameter("user1");
	Owner1= session.getAttribute("usertypevalue").toString();
	System.out.println("Owner"+Owner1);
	String gpname="";
	session.getAttribute("usertypevalue").toString();
	System.out.println("Owner-----------------------------------------------------"+gpname);
	System.out.println("Owner"+Owner1);
	
	
	
	if(TotalDrivers1.equals("all")){
		System.out.println("HI");
		condition= "activestatus='active' and (gpname='"+Group1+"' or owner='"+Group1+"')";
		System.out.println("condition"+condition);
	}else if(TotalDrivers1.equals("expired")){
		System.out.println("HI");
		condition= "activestatus='active' and (gpname='"+Group1+"' or owner='"+Group1+"') and  licenseexpdate <curdate()";
		System.out.println("condition"+condition);
		
	}else if(TotalDrivers1.equals("7")){
		System.out.println("HI");
		condition= "activestatus='active' and (gpname='"+Group1+"' or owner='"+Group1+"')  and licenseexpdate >=curdate() and licenseexpdate<= DATE_ADD(curdate(),INTERVAL 7 DAY)";
		System.out.println("condition"+condition);
		
	}else{
		System.out.println("HI");
		condition= "activestatus='active' and (gpname='"+Group1+"' or owner='"+Group1+"') and licenseexpdate > DATE_ADD(curdate(),INTERVAL 7 DAY) and licenseexpdate<= DATE_ADD(curdate(),INTERVAL 30 DAY)";
		System.out.println("condition"+condition);
	}
	
%>

<!-- Database Connection -->

	<script language="javascript">
	String usertypevalue=session.getAttribute("usertypevalue").toString();
	System.out.println("transportername"+usertypevalue);
	 function birt(){
			var a=validate();
			
			if(a==true)
				{
				
				
// 			var userid=document.getElementById("user").value;
			
// 			var date1= document.getElementById("data").value;
// 			var date2= document.getElementById("data1").value;
			
			
				
			var date = date1.split("-");
			var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
			for(var j=0;j<months.length;j++)
			{
			    if(date[1]==months[j])
			    {
			         date[1]=months.indexOf(months[j])+1;
			    };                  
			} 
			if(date[1]<10)
			{
			    date[1]='0'+date[1];
			}                        
			var formattedDate1 = date[2]+'-'+date[1]+'-'+date[0];
			formattedDate1=formattedDate1+" 00:00:00";
			//alert(date[1]);
			//alert(date[0]);
			
			var dat = date2.split("-");
			var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
			for(var j=0;j<months.length;j++){
			    if(dat[1]==months[j]){
			         dat[1]=months.indexOf(months[j])+1;
			     };                  
			} 
			if(dat[1]<10){
			    dat[1]='0'+dat[1];
			}                        
			var formattedDate2 = dat[2]+'-'+dat[1]+'-'+dat[0];
			formattedDate2=formattedDate2+" 23:59:59";
			document.getElementById("myIframe").src="http://103.8.126.138:8080/birttest/frameset?__report=DriverMasterRepor.rptdesign&usertypevalue="+usertypevalue+"&__showtitle=false";

			document.getElementById("reportData").style.display="";
			
			return true;
				}
			else
				{
					return false;
				}
	 }
	 
  </script>

	 <table border="0" width="600" align="center" class="stats">
		<tr>
			<td colspan="5" align="center"><div align="left"><font size="3"></font></div>
			<font face="Arial" color="black" size="4"><b>Driver License Expiry Report	</b></font></td>
		</tr>
	</table> 
	<div style="margin-left: 25%;">
	<table border="0" width=600 align="center">
		<input	type="hidden" id="PageName" name="PageName" value="<%=PageName%>" />
		<br></br>

	</table>
	</div>
	

	


	<% 

	String  usertypevalue=" ", usr=" ";
	try{
		
	 usertypevalue=session.getAttribute("usertypevalue").toString();
	 usr=request.getParameter("user");
	}
	catch(Exception e)
	{
	}
	%>
	
	<input type="hidden" id="user" name="user" value="<%=condition%>" />
	<input type="hidden" id="owner" name="owner" value="<%=Owner1%>" />
	<input type="hidden" id="tdriver" name="tdriver" value="<%=TotalDrivers1%>" />
<!-- 	<script>alert(document.getElementById("user").value);</script> -->
	
	<div>
<table width ="100%" border="0">

		
<td align="right" bgcolor="#FFFFFF"><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())%></td>
		
		</tr></div>
		</table>
	
<div id="reportData1">
<iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birttest/frameset?__report=DriverMasterRepor.rptdesign&usertypevalue=<%=condition %>&__showtitle=false"> 
<!-- <iframe id="myIframe" width="100%" height="850px" src=""> --> 
</iframe> 

 </div>
 
 <%
		String Bt=request.getParameter("button");
		if(Bt=="Submit")
		{
%>
 	<div id="reportData">
<%-- <iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birt/frameset?__report=JRM_report.rptdesign&userid=<%=UserID%>&__showtitle=false"> --%> 
<iframe id="myIframe" width="100%" height="850px" src="http://myfleetview.com:8080/birttest/frameset?__report=DriverMasterRepor.rptdesign&usertypevalue=<%=condition%>&__showtitle=false"> 
</iframe> 

 </div>
 <%
		}
%>
 
	

		
			
		
	
</tr>
		
	</table>
	</div>
	</form>


