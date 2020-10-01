

<%@page import="com.fleetview.beans.classes"%><%@ include file="Connections/conn.jsp" %>

<%
classes fleetview=new classes();
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<jsp:useBean id="treestructure" class="com.einnovates.controllers.TreePageController" scope="page">
<%
String username = session.getAttribute("mainuser").toString();
treestructure.setusername(username);
%>
</jsp:useBean>
<%!
Connection con,con1;
String Muser,pass,UserType1="", UserTypeValue="", sql4 ="",Svehlist,ttrans="",UserTypeValue1="",rol="";
%>
<%

try
{
	
	System.out.println("role>>>");
Svehlist="(0";
String targetpage="";
Muser=request.getParameter("user");
pass=request.getParameter("Password");
	con = fleetview.ReturnConnection();
	Statement s = con.createStatement();
	Statement s2 = con.createStatement();
	Statement s3 = con.createStatement();
	Statement st = con.createStatement();
	Statement st1 = con.createStatement();
	Statement st2 = con.createStatement();
	Statement st3 = con.createStatement();
	Statement st4 = con.createStatement();
	Statement stquery=con.createStatement();
	Statement st91 = con.createStatement();
	Statement st92 = con.createStatement();
	Statement st99 = con.createStatement();
	String sessionid = "",role="",UserID="";
	
	
	String sql3 = "SELECT * FROM t_security where Username='"+ Muser +"' and Password='"+pass+"' and ActiveStatus='Yes'";
	ResultSet rs3 = s.executeQuery(sql3);

	if(rs3.next())
	{
		role= rs3.getString("Role");
		UserID=rs3.getString("UserID");
	UserType1= rs3.getString("TypeofUser");
	UserTypeValue = rs3.getString("TypeValue").trim(); 
	UserTypeValue1 = rs3.getString("TypeValue").trim(); 
	rol=rs3.getString("Role");
	out.println(UserType1);
	out.println(UserTypeValue);
	session.setAttribute("UserID",rs3.getString("UserID"));
session.setAttribute("selecteduser",rs3.getString("TypeValue"));
	String sql5="select * from t_targetpage where typevalue='"+UserTypeValue+"'";
	ResultSet rs5=s3.executeQuery(sql5);
	if(rs5.next())
	{
		//targetpage=rs5.getString("targetpage");
		targetpage=""+rs5.getString("targetpage")+"";
		
	}
	ArrayList<String> targetlist=new ArrayList<String>();
	//int q=0;
	String sql55="select * from t_targetpage";
	ResultSet rs55=s3.executeQuery(sql55);
	while(rs55.next())
	{
		targetlist.add(rs55.getString("typevalue"));
		//q++;
	}		
	System.out.println("***    "+targetlist);
	//targetlist=targetlist+")";
	session.setAttribute("TargetList", targetlist);
	
	session.setAttribute("usertypevalue",UserTypeValue );
	session.setAttribute("userrole",role);
	
	session.setAttribute("usertypevalue1",UserTypeValue1);
	session.setAttribute("usertypevaluemain",UserTypeValue );
	session.setAttribute("TypeofUser",UserType1);
	session.setAttribute("TypeofUserMain",UserType1);
	session.setAttribute("user",Muser);
	session.setAttribute("displaymenu","no");
	session.setAttribute("role", rol);
	java.util.Date now = new java.util.Date();
   	String sss=new SimpleDateFormat("yyyy-MM-dd").format(now);
	String tt= new SimpleDateFormat("HH:mm:ss").format(now);
	session.setAttribute("logindate",sss);
	session.setAttribute("logintime",tt);
	sessionid=session.getId().toString();
	
	
	String sql11="insert into t_loguseractivity(RecordDate,RecordTime,Comments,UserIp,SessionID) values('"+sss+"','"+tt+"','"+Muser+"','"+request.getRemoteAddr()+"','"+sessionid+"')";
	
	/*Query to insert query in db_gps.t_sqlquery table*/
	String abcd=sql11.replace("'","#");
	abcd=abcd.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	/*****************************/
	int eee=s2.executeUpdate(sql11);
	System.out.println("*******   "+sql11);
/*********** code for Defoult Location and Zoom Level selection *********/
String sq="select * from t_defoultlocation where OwnerName='"+UserTypeValue+"'";
Statement sx=con.createStatement();
ResultSet rsx=sx.executeQuery(sq);
if(rsx.next())
{
	session.setAttribute("dispalyname",rsx.getString("DisplayName"));
	session.setAttribute("difoultlat",rsx.getString("Latitude"));
	session.setAttribute("difoultlon",rsx.getString("Longitude"));
	session.setAttribute("difoultzoom",rsx.getString("ZoomLevel"));
	
}
else
{
	session.setAttribute("dispalyname",Muser);
	session.setAttribute("difoultlat","18.80");
	session.setAttribute("difoultlon","80.10");
	session.setAttribute("difoultzoom","5");

}
/******************end of code *************************/
/***************** code to redirect the Unidentifed transporte to the unidentified.jsp page ****/
if(UserTypeValue.equals("Unidentified"))
{
	//fleetview.closeConnection();
	response.sendRedirect("unidentified.jsp");
  	return;
}



/************************** end of code *******************/
/***************** code to redirect the vender_unit.jsp page ****/
if (UserType1.equals("Manufacturer"))
{
	//fleetview.closeConnection();
	response.sendRedirect("vender_units.jsp");
  	return;
}

/************************** end of code *******************/
System.out.println(UserTypeValue);
 if(UserType1.equals("Admin"))
 {
	 //fleetview.closeConnection();
	 response.sendRedirect("createnewid.jsp");
		return; 
 }
 if(UserTypeValue.equals("IRTE"))
 {
	 //fleetview.closeConnection();
	 response.sendRedirect("driver_briefing1.jsp");
		return; 
 }
 if(UserTypeValue.equals("airtel"))
 {
	 //fleetview.closeConnection();
	 //response.sendRedirect("testair.jsp");
		 response.sendRedirect("airtelcurrentposition.jsp");
	
	 return; 
 }
 if(UserTypeValue.equals("android"))
 {
	 response.sendRedirect("androidCurrentPosition.jsp");
	 
	 return;
 }
  if(UserTypeValue.equals("geofence"))
 {
	 //fleetview.closeConnection();
	 response.sendRedirect("getallatlong2.jsp");
		return; 
 }
 System.out.println("UserTypeValue   "+UserTypeValue);
	if(UserTypeValue.equals("ALL") || (UserTypeValue.equals("Castrol") && UserType1.equals("GROUP")) ||
			(UserTypeValue.equals("DSC MAIN") && UserType1.equals("GROUP")) || 
			(UserTypeValue.equals("Castrol EMP VEH") && UserType1.equals("GROUP")) || 
			(UserTypeValue.equals("DelEx All") && UserType1.equals("GROUP")) || 
			(UserTypeValue.equals("Nawany All") && UserType1.equals("GROUP"))||
			(UserTypeValue.equals("ACC") && UserType1.equals("GROUP"))|| 
			(UserTypeValue.equals("Praxair All") && UserType1.equals("GROUP"))||
			(UserTypeValue.equals("NECC ALL") && UserType1.equals("GROUP"))||
			(UserTypeValue.equals("Manish Thapar") && UserType1.equals("GROUP")) ||
			(UserTypeValue.equals("ExpressRdys_All") && UserType1.equals("GROUP")))
	{
		//fleetview.closeConnection();
		System.out.println("****   selectuser");
		response.sendRedirect("selectuser.jsp");
  		return;
	}
	
	if(UserType1.equals("EndUser") && !(UserTypeValue.equalsIgnoreCase("Nasik Muncipsl Corporation")))
	{
		response.sendRedirect("opentrips.jsp");
  		return;
	}
	
	if(UserTypeValue.equals("AllCargo") && UserType1.equals("Transporter")) 
	{
		//fleetview.closeConnection();
		response.sendRedirect("slimain.jsp");
  		return;
	}
	//System.out.println((!(targetpage==null||targetpage=="")) && (!(UserTypeValue.equalsIgnoreCase("Castrol ILS"))));
	if((!(targetpage==null||targetpage=="")) && (!(UserTypeValue.equalsIgnoreCase("Castrol ILS"))))
	{	
		
		String hodid = "",Fname = "";
		Svehlist = "(0";
		String sqlemp = "select * from db_gps.t_userdetails where username = '"+Muser+"'";
		ResultSet rs1 = st.executeQuery(sqlemp);
		if(rs1.next())
		{
			Fname = rs1.getString("FirstName")+" "+rs1.getString("LastName");
			hodid = rs1.getString("SrNo");
			 if(Fname == "Sanjay Jetly" || Fname.equals("Sanjay Jetly") || Fname == "Kishore Kumar" || Fname.equals("Kishore Kumar"))
	    	  {
				 hodid = "11317";
	    	  }
			 if(rs1.getString("vehid") == "-" || rs1.getString("vehid").equals("-"))
	    	  {
				 String sqlemp1 = "select * from db_gps.t_userdetails where HODID = '"+hodid+"' ";
	    		  ResultSet rs2 = st1.executeQuery(sqlemp1);
	    		  while(rs2.next())
	    		  {
	    			  if(rs2.getString("vehid") == "-" || rs2.getString("vehid").equals("-"))
	    	    	  {
	    				  String sqlemp2 = "select * from db_gps.t_userdetails where HODID = '"+rs2.getString("SrNo")+"' ";
	    	    		  ResultSet rs4 = st2.executeQuery(sqlemp2);
	    	    		  while(rs4.next())
	    	    		  {
	    	    			  if(rs4.getString("vehid") == "-" || rs4.getString("vehid").equals("-"))
	    	    	    	  {
	    	    				  String sqlemp3 = "select * from db_gps.t_userdetails where HODID = '"+rs4.getString("SrNo")+"' ";
	    	    	    		  ResultSet rs6 = st3.executeQuery(sqlemp3);
	    	    	    		  while(rs6.next())
	    	    	    		  {
	    	    	    			  if(rs6.getString("vehid") == "-" || rs6.getString("vehid").equals("-"))
	    	    	    	    	  {
	    	    	    				  String sqlemp4 = "select * from db_gps.t_userdetails where HODID = '"+rs6.getString("SrNo")+"' ";
	    	    	    	    		  ResultSet rs7 = st4.executeQuery(sqlemp4);
	    	    	    	    		  while(rs7.next())
	    	    	    	    		  {
	    	    	    	    			  if(rs7.getString("vehid") == "-" || rs7.getString("vehid").equals("-"))
	    	    	    	    	    	  {
	    	    	    	    				  
	    	    	    	    	    	  }
	    	    	    	    			  else
	    	    	    	    			  {
	    	    	    	    				  Svehlist = Svehlist+","+rs7.getString("vehid");
	    	    	    	    			  }
	    	    	    	    		  }
	    	    	    	    	  }
	    	    	    			  else
	    	    	    			  {
	    	    	    				  Svehlist = Svehlist+","+rs6.getString("vehid");
	    	    	    			  }
	    	    	    		  }
	    	    	    	  }
	    	    			  else
	    	    			  {
	    	    				  Svehlist = Svehlist+","+rs4.getString("vehid");
	    	    			  }
	    	    		  }
	    	    	  }
	    			  else
	    			  {
	    				  Svehlist = Svehlist+","+rs2.getString("vehid");
	    			  }
	    		  }		 
	    	  }
			 else
			 {
				 Svehlist = Svehlist+","+rs1.getString("vehid");
			 }	 
		}
		
		 if(Fname == "Sanjay Jetly" || Fname.equals("Sanjay Jetly") || Fname == "Kishore Kumar" || Fname.equals("Kishore Kumar"))
		 {
			 String temvehlist = Svehlist;
			 temvehlist = temvehlist+")";
			 temvehlist = temvehlist.replace("(0,", "(");
			 
			 String sqlemp1 = "select distinct(vehiclecode) as vehiclecode from db_gps.t_vehicledetails where vehiclecode not in "+temvehlist+" and empname = 'Idle' and status <> 'deleted' and OwnerName in ('Castrol East','Castrol West','Castrol North','Castrol South')";
			 ResultSet rs2 = st1.executeQuery(sqlemp1);
			 while(rs2.next())
			 {
				 Svehlist = Svehlist+","+rs2.getString("vehiclecode");
			 }	
		 }
		 
		 Svehlist=Svehlist+")";
		 Svehlist = Svehlist.replace("(0,", "(");
		 
		 String temvehlist1 = Svehlist;
		 Svehlist = "(0";
		 
		 String sqlemp1 = "select distinct(vehiclecode) as vehiclecode from db_gps.t_vehicledetails where vehiclecode in "+temvehlist1+"";
		 ResultSet rs2 = st1.executeQuery(sqlemp1);
		 while(rs2.next())
		 {
			 Svehlist = Svehlist+","+rs2.getString("vehiclecode");
		 }
		 
		 Svehlist=Svehlist+")";
		 Svehlist = Svehlist.replace("(0,", "(");
		 System.out.println("**8    "+Svehlist);
	}
	else
	if (UserType1.equals("Transporter")||UserType1.equals("GROUP"))
	{
		System.out.println("else vehiclelist");
	Svehlist=fleetview.getVehicleCodes(UserType1, UserTypeValue);
	}
	if (UserType1.equals("SUBUSER")) // || (UserType1.equals("Transporter") && UserTypeValue.equals("Castrol East")) || (UserType1.equals("Transporter") && UserTypeValue.equals("Castrol North")) || (UserType1.equals("Transporter") && UserTypeValue.equals("Castrol South")) || (UserType1.equals("Transporter") && UserTypeValue.equals("Castrol West")))
	{
	    //fleetview.closeConnection();
		response.sendRedirect("validateusernew.jsp");
	return;
	}
	if(UserType1.equalsIgnoreCase("Zone"))
	{
	    //fleetview.closeConnection();
		response.sendRedirect("validatezonaluser.jsp");
	return;
	}
	/********Start code to create an array of transporter name hows vehicles are selected *********/
	String ownerlist=fleetview.getOwnerNames(Svehlist);
	session.setAttribute("ownerlist",ownerlist);
	/********End code to create an array of transporter name hows vehicles are selected *********/
	session.setAttribute("VehList", Svehlist);
	session.setAttribute("vehlistnew","-");
	Statement s1 = con.createStatement();
	String NAvehlist="(0";
	if (UserType1.equals("GROUP"))
	{
		String sql101="Select distinct(vehcode) as vehcode1 from t_group where GPName='"+ UserTypeValue  +"' and Active='No' order by vehcode";
		ResultSet rst101=s1.executeQuery(sql101);
		while(rst101.next())
		{
		NAvehlist=NAvehlist+","+rst101.getString("vehcode1");
		}		
		NAvehlist=NAvehlist+")";
		session.setAttribute("NAVehList", NAvehlist);
		
	}
	
 	rs3.close();
	/***************** code to check the login transporter is working for castrol or not ******/
	sql4="select * from t_security where TypeValue='"+UserTypeValue+"' and TypeValue in(select Distinct(VehRegNo) from t_group where Gpname='Castrol'|| GPname like '%Praxair%')";
	ResultSet ttt=s1.executeQuery(sql4);
	if(ttt.next())
	{
		session.setAttribute("displaymenu","yes");
	}
	

	/****************** code end ********************************/
	
	
	

/********************* code for setting session verebles *******************************/

String usertypevalue=session.getAttribute("usertypevalue").toString();
try{
	sql11="select * from t_defaultvals where OwnerName='"+usertypevalue+"'";
Statement st11=con.createStatement();
ResultSet rst1=st11.executeQuery(sql11);

if(rst1.next())
{	
	sql11="select * from t_defaultvals where OwnerName='"+usertypevalue+"'";
}
else
{
	sql11="select * from t_defaultvals where OwnerName='Default'";
	
}

System.out.println("sql11-------->"+sql11);
ResultSet rst11=st11.executeQuery(sql11);
if(rst11.next())
{
	session.setAttribute("overspeed",rst11.getString("Overspeedlimit")+" kmph/"+rst11.getString(3)+" Secs");
	session.setAttribute("racc",rst11.getString("AccelerationSpeedVarLimit")+" kmph/Secs"); 
	session.setAttribute("rdcc",rst11.getString("DecelerationSpeedVarLimit")+" kmph/Secs");
	session.setAttribute("ndri","Beyond "+rst11.getString("NightDrivingFromTime")+" To "+rst11.getString("NightDrivingToTime"));
	session.setAttribute("stoptime",rst11.getString("NightDrivingFromTime"));
	session.setAttribute("starttime",rst11.getString("NightDrivingToTime"));
	session.setAttribute("cdri","> "+rst11.getString("ContinuousRunHrsLimit")+" Mins With Stoppages < "+rst11.getString("StopMinsAllowedInContRun"));
	session.setAttribute("stop","> "+rst11.getString("StoppagesGreaterThanInMins")+"Mins");
	session.setAttribute("stop11",rst11.getString("StoppagesGreaterThanInMins"));
session.setAttribute("desconnected",rst11.getString("DisconnectedPeriod"));
session.setAttribute("distformat",rst11.getString("DistFormat"));
session.setAttribute("fuelformat",rst11.getString("FuelFormat"));
System.out.println("rst11.getString(DateFormat)--->" +  rst11.getString("DateFormat"));
session.setAttribute("dateformat",rst11.getString("DateFormat"));

System.out.println("" + session.getAttribute("dateformat"));
}
}catch(Exception e)
{
	out.print("Exception"+e);
}


/**************************** code end *************************************************/
if(rol.equals("SecurityDept"))
 {
	 response.sendRedirect("VehiclePosition.jsp");
	 
	 return;
 }

if(!(targetpage==null||targetpage==""))
{	
	//fleetview.closeConnection();
	response.sendRedirect(targetpage);
  	return;
}

//fleetview.closeConnection();
response.sendRedirect("currentposition.jsp");
  return;
}
else
{
	//fleetview.closeConnection();
	response.sendRedirect("index.html");//err2
}

/************************** code for table created for user name *************************************************************/
int tecount=0;
System.out.println("Muser is:-------------------------"+Muser);
 UserID=session.getAttribute("UserID").toString();
System.out.println("UserID is:-------------------------"+UserID);

String sql1 = "CREATE TABLE /*!32312 IF NOT EXISTS*/ t_"+UserID+"  (SrNo double NOT NULL auto_increment,VehList longtext,Key SrNo(SrNo)) TYPE=MyISAM";
System.out.println("My query sql1:-----"+sql1);
 //st99=con.createStatement();
 tecount=st99.executeUpdate(sql1);

 //if(tecount>1){
		String deluser="delete from t_"+UserID+" ";
		System.out.println("My query deluser:-----"+deluser);
		 //st92=con.createStatement();
		st92.executeUpdate(deluser);
		Svehlist=Svehlist.replace("(", "");
		Svehlist=Svehlist.replace(")", "");
		Svehlist=Svehlist.trim();
	     String str123[]=Svehlist.split(",");
	     //st91=con.createStatement();
	     for(int p=0;p<=str123.length;p++){
		//String insrtmuser="insert into t_"+UserID+" (VehList) values('"+Svehlist+"')";
		String insrtmuser="insert into t_"+UserID+" (VehList) values('"+str123[p]+"')";
		//System.out.println("My query insrtmuser:-----"+insrtmuser);
		
		st91.executeUpdate(insrtmuser);
	     }
//}
 
}catch(Exception e)
{
	out.print("Exception "+e);
}finally
{
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{
		
	}
}

 
	con.close();
%>
<% //fleetview.closeConnection(); %>