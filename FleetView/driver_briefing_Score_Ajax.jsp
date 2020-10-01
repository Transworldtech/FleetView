
<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
Statement st,st1,st2,st3;
%>
<% 
try {

Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();
st2=con1.createStatement();
st3=con1.createStatement();
ResultSet rst=null;
String sql="";
boolean flag=false;
int element=99;
System.out.println("IN1");
String DriveId=request.getParameter("DriveId");
String TripId=request.getParameter("TripId");

int scrNDH=Integer.parseInt(request.getParameter("scrNDH"));

int scrNND=Integer.parseInt(request.getParameter("scrNND"));
int scrNCD=Integer.parseInt(request.getParameter("scrNCD"));
int scrNDVI=Integer.parseInt(request.getParameter("scrNDVI"));
int TNScr=scrNCD+scrNDH+scrNDVI+scrNND;
String Tripid1="";
//String debriefid=request.getParameter("debriefid");





String sql7="SELECT * FROM db_gps.t_DriverScore where GPName='Castrol'";
	ResultSet rs7 = st2.executeQuery(sql7);
	System.out.println(sql7);

	int MaxPointND=0,MaxPointCD=0,MaxPointRH=0,MaxPointAdh=0,MaxPointDVI=0;
	while(rs7.next())
	{
		if(rs7.getString("ScoreCategory").equalsIgnoreCase("ND"))
				{
				MaxPointND=rs7.getInt("Points");
				System.out.println("MaxPointND:"+MaxPointND);
				}
			
		if(rs7.getString("ScoreCategory").equalsIgnoreCase("CD"))
		{
		MaxPointCD=rs7.getInt("Points");
		}

		if(rs7.getString("ScoreCategory").equalsIgnoreCase("RunHrs"))
		{
		MaxPointRH=rs7.getInt("Points");
		}

		if(rs7.getString("ScoreCategory").equalsIgnoreCase("Adherence to Journey Plan"))
		{	
		MaxPointAdh=rs7.getInt("Points");
		System.out.println("MaxPointAdh"+MaxPointAdh);
		}
		
	}
		
	String sql8="SELECT max(Points) as Points FROM db_gps.t_DriverScore where GPName='Castrol' and ScoreCategory='DVI' ";
	ResultSet rs8 = st3.executeQuery(sql8);
	System.out.println(sql8);

	if(rs8.next())
	{
		MaxPointDVI=rs8.getInt("Points");
	}

System.out.println(MaxPointDVI);

String sql2="SELECT tripid, driverid FROM db_gps.t_debriefing WHERE Driverid = '"+DriveId+"' AND tripid ='"+TripId+"' ORDER BY updateddt DESC";
	System.out.println(sql2);
		ResultSet rs2=st1.executeQuery(sql2);
		System.out.println("ccccccccccccccccccccccccccccccccccc=====551" +sql2);
		if(rs2.next()){
			Tripid1=rs2.getString("tripid");
	}		


String buffer;

System.out.println(scrNDH+"DH "+MaxPointRH+"ND "+scrNND+"ND "+MaxPointND+"CD "+scrNCD+"cd "+MaxPointCD+"DV "+scrNDVI+"DV "+MaxPointDVI);

if(scrNDH>MaxPointRH||scrNND>MaxPointND||scrNCD>MaxPointCD||scrNDVI>MaxPointDVI)
{
	System.out.println("$$$$$$"+sql);
			buffer="NoUpdated~"+TNScr;
			System.out.println("NoUpdates : "+sql);
			out.print(buffer);
}
else{
	try{
sql="UPDATE db_gps.t_briefing SET scr_N_DH='"+scrNDH+"',scr_N_ND= '"+scrNND+"',scr_N_CD= '"+scrNCD+"',scr_N_DVI= '"+scrNDVI+"'  WHERE Driverid='"+DriveId+"' and  TripID='"+TripId+"'";   
System.out.println("$$$$$$"+sql);
int ins=0;	/*****************************/

ins=st.executeUpdate(sql);



System.out.println("$$$$$$"+sql);
if(ins>=1){
		buffer="Updated~"+TNScr;
		System.out.println("Updates : "+sql);
		out.print(buffer);
		}

//buffer=null;
}
	catch(Exception e) { 
		out.print("NotDoneCatch");
		}
}
} catch(Exception e) { 
	out.print("NotDoneCatch2");
	}
	finally
	{
		st.close();
		con1.close();
	}
%>