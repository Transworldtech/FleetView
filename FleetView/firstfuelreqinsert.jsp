<%@ include file="Connections/conn.jsp" %>

<%@page import="java.util.Date"%>
<%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page import="java.sql.*" %>

  	<%@ page import = "java.io.FileNotFoundException"%>
  	<%@ page import = "java.io.FileOutputStream"%>
  	<%@ page import = "java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>
  	<%@page import="java.io.BufferedReader" import="java.io.InputStreamReader" import="java.net.URL" %>
  	<%@page import="java.net.URLEncoder" import="java.net.URLConnection"%>
  	
  	 

<%!
Connection con1;
Statement st,st1,st2,st3,st4,st5;
%>
<% 
try {
	int i=1;
	String owner=session.getAttribute("usertypevalue").toString();
	String user=session.getAttribute("mainuser").toString();
	String totcountrecord=request.getParameter("element_3_9");
	int totcountrecord1=Integer.parseInt(totcountrecord);
	//out.println("here"+routeid);
	String totcountfuel=request.getParameter("element_3_10");
	String FuelIssueCategory=request.getParameter("element_3_6");
	
	String VehRegNo=request.getParameter("VehRegNo");
	String StartPlace=request.getParameter("StartPlace");
	String EndPlace=request.getParameter("EndPlace");
	String FIxedKM=request.getParameter("FIxedKM");
	String GPName=request.getParameter("GPName");
	String Customer=request.getParameter("Customer");
	String tripdays=request.getParameter("tripdays");
	String Kmpl=request.getParameter("Kmpl");
	String TripID=request.getParameter("TripID");
	String DriverCode=request.getParameter("DriverCode");
	String DriverName=request.getParameter("DriverName");
	String vehcode1=request.getParameter("vehcode");
	
	
	Format fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Format fmt1 = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat sdfIn = new SimpleDateFormat("dd-MMM-yyyy");
	SimpleDateFormat sdfOut = new SimpleDateFormat("yyyy-MM-dd");
	 
	 
	String insertdate = fmt.format(new java.util.Date());
	//out.println("here"+insertdate);
	
	
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();

ResultSet rst=null;

	
	String fuelentr[];
	String fuelentr1="",amnt1="",fdate1="";
	String amnt[];
	String fdate[];
	Double fuelrate=0.0,deffuelrate,fuelamount=0.0;
	String day="",geofencename="",geofenceid="",geoKm="",geoquantity="",geoamt="",distancernge="",distquantity="",distamt="",fueldaybufftm="";
	String cardno="",cardvendor="";
	int cnt=0;
	
	
/////////////////////////Default fuel rate ................//////////////////////////////////

//Double fuelra te=0.0;

String Fuel="";

String fueltype="select Fuel from db_gps.t_VehMst where VehId='"+vehcode1+"' ";
//String record="select fuelrate from db_gps.t_defaultvals where OwnerName='BDDhalla' ";
//System.out.println("re=codr:--********************************"+fueltype);
PreparedStatement ps4=con1.prepareStatement(fueltype);
ResultSet rs4=ps4.executeQuery();
if(rs4.next())
{
Fuel=rs4.getString("Fuel");

}

if(Fuel.equals("-") || Fuel.equalsIgnoreCase("-"))
{

String record="select rate from db_gps.t_Defaultfuelratemaster where fuel='"+Fuel+"' and transporter='"+GPName+"' order by UpdatedDate desc limit 1";
//String record="select fuelrate from db_gps.t_defaultvals where OwnerName='BDDhalla' ";
System.out.println("re=codr:--********************************"+record);
PreparedStatement ps2=con1.prepareStatement(record);
ResultSet rs2=ps2.executeQuery();
if(rs2.next())
{
fuelrate=rs2.getDouble("rate");
//System.out.println("fuelrate1:--********************************"+fuelrate);

if(fuelrate.equals("-") ){
String record1="select rate from db_gps.t_Defaultfuelratemaster where fuel='"+Fuel+"' and transporter='Default' ";
//System.out.println("re=codr:--********************************"+record1);
PreparedStatement ps3=con1.prepareStatement(record1);
ResultSet rs3=ps3.executeQuery();
if(rs3.next()){
fuelrate=rs3.getDouble("rate");
//System.out.println("fuelrate3:--********************************"+fuelrate);
}

}
}

}else{

String record="select rate from db_gps.t_Defaultfuelratemaster where fuel='Diesel' and transporter='"+GPName+"' order by UpdatedDate desc limit 1";
//String record="select fuelrate from db_gps.t_defaultvals where OwnerName='BDDhalla' ";
System.out.println("re=codr:--********************************"+record);
PreparedStatement ps2=con1.prepareStatement(record);
ResultSet rs2=ps2.executeQuery();
if(rs2.next())
{
fuelrate=rs2.getDouble("rate");
//System.out.println("fuelrate1:--********************************"+fuelrate);

if(fuelrate.equals("-") ){
String record1="select rate from db_gps.t_Defaultfuelratemaster where fuel='Diesel' and transporter='Default' ";
//System.out.println("re=codr:--********************************"+record1);
PreparedStatement ps3=con1.prepareStatement(record1);
ResultSet rs3=ps3.executeQuery();
if(rs3.next()){
fuelrate=rs3.getDouble("rate");
//System.out.println("fuelrate3:--********************************"+fuelrate);
}

}
}

}// end of else

	
	
	/* String record="select fuelrate from db_gps.t_defaultvals where OwnerName='"+GPName+"' ";
	//String record="select fuelrate from db_gps.t_defaultvals where OwnerName='BDDhalla' ";
	System.out.println("re=codr:--********************************"+record);
	PreparedStatement ps2=con1.prepareStatement(record);
	ResultSet rs2=ps2.executeQuery();
	if(rs2.next())
	{
		fuelrate=rs2.getDouble("fuelrate");
		//System.out.println("fuelrate1:--********************************"+fuelrate);
		
		if(fuelrate.equals("0.0") || fuelrate==0.0){
			String record1="select fuelrate from db_gps.t_defaultvals where OwnerName='Default' ";
			//System.out.println("re=codr:--********************************"+record1);
			PreparedStatement ps3=con1.prepareStatement(record1);
			ResultSet rs3=ps3.executeQuery();
	        if(rs3.next()){
	        	fuelrate=rs3.getDouble("fuelrate");
	        	//System.out.println("fuelrate3:--********************************"+fuelrate);
	        }
       			
		}
	} */
	
	//////////////////////////////////////////Card holder and card id ///////////////////////////////////
	
	//String record9="select cardno,companyname from db_gps.t_cardmaster where driverid='12345678' ";
	String record9="select cardno,companyname from db_gps.t_cardmaster where driverid='"+DriverCode+"' ";
	PreparedStatement ps9=con1.prepareStatement(record9);
	ResultSet rs9=ps9.executeQuery();
    if(rs9.next()){
    	cardno=rs9.getString("cardno");
    	cardvendor=rs9.getString("companyname");
     }
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	
	////////////////////////////////////////////Tripid vehcode main query///////////////////////////////////////
					String vehcode="",vehStartDate="",StartTime="",vehstdatetime="";
					String TheDate="",TheTime="",Datadatetime="";
					String vehcodequry="select Vehid,StartDate,StartTime from db_gps.t_startedjourney where TripID='"+TripID+"' ";
			        PreparedStatement ps10=con1.prepareStatement(vehcodequry);
			        ResultSet rs10=ps10.executeQuery();
					if(rs10.next()){
	                         vehcode=rs10.getString("Vehid");
	                         vehStartDate=rs10.getString("StartDate");
	                         StartTime=rs10.getString("StartTime");
	                         vehstdatetime=vehStartDate+" "+StartTime;
	                         
	                        String fir="select LatitudePosition,LongitudePosition,TheDate,TheTime from db_gps.t_onlinedata where LoadStatusTime>='"+vehstdatetime+"' and vehiclecode='"+vehcode+"' order by LoadStatusTime desc limit 1 ";
	       					System.out.println("firrec==================================>"+fir);
	       			        PreparedStatement ps8=con1.prepareStatement(fir);
	       			        //ps8.setString(1, "Km");
	       			        ResultSet rs8=ps8.executeQuery();
	                           if(rs8.next())
	                           {
	                           	TheDate=rs8.getString("TheDate");
	                           	TheTime=rs8.getString("TheTime");
	                           	Datadatetime=TheDate+" "+TheTime;
	                           	
	                           }
					}
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	if(FuelIssueCategory.equals("Daywise")){
		
		try{
			
			try{
                String record="select fueldaybufftm from db_gps.t_defaultvals where OwnerName='"+GPName+"' ";
    	        System.out.println("re=codr:--********************************"+record);
    	        PreparedStatement psgeobuf=con1.prepareStatement(record);
    	       ResultSet rs2geobuff=psgeobuf.executeQuery();
    	  if(rs2geobuff.next())
    	   {
    		fueldaybufftm=rs2geobuff.getString("fueldaybufftm");
    		//System.out.println("fuelbuffkm:--********************************"+fuelbuffkm);
    		
    		if(fueldaybufftm.equals("06:00:00") || fueldaybufftm=="06:00:00"){
    			String record1="select fueldaybufftm from db_gps.t_defaultvals where OwnerName='Default' ";
    			//System.out.println("re=codr:--********************************"+record1);
    			PreparedStatement psgeobuf3=con1.prepareStatement(record1);
    			ResultSet rs3geobuff=psgeobuf3.executeQuery();
    	        if(rs3geobuff.next()){
    	        	fueldaybufftm=rs3geobuff.getString("fueldaybufftm");
    	        	//System.out.println("fuelbuffkm:--********************************"+fuelbuffkm);
    	          }
           			
    		   }
    	  }
        }catch(Exception e){
    	e.printStackTrace();
      }
			
			
			
			for(i=1; i < totcountrecord1; i++){
				System.out.println("1");
				 fuelentr1=request.getParameter("fuelentr"+i);
				 amnt1=request.getParameter("amt9"+i);
				 fdate1=request.getParameter("fdate"+i);
				 System.out.println("2");
				 Date date = sdfIn.parse(fdate1);
			     day=sdfOut.format(date);
				 //day=fmt1.format(fdate1);
				 //day=new SimpleDateFormat("yyyy-MM-dd").format(fdate1);
				 
				 //day=day+" 06:00:00";
				 
				 day=day+" "+fueldaybufftm;
				 
				 System.out.println("day:-"+day);
				 
				 System.out.println("fuelentr"+fuelentr1);
				 System.out.println("amnt"+amnt1);
				 System.out.println("fdate"+fdate1);
				 String insrtmaster="insert into db_gps.t_fuelissuemaster(Tripid,Owner,Vendor,FuelIssueCategory,Distance,Day,FuelQuantity,Rate,Amount,Currency,Status,EntryBy,InsertDt,driver_id,drivername,vehregno,card_id,cardvendor) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				 System.out.println("fulmaster*************************************************:-"+insrtmaster);
				PreparedStatement ps1=con1.prepareStatement(insrtmaster);
				//out.println("fulmaster*************************************************:-"+insrtmaster);
				ps1.setString(1, TripID);
				ps1.setString(2, GPName);
				ps1.setString(3, Customer);
				ps1.setString(4, FuelIssueCategory);
				ps1.setString(5, FIxedKM);
				ps1.setString(6, day);
				ps1.setString(7, fuelentr1);
				ps1.setDouble(8, fuelrate);
				ps1.setString(9, amnt1);
				ps1.setString(10, "Rs");
				ps1.setString(11, "Pending");
				ps1.setString(12, user);
				ps1.setString(13, insertdate);
				ps1.setString(14, DriverCode);
				ps1.setString(15, DriverName);
				ps1.setString(16, VehRegNo);
				ps1.setString(17, cardno);
				ps1.setString(18, cardvendor);
				

				cnt=ps1.executeUpdate();
				 }
			//System.out.println("fuelentr"+fuelentr1);
			//System.out.println("amnt"+amnt1);
			//System.out.println("fdate"+fdate1);
			
			
		}catch(Exception e)
		  {e.printStackTrace();}
		
	}else if(FuelIssueCategory.equals("Geofence"))
	{
		
          try{
        	  String finalgeofencename[],finalgeofenceid[];
        	  Double Latitude=0.0,Longitude=0.0;
			         for(i=1; i < totcountrecord1; i++){
			        	 geofenceid=request.getParameter("geofenceid"+i);
            out.println("geofenceid*************************************************:-"+geofenceid);
			        	 finalgeofenceid=geofenceid.split("-");
            out.println("finalgeofenceid*************************************************:-"+finalgeofenceid);
			        	 geofencename=request.getParameter("geofencename"+i);
            out.println("geofencename*************************************************:-"+geofencename);
			        	 //finalgeofencename=geofencename.split("-");
			        	 String prevdt="select * from db_gps.t_warehousedata where WareHouseCode=? and owner=? and WareHouse=?";
			        	 //String prevdt="select * from db_gps.t_warehousedata where WareHouse=? and owner=? ";
					        PreparedStatement ps7=con1.prepareStatement(prevdt);
					                ps7.setString(1, geofenceid);
			                        ps7.setString(2, owner);
			                        ps7.setString(3, geofencename);
							ResultSet rs7=ps7.executeQuery();
							if(rs7.next()){
							Latitude=rs7.getDouble("Latitude");
			                Longitude=rs7.getDouble("Longitude");
							//dprevdistance=Double.parseDouble(prevdistance);
							//System.out.println("prevdistance:-"+prevdistance);
							}
				         geoKm=request.getParameter("geoKm"+i);
				         geoquantity=request.getParameter("geoquantity"+i);
                          geoamt=request.getParameter("geoamt"+i);
                          
                          
                      if(i==1){
                    	  String insrtmaster="insert into db_gps.t_fuelissuemaster(Tripid,Owner,Vendor,FuelIssueCategory,Distance,Day,Geofence,FuelQuantity,Rate,Amount,Currency,Status,EntryBy,InsertDt,Latitude,Longitude,driver_id,drivername,vehregno,card_id,cardvendor,Datadatetime) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    				      System.out.println("fulmaster*************************************************:-"+insrtmaster);
    				      PreparedStatement ps1=con1.prepareStatement(insrtmaster);
    				     System.out.println("fulmaster*************************************************:-"+insrtmaster);
    				      ps1.setString(1, TripID);
    				      ps1.setString(2, GPName);
    				      ps1.setString(3, Customer);
    				      ps1.setString(4, FuelIssueCategory);
    				      ps1.setString(5, geoKm);
    				      ps1.setString(6, vehstdatetime);
    				      ps1.setString(7, geofencename);
    				      ps1.setString(8, geoquantity);
    				      ps1.setDouble(9, fuelrate);
    				      ps1.setString(10, geoamt);
    				      ps1.setString(11, "Rs");
    				      ps1.setString(12, "Pending");
    				      ps1.setString(13, user);
    				      ps1.setString(14, insertdate);
    				      ps1.setDouble(15, Latitude);
    				      ps1.setDouble(16, Longitude);
    				      ps1.setString(17, DriverCode);
    					  ps1.setString(18, DriverName);
    					  ps1.setString(19, VehRegNo);
    					  ps1.setString(20, cardno);
    					  ps1.setString(21, cardvendor);
    					  ps1.setString(22, Datadatetime);

    				      cnt=ps1.executeUpdate();
  
                      }else{
                      String insrtmaster="insert into db_gps.t_fuelissuemaster(Tripid,Owner,Vendor,FuelIssueCategory,Distance,Geofence,FuelQuantity,Rate,Amount,Currency,Status,EntryBy,InsertDt,Latitude,Longitude,driver_id,drivername,vehregno,card_id,cardvendor) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				      System.out.println("fulmaster*************************************************:-"+insrtmaster);
				      PreparedStatement ps1=con1.prepareStatement(insrtmaster);
				     //out.println("fulmaster*************************************************:-"+insrtmaster);
				      ps1.setString(1, TripID);
				      ps1.setString(2, GPName);
				      ps1.setString(3, Customer);
				      ps1.setString(4, FuelIssueCategory);
				      ps1.setString(5, geoKm);
				      ps1.setString(6, geofencename);
				      ps1.setString(7, geoquantity);
				      ps1.setDouble(8, fuelrate);
				      ps1.setString(9, geoamt);
				      ps1.setString(10, "Rs");
				      ps1.setString(11, "Unprocessed");
				      ps1.setString(12, user);
				      ps1.setString(13, insertdate);
				      ps1.setDouble(14, Latitude);
				      ps1.setDouble(15, Longitude);
				      ps1.setString(16, DriverCode);
					  ps1.setString(17, DriverName);
					  ps1.setString(18, VehRegNo);
					  ps1.setString(19, cardno);
					  ps1.setString(20, cardvendor);
						

				      cnt=ps1.executeUpdate();
                      }// else loop of insert      

}
}catch(Exception e)
		  {e.printStackTrace();}
		
	}else if(FuelIssueCategory.equals("Km")){
		
		
		try{
			
	         for(i=1; i < totcountrecord1; i++){
            
	        	 distancernge=request.getParameter("distancernge"+i);
		         distquantity=request.getParameter("distquantity"+i);
		         distamt=request.getParameter("distamt"+i);

             if(i==1){
            	 String insrtmaster="insert into db_gps.t_fuelissuemaster(Tripid,Owner,Vendor,FuelIssueCategory,Distance,Day,FuelQuantity,Rate,Amount,Currency,Status,EntryBy,InsertDt,driver_id,drivername,vehregno,card_id,cardvendor) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
   		      System.out.println("fulmaster*************************************************:-"+insrtmaster);
   		      PreparedStatement ps1=con1.prepareStatement(insrtmaster);
   		     //out.println("fulmaster*************************************************:-"+insrtmaster);
   		      ps1.setString(1, TripID);
   		      ps1.setString(2, GPName);
   		      ps1.setString(3, Customer);
   		      ps1.setString(4, FuelIssueCategory);
   		      ps1.setString(5, distancernge);
   		      ps1.setString(6, vehstdatetime);
   		      ps1.setString(7, distquantity);
   		      ps1.setDouble(8, fuelrate);
   		      ps1.setString(9, distamt);
   		      ps1.setString(10, "Rs");
   		      ps1.setString(11, "Pending");
   		      ps1.setString(12, user);
   		      ps1.setString(13, insertdate);
   		      ps1.setString(14, DriverCode);
   			  ps1.setString(15, DriverName);
   			  ps1.setString(16, VehRegNo);
   			  ps1.setString(17, cardno);
   			  ps1.setString(18, cardvendor);
   				

   		      cnt=ps1.executeUpdate();
            	 
             }else{
             String insrtmaster="insert into db_gps.t_fuelissuemaster(Tripid,Owner,Vendor,FuelIssueCategory,Distance,FuelQuantity,Rate,Amount,Currency,Status,EntryBy,InsertDt,driver_id,drivername,vehregno,card_id,cardvendor) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		      System.out.println("fulmaster*************************************************:-"+insrtmaster);
		      PreparedStatement ps1=con1.prepareStatement(insrtmaster);
		     //out.println("fulmaster*************************************************:-"+insrtmaster);
		      ps1.setString(1, TripID);
		      ps1.setString(2, GPName);
		      ps1.setString(3, Customer);
		      ps1.setString(4, FuelIssueCategory);
		      ps1.setString(5, distancernge);
		      //ps1.setString(6, geofencename);
		      ps1.setString(6, distquantity);
		      ps1.setDouble(7, fuelrate);
		      ps1.setString(8, distamt);
		      ps1.setString(9, "Rs");
		      ps1.setString(10, "Unprocessed");
		      ps1.setString(11, user);
		      ps1.setString(12, insertdate);
		      ps1.setString(13, DriverCode);
			  ps1.setString(14, DriverName);
			  ps1.setString(15, VehRegNo);
			  ps1.setString(16, cardno);
			  ps1.setString(17, cardvendor);
				

		      cnt=ps1.executeUpdate();

             }//else loop of inert
}
}catch(Exception e)
 {e.printStackTrace();}
		
	}
	
	else{
		
	}
	
	if(cnt>=1){
		String updateTableSQL = "UPDATE db_gps.t_startedjourney SET fuelrequest = ? WHERE TripID = ? and StartPlace= ? and EndPlace=?";
		PreparedStatement preparedStatement = con1.prepareStatement(updateTableSQL);
		preparedStatement.setString(1, "Yes");
		preparedStatement.setString(2, TripID);
		preparedStatement.setString(3, StartPlace);
		preparedStatement.setString(4, EndPlace);

		preparedStatement .executeUpdate();
		
	}
	%>
	<div align="center">
	<br>
	<br>
	<font size="2" color="red">Request Genrated Sucessfully...</font>
	<br>
	<font size="2" color="red">Your Request Number is :-<%=TripID+"_"+insertdate%></font>
	<br>
	<font size="2" color="red">Wait for Page redirection........</font>
	</div>
	<script type="text/javascript">
		try{
	    setTimeout("self.close()", 1500 );
	//	alert("Trip ended Successfully");
		//window.close();
		window.opener.location.reload("FirstFuelRequest.jsp");
		}
		catch(e)
		{
			alert(e);
		}
		</script>
	<% 
	//opener.location.href = '/FirstFuelRequest.jsp';
	//close();
	
	try{
	/* String loc="select WareHouseCode from db_gps.t_warehousedata where WareHouse=? and Status=? "; 
    PreparedStatement ps=con1.prepareStatement(loc);
	ps.setString(1, geofencename);
	ps.setString(2, "Active");
	ResultSet rs=ps.executeQuery();
	if(rs.next()){
		WareHouseCode=rs.getString("WareHouseCode");
	} */
	//out.println("here"+WareHouseCode);
/* String insrtmaster="insert into db_gps.t_geofencefuelplan(routeid,geofenceid,geofencename,Km,entryby,insertdate,owner) values(?,?,?,?,?,?,?) ";
//out.println("fulmaster*************************************************:-"+insrtmaster);
PreparedStatement ps1=con1.prepareStatement(insrtmaster);
//out.println("fulmaster*************************************************:-"+insrtmaster);
ps1.setString(1, routeid);
ps1.setString(2, WareHouseCode);
ps1.setString(3, geofencename);
ps1.setString(4, km);
ps1.setString(5, user);
ps1.setString(6, insertdate);
ps1.setString(7, owner);

ps1.executeUpdate();
 */
 //response.sendRedirect("RoutePlan.jsp");
 
}catch(Exception e)
{e.printStackTrace();}

} catch(Exception e) { 
	out.print("NotDone");
	}
	finally
	{
		//st.close();
		//st1.close();
		con1.close();
	}

%>