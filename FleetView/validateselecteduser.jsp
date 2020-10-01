
<%@page import="com.fleetview.beans.classes"%><%@ include file="Connections/conn.jsp" %>

<%
classes fleetview=new classes();
fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%!
Connection conn;
String userName,sql,sqlll,UserType1,UserTypeValue,sql1;
%>
<%
try{
	conn=fleetview.ReturnConnection();
	Statement st=conn.createStatement();
	//Statement st = con.createStatement();
	Statement st1 = conn.createStatement();
	Statement st2 = conn.createStatement();
	Statement st3 = conn.createStatement();
	Statement st4 = conn.createStatement();
	Statement st91 = conn.createStatement();
	Statement st92 = conn.createStatement();
	Statement st99 = conn.createStatement();
	if(session.getValue("usertypevaluemain").toString().equals("Castrol EMP VEH") || session.getValue("usertypevaluemain").toString().equals("ExpressRdys_All") || session.getValue("usertypevaluemain").toString().equalsIgnoreCase("EMehtha ALL"))
	{ 
	userName=request.getParameter("username1");
	}
	else
	{
		userName=request.getParameter("username");
	}
	String list1=(String)request.getParameter("grouplist");
    session.setAttribute("selecteduser",userName);
	System.out.println("Username**********8    "+userName);
	String Msg="";
  System.out.println(session.getAttribute("usertypevaluemain"));
	String Svehlist="(0";
	System.out.println("****23   "+list1);
	if(userName.length()==0)
	{
		Msg = "2";
		response.sendRedirect("selectuser.jsp?Msg="+Msg);
	}
	else if(list1.contains(userName))
	{
		if(!(session.getAttribute("usertypevaluemain").toString().equals("Castrol") ||
			session.getAttribute("usertypevaluemain").toString().equals("DSC MAIN")))
	{
		
		System.out.println("Hiii%%%%%%%5");
		if(session.getAttribute("usertypevaluemain").toString().equals("Castrol EMP VEH")  || session.getAttribute("usertypevaluemain").toString().equals("IAL_INDIA") || session.getAttribute("usertypevaluemain").toString().equals("ExpressRdys_All") ||  session.getValue("usertypevaluemain").toString().equalsIgnoreCase("EMehtha ALL"))
		{
			System.out.println("Hiii");
			sql="select * from t_security where TypeValue='"+userName.trim()+"' order by UserID Asc";
			ResultSet rst=st.executeQuery(sql);
			System.out.println("Hiii            "+sql);
			if(rst.next())
			{
				System.out.println("**userName    "+userName+"    "+session.getAttribute("usertypevaluemain").toString());
				if(userName.equals("Castrol EMP VEH") && session.getAttribute("usertypevaluemain").toString().equals("Castrol EMP VEH"))
				{
					System.out.println("**userName    "+session.getAttribute("mainuser"));
					session.setAttribute("MM_Username", session.getAttribute("mainuser"));
				    session.setAttribute("user",session.getAttribute("mainuser"));	
				}
				else
				{
					session.setAttribute("MM_Username", rst.getString("UserName"));
				    session.setAttribute("user",rst.getString("UserName"));	
				}
			
			UserType1= rst.getString("TypeofUser");
			UserTypeValue = rst.getString("TypeValue"); 
			
			session.setAttribute("usertypevalue",UserTypeValue );
			session.setAttribute("TypeofUser",UserType1);
			}
			else 
			{
				UserType1= "UserType1";
				session.setAttribute("usertypevalue",userName );
			}
		}
		else
		{
		sql="select * from t_security where FullName='"+userName+"' order by UserID Asc";
		//System.out.println("&&&&&&&&&&&&&&");
	   // System.out.println(sql);
		ResultSet rst=st.executeQuery(sql);
		if(rst.next())
		{
			
			if(session.getAttribute("usertypevaluemain").toString().equals("ALL") && userName.equals("Castrol EMP VEH"))
			{
				System.out.println("************************$$$$$$$$$$$$$$$");
				session.setAttribute("MM_Username","csf@castrol.com");
				session.setAttribute("user","csf@castrol.com");	
			}
			else
			{
				System.out.println("**********^^^^^^^^^^^^^^^^^^^^^^^^**************$$$$$$$$$$$$$$$");
				session.setAttribute("MM_Username", rst.getString("UserName"));
				 session.setAttribute("user",rst.getString("UserName"));	
			}			
				
	   
		UserType1= rst.getString("TypeofUser");
		UserTypeValue = rst.getString("TypeValue"); 
		session.setAttribute("usertypevalue",UserTypeValue );
		session.setAttribute("TypeofUser",UserType1);
		}
		else
		{
			UserType1= "UserType1";
			session.setAttribute("usertypevalue",userName );
		}
		}
//System.out.println("------------>"+UserType1);
		 if(session.getAttribute("usertypevaluemain").toString().equals("IAL_INDIA"))
		 {
			 if(UserTypeValue == "IAL_INDIA" || UserTypeValue.equals("IAL_INDIA"))
			 {
				 sql1="Select distinct(vehcode) as vehcode1 from t_group where GPName='"+ session.getAttribute("usertypevaluemain").toString() +"'  order by vehcode";
			 }
			 else
			 {
			 sql1="Select distinct(vehcode) as vehcode1 from t_group where GPName='"+ session.getAttribute("usertypevaluemain").toString() +"' and VehRegNo = '"+UserTypeValue+"'  order by vehcode";
			 }
		 }
		 else
			 if(session.getAttribute("usertypevaluemain").toString().equals("EMehtha ALL"))
		 {
				 sql1="Select distinct(vehcode) as vehcode1 from t_group where GPName='"+ UserTypeValue  +"' and vehregno = 'EMehtha' order by vehcode";	
		 }
		 else
		if (UserType1.equals("Transporter"))
		{
			sql1="Select distinct(vehiclecode) as vehcode1 from t_vehicledetails where OwnerName='"+ UserTypeValue +"' order by vehiclecode";
		}
		else if (UserType1.equals("GROUP") && userName.equals("Manish Thapar"))
		{
			sql1="Select distinct(vehcode) as vehcode1 from t_group where GPName IN('Manish Thapar','Castrol Emp West Sanchay Singh Team','Castrol Emp Sanchay Singh Team','Nilesh Malani','Siddesh Vaity')  order by vehcode";
		  //  System.out.println(sql1);
		}
		else if(UserType1.equals("GROUP") && !(userName.equals("Manish Thapar")))
		{	
				sql1="Select distinct(vehcode) as vehcode1 from t_group where GPName='"+ UserTypeValue  +"' order by vehcode";	
		}
		else
		{
			sql1="Select distinct(vehcode) as vehcode1 from t_group where GPName='"+userName+"' union Select distinct(vehiclecode) as vehcode1 from t_vehicledetails where OwnerName='"+userName+"' ";
		}	
		
	}
	else
	{
		//System.out.println("**********&&&&&&&&&&&*****");
		sql="select * from t_security where TypeValue='"+userName+"'";
		ResultSet rst=st.executeQuery(sql);
		if(rst.next())
		{
		session.setAttribute("MM_Username", rst.getString("UserName"));
	    session.setAttribute("user",rst.getString("UserName"));	
		UserType1= rst.getString("TypeofUser");
		UserTypeValue = rst.getString("TypeValue"); 
		session.setAttribute("usertypevalue",UserTypeValue );
		session.setAttribute("TypeofUser",UserType1);
		
		}
		   if(userName.equals("Castrol")||userName.equals("DSC MAIN")||
				   userName.equals("Castrol EMP VEH")||
				   userName.equals("DelEx All")|| 
				   userName.equals("Nawany All")|| 
				   userName.equals("ACC") ||userName.equals("Praxair India Pvt.Ltd")||userName.equals("NECC ALL"))	   
		     {
			      sql1="Select distinct(vehcode) as vehcode1 from t_group where GPName='"+session.getAttribute("usertypevaluemain").toString()+"'  order by vehcode";
		     }
		   else if(userName.equals("Manish Thapar"))
		   {
			  sql1="Select distinct(vehcode) as vehcode1 from t_group where GPName IN('"+session.getAttribute("usertypevaluemain").toString()+"','Castrol Emp West Sanchay Singh Team','Castrol Emp Sanchay Singh Team','Nilesh Malani','Siddesh Vaity')  order by vehcode";
		   }
		else
		{
			sql1="Select distinct(vehcode) as vehcode1 from t_group where GPName='"+session.getAttribute("usertypevaluemain").toString()+"' and VehRegNo='"+userName+"' order by vehcode";

		}
	}
	System.out.println("------------>"+sql1);
	String targetvalue=session.getAttribute("usertypevaluemain").toString();
	ArrayList<String> target=(ArrayList<String>)session.getAttribute("TargetList");
	System.out.println("------------>"+target);
	System.out.println("------------>"+userName);
	System.out.println(target.contains(targetvalue) || target.contains(userName) || session.getAttribute("usertypevalue").equals("Castrol EMP VEH"));
	String flag = "No";
	
	String sqlcheck = "select distinct(vehregno) from db_gps.t_group where GPName = '"+userName+"' and sepreport = 'Yes'";
	ResultSet rscheck = st.executeQuery(sqlcheck);
	if(rscheck.next())
	{
		flag = "Yes";
	}
	else
		if(userName.equals("Castrol North") || userName.equals("Castrol East") || userName.equals("Castrol West") || userName.equals("Castrol South") || userName.equals("Castrol ILS"))
		{
			flag = "Yes";
		}
	
	System.out.println("flag    "+flag);
	System.out.println(((target.contains(targetvalue) || target.contains(userName) || session.getAttribute("usertypevalue").equals("Castrol EMP VEH")) && flag.equals("No")));
	if((target.contains(targetvalue) || target.contains(userName) || session.getAttribute("usertypevalue").equals("Castrol EMP VEH")) && flag.equals("No"))
	{
		System.out.println("****    vehiclelist  ");
		String hodid = "",Fname = "";
		Svehlist = "(0";
		String sqlemp = "select * from db_gps.t_userdetails where username = '"+session.getAttribute("user").toString()+"'";
		ResultSet rs1 = st.executeQuery(sqlemp);
		System.out.println("***     "+sqlemp);
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
		
		
		
		
		System.out.println("****    vehiclelist  "+Svehlist);
		
		
		 if(Fname == "Sanjay Jetly" || Fname.equals("Sanjay Jetly") || Fname == "Kishore Kumar" || Fname.equals("Kishore Kumar") )
		 {
			 String temvehlist = Svehlist;
			 temvehlist = temvehlist+")";
			 temvehlist = temvehlist.replace("(0,", "(");
			 
			 String sqlemp1 = "select distinct(vehiclecode) as vehiclecode from db_gps.t_vehicledetails where vehiclecode not in "+temvehlist+" and empname like  '%Idle%' and status <> 'deleted' and OwnerName in ('Castrol East','Castrol West','Castrol North','Castrol South')";
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
		 
		 
		// Svehlist=Svehlist+")";
		// Svehlist = Svehlist.replace("(0,", "(");
	
	}
	else
	{
		
	ResultSet rst1=st.executeQuery(sql1);
	while(rst1.next())
	{
		Svehlist=Svehlist+","+rst1.getString("vehcode1");
	}
	System.out.println("****  else  vehiclelist  "+Svehlist);
	}
	Svehlist=Svehlist+")";
	Svehlist=Svehlist.replace("(0,","(");
	System.out.println("****     "+Svehlist);
	session.setAttribute("VehList", Svehlist);
	session.setAttribute("vehlistnew","-");
	/********Start code to create an array of transporter name hows vehicles are selected *********/
	sql="select Distinct(OwnerName) from t_vehicledetails where vehiclecode in "+Svehlist+" order by OwnerName";
	ResultSet rst_owner=st.executeQuery(sql);
	String ownerlist="(";
	while(rst_owner.next())
	{
		ownerlist=ownerlist+"'"+rst_owner.getString("OwnerName")+"',";
	}
	ownerlist=ownerlist.substring(0,ownerlist.length()-1);
	ownerlist=ownerlist+")";
	
	//out.print(ownerlist);
	session.setAttribute("ownerlist",ownerlist);
	/********End code to create an array of transporter name hows vehicles are selected *********/
	
	String sql11="select * from t_defaultvals where OwnerName='"+UserTypeValue+"'";
	ResultSet rstx=st.executeQuery(sql11);
	if(rstx.next())
	{	
		sql11="select * from t_defaultvals where OwnerName='"+UserTypeValue+"'";
	}
	else
	{
		sql11="select * from t_defaultvals where OwnerName='Default'";
	
	}
	ResultSet rst11=st.executeQuery(sql11);
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
		session.setAttribute("dateformat",rst11.getString("DateFormat"));
	}
	
	/************************** code for table created for user name *************************************************************/
	String Muser=session.getAttribute("user").toString();
	String MM_Username=session.getAttribute("MM_Username").toString();
	System.out.println("MM_Username is:-------------------------"+MM_Username);
	String mainuser=session.getAttribute("mainuser").toString();
	System.out.println("mainuser is:-------------------------"+mainuser);
	String UserID=session.getAttribute("UserID").toString();
	System.out.println("UserID is:-------------------------"+UserID);

	int tecount=0;
	System.out.println("Muser is:-------------------------"+Muser);
	Muser=Muser.trim();
	String sql1 = "CREATE TABLE /*!32312 IF NOT EXISTS*/ t_"+UserID+"  (SrNo double NOT NULL auto_increment,VehList longtext,Key SrNo(SrNo)) TYPE=MyISAM";
	System.out.println("My query sql1:-----"+sql1);
	 //st99=conn.createStatement();
	 tecount=st99.executeUpdate(sql1);

	//if(tecount>1){
		String deluser="delete from t_"+UserID+" ";
		System.out.println("My query deluser:-----"+deluser);
		 //st92=conn.createStatement();
		st92.executeUpdate(deluser);
		Svehlist=Svehlist.replace("(", "");
		Svehlist=Svehlist.replace(")", "");
		Svehlist=Svehlist.trim();
		//String insrtmuser="insert into t_"+UserID+" (VehList) values('"+Svehlist+"')";
		String str123[]=Svehlist.split(",");
		 //st91=conn.createStatement();
	     for(int p=0;p<str123.length;p++){
		//String insrtmuser="insert into t_"+UserID+" (VehList) values('"+Svehlist+"')";
		String insrtmuser="insert into t_"+UserID+" (VehList) values('"+str123[p]+"')";
		//System.out.println("My query insrtmuser:-----"+insrtmuser);
		st91.executeUpdate(insrtmuser);
	     }
	//}
	
	System.out.println("******185   "+target);
	
	if(target.contains(targetvalue))
	{
		System.out.println("******188   "+targetvalue);
		response.sendRedirect("castrolempmain.jsp");
	}
	
	
	//String common=session.getAttribute("usertypevalue").toString();
	if(target.contains(userName))
	{
		System.out.println("******196   "+userName);
		response.sendRedirect("castrolempmain.jsp");
	}
	
	if(session.getAttribute("usertypevalue").equals("Castrol EMP VEH"))
	{
		System.out.println("******196   "+session.getAttribute("usertypevalue"));
		response.sendRedirect("castrolempmain.jsp");
	}
	
	else
	{	
		System.out.println("******208  else ");
	response.sendRedirect("currentposition.jsp");
	}
	}
	else
	{
		System.out.println("204 Hii");
		Msg = "1";
		response.sendRedirect("selectuser.jsp?Msg="+Msg);
	}


/************************** code for table created for user name *************************************************************/
	String Muser=session.getAttribute("user").toString();
	String MM_Username=session.getAttribute("MM_Username").toString();
	System.out.println("MM_Username is:-------------------------"+MM_Username);
	String mainuser=session.getAttribute("mainuser").toString();
	System.out.println("mainuser is:-------------------------"+mainuser);
	String UserID=session.getAttribute("UserID").toString();
	System.out.println("UserID is:-------------------------"+UserID);

	int tecount=0;
	System.out.println("Muser is:-------------------------"+Muser);
	Muser=Muser.trim();
	String sql1 = "CREATE TABLE /*!32312 IF NOT EXISTS*/ t_"+UserID+"  (SrNo double NOT NULL auto_increment,VehList longtext,Key SrNo(SrNo)) TYPE=MyISAM";
	System.out.println("My query sql1:-----"+sql1);
	 //st99=conn.createStatement();
	 tecount=st99.executeUpdate(sql1);

	//if(tecount>1){
		String deluser="delete from t_"+UserID+" ";
		System.out.println("My query deluser:-----"+deluser);
		 //st92=conn.createStatement();
		st92.executeUpdate(deluser);
		Svehlist=Svehlist.replace("(", "");
		Svehlist=Svehlist.replace(")", "");
		Svehlist=Svehlist.trim();
		//String insrtmuser="insert into t_"+UserID+" (VehList) values('"+Svehlist+"')";
		String str123[]=Svehlist.split(",");
		 //st91=conn.createStatement();
	     for(int p=0;p<=str123.length;p++){
		//String insrtmuser="insert into t_"+UserID+" (VehList) values('"+Svehlist+"')";
		String insrtmuser="insert into t_"+UserID+" (VehList) values('"+str123[p]+"')";
		//System.out.println("My query insrtmuser:-----"+insrtmuser);
		st91.executeUpdate(insrtmuser);
	     }
	//}





}catch(Exception e)
{
	out.print("Exception---->"+e);
	e.printStackTrace();
}
finally
{
	try
	{
	conn.close();
	}catch(Exception e)
	{e.printStackTrace();}
	try
	{
		fleetview.closeConnection();
	}catch(Exception e)
	{}
	
}



%>
<% //fleetview.closeConnection(); %>