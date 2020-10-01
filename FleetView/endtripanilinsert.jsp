<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 4.01 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<%@ include file="Connections/conn.jsp" %>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
<%

fleetview.getConnection(MM_dbConn_DRIVER,MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
fleetview.getConnection1(MM_dbConn_DRIVER,MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*" errorPage="" %>

<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%@ page import = "java.io.FileNotFoundException"%>
  	<%@ page import = "java.io.FileOutputStream"%>
  	<%@ page import = " java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>
<%@ page buffer="16kb" %>

<%!
Connection conn,conn1;
Statement s1,stmtinsert,stmt1,stmt2,stmt3,stquery,stmt4,st3R,st1R,st2R,st4R;
private static boolean intersects(long r1start, long r1end, long r2start, long r2end) 
{
	return (r1start == r2start) || (r1start > r2start ? r1start <=r2end : r2start <= r1end);

}
%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

	<title>Seven Day Diary System.</title>
	<link rel="stylesheet" href="style.css" type="text/css" charset="utf-8" />
	<link rel="stylesheet" href="css/css.css" type="text/css" charset="utf-8" />
	<script src="sorttable.js" type="text/javascript"></script>


<% 
try
{
	//Class.forName(MM_dbConn_DRIVER); 
	conn = fleetview.ReturnConnection();
	conn1 = fleetview.ReturnConnection1();	
	s1=conn.createStatement();
	stmtinsert=conn.createStatement();
	
	stmt1=conn.createStatement();
	stmt2=conn.createStatement();
	stmt3=conn.createStatement();
	stmt4=conn.createStatement();
	stquery=conn.createStatement();
	st3R=conn.createStatement();
	st1R=conn.createStatement();
	st2R=conn.createStatement();
	st4R=conn.createStatement();
}
catch(Exception e)
{
	out.println(e);
}
%>
<%
ResultSet rs1=null, rs4=null, rs5=null, rs7=null, rs8=null, rs10=null, rs11=null, rs13=null, rs14=null, rs15=null,rs151=null, rs16=null, rs17=null,rs18=null;
int oscount=0,account=0,dccount=0,distance=0,stopcount=0, stkm=0, endkm=0, totkm=0;
double stlat=0, stlong=0, endlat=0, endlong=0,osdur=0;
Boolean flag=false,flag1=true;
String unloadtime="",endtime="",vehno="",tripid="",enddate="",endhrs="",endmin="",unloaddate="",unloadendhrs="",unloadendmin="",Unloadingcomment="",delayrsn="",pageflag="";
String location="", latitu="", longi="",itemName="",Reasonnew="",udr="",weight="",vendor="",fromdate="",fromtime="",fromdatetime="",today="",podnumber="";
int  filecount = 0,count1 = 0,i=0;
File savedFile;
String InsertDateTime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
String vehcode="", vehreg="", stplace="", endplace="",vehiclecode="",tripcat="",rptdatetme="",loadingdelay="",Unloadingdelay="", driverid="", drivername="", stcode="", endcode="", gpname="",ownername="";
String stdate="", sttime="",entryby = "",JDtrip = "No";
String loginuser=session.getValue("user").toString();
String user=session.getValue("usertypevalue").toString();
String rfname=session.getAttribute("rfname").toString(); //.setAttribute("rfname",fnamelist);
String rlname=session.getAttribute("rlname").toString();
java.util.Date d=new java.util.Date();

String dte=new SimpleDateFormat("yyyy-MM-dd").format(d);
int hours=(d.getHours());
int minutes=(d.getMinutes());
java.util.Date datefrmdb=new SimpleDateFormat("yyyy-MM-dd").parse(dte);
	Format formatter=new SimpleDateFormat("yyyy-MM-dd");
	String nwfrmtdte=formatter.format(datefrmdb);

java.util.Date datefrmdb1=new java.util.Date();
Format formatter1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String nwfrmtdte1=formatter1.format(datefrmdb1);
	today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	String today1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
today=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(today));  


try{
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (!isMultipart) {
		System.out.println("\n\nin multipart..");
	} 
	else
	{
		System.out.println("\n\n in else with  multipart..");
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List items = null;
		try {
			items = upload.parseRequest(request);
		//	System.out.print("\n\n items==>"+items);
		} catch (FileUploadException e) {
			e.printStackTrace();
		}
		Iterator itr = items.iterator();
		System.out.println("enddate-------------------------------------------------------------------->>");

		while (itr.hasNext()) {
			FileItem item = (FileItem) itr.next();
			if(item.isFormField()) 
			{
				
				String name = item.getFieldName();
				System.out.print("\n name==>"+name);
				String value = item.getString();
				
				
				
				
				
				
				
				
				
				if(name.equals("endtime1")) 
				{
					endhrs = value;
					System.out.print("\n endhrs==>"+endhrs);
					count1 = 1;
				}
				
				
				if(name.equals("endtime2")) 
				{
					endmin = value;
					System.out.print("\n endmin==>"+endmin);
					count1 = 1;
				}
				
				
				
				if(name.equals("endtime11")) 
				{
					unloadendhrs = value;
					System.out.print("\n unloadendhrs==>"+unloadendhrs);
					count1 = 1;
				}
				
						
				
				if(name.equals("endtime12")) 
				{
					unloadendmin = value;
					System.out.print("\n unloadendmin==>"+unloadendmin);
					count1 = 1;
				}
				
				
				
				
				
				if(name.equals("podnumber")) 
				{
					podnumber = value;
					System.out.print("\n podnumber==>"+podnumber);
					count1 = 1;
				}
				
				
				
				
				if(name.equals("unloadcmnt")) 
				{
					Unloadingcomment = value;
					System.out.print("\n Unloadingcomment==>"+Unloadingcomment);
					count1 = 1;
				}
				
				
				if(name.equals("udr")) 
				{
					udr = value;
					System.out.print("\n udr==>"+udr);
					count1 = 1;
				}
				
				
				if(name.equals("udr1")) 
				{
					delayrsn = value;
					System.out.print("\n delayrsn==>"+delayrsn);
					count1 = 1;
				}
				
				
			
			
			if(name.equals("calender1")) 
			{
				enddate = value;
				System.out.print("\n enddate==>"+enddate);
				count1 = 1;
			}
			if(name.equals("calender11")) 
			{
				unloaddate = value;
				System.out.print("\n unloaddate==>"+unloaddate);
				count1 = 1;
			}
			if(name.equals("tripid")) 
			{
				tripid = value;
				System.out.print("\n tripid==>"+tripid);
				count1 = 1;
			}
			if(name.equals("page")) 
			{
				page = value;
				System.out.print("\n page==>"+page);
				count1 = 1;
			}
			if(name.equals("locat")) 
			{
				location = value;
				System.out.print("\n location==>"+location);
				count1 = 1;
			}
			if(name.equals("Reason")) 
			{
				Reasonnew = value;
				System.out.print("\n Reason==>"+Reasonnew);
				count1 = 1;
			}
			}


		
		else {	
				try {

					 itemName = item.getName();
					System.out.print("\n\nitemName22<<<<<<<<==>"+itemName);
					if(itemName.equalsIgnoreCase(""))
					{
					}
					else
					{
						try{
					
							System.out.println("HHHHHH ----------------------------------> ");
							//savedFile = new File("/home/a_raina/test/"+InsertDateTime+"_"+itemName);
						 // loadKML("http://myfleetview.com:8080/images1/kmlfile/"+kmlfile1);
                            // savedFile = new File("http://192.168.2.55:8080/images1/savedimages/"+InsertDateTime+"_"+itemName); 
							 savedFile = new File("/usr/share/tomcat6/webapps/images1/savedimages/"+InsertDateTime+"_"+itemName);
								System.out.print("\n\nsavedFile==>"+savedFile);
								item.write(savedFile);
								
								
						
					}catch(Exception e)
					{
						e.printStackTrace();
					}
						}
						
					}
							
				 catch (Exception e) {
	  					e.printStackTrace();
	  				}
					}
			
		}
			
			
			
	}
	
	
	

	try{
		System.out.println("enddate-------------------------------------------------------------------->>");
		if(!(null==enddate))
		{
		enddate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(enddate));
		}
		}catch(Exception e)

		{	
			e.printStackTrace();
				
		}
		try{
		System.out.println("unloaddate-->>"+unloaddate);
		if(!(null==unloaddate))
		{
		unloaddate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(unloaddate));
		}
			
		}catch(Exception e)

		{	
			e.printStackTrace();
				
		}
		try{
		 if(!(null==delayrsn) && delayrsn.equalsIgnoreCase("other"))
		 {
			 delayrsn =udr;
		 }
			
			}catch(Exception e)

			{	
				e.printStackTrace();
					
			}
		 endtime=endhrs+":"+endmin+":00";	
		unloadtime=unloadendhrs+":"+unloadendmin+":00";
	
	
		String sql1="select * from t_startedjourney where TripId='"+tripid+"' ";
		rs1=stmt1.executeQuery(sql1);
		System.out.println("ist querry---------------->" +sql1);

		if(rs1.next())
		{
			vehcode=rs1.getString("Vehid");
			vehreg=rs1.getString("VehRegNo");
			stplace=rs1.getString("StartPlace");
			endplace=rs1.getString("EndPlace");
			rptdatetme=rs1.getString("ReportDateTime");
			stdate=rs1.getString("StartDate");
			sttime=rs1.getString("StartTime");
			driverid=rs1.getString("DriverCode");
			drivername=rs1.getString("DriverName");
			stcode=rs1.getString("StartCode");
			endcode=rs1.getString("EndCode");
			gpname=rs1.getString("GPName");
			ownername=rs1.getString("OwnerName");
			tripcat = rs1.getString("TripCategory");
			weight=rs1.getString("Weight");
			vendor=rs1.getString("Vendor");
			entryby = rs1.getString("EntryBy");
			if(entryby.equals("-") || gpname.equalsIgnoreCase("Castrol"))
			{
				JDtrip = "Yes";
			}
			else
			{
				JDtrip = "No";
			}
		}
		 System.out.println("JDtrip------------------------------------> "+JDtrip);
	
		ResultSet rstoscount=fleetview.getOSforDateRange(stdate+" "+sttime,enddate+" "+endtime,vehcode);
		while(rstoscount.next())
		{
		oscount++;
		osdur = osdur+rstoscount.getDouble(1);
		}
		ResultSet rstaccount=fleetview.getACforDateRange(stdate+" "+sttime,enddate+" "+endtime,vehcode);
		while(rstaccount.next())
		{
		account++;
		}
		ResultSet rstdccount=fleetview.getDCforDateRange(stdate+" "+sttime,enddate+" "+endtime,vehcode);
		while(rstdccount.next())
		{
		dccount++;
		}
		//out.print(oscount+" "+account+" "+dccount);

			gpname=rs1.getString("GPName");
	
			System.out.println("enddate11111111111111111111111111111-------------------------------------------------------------------->>");

			if(enddate==null)
			{
			}
			else
			{		
				//boolean flag=false;	
				String Stamp="";
			//	int oscount=0, account=0, dccount=0;
				int cdcount=0,ndcount=0, stcount=0,disconn_cnt=0,gap_cnt=0;
				double disconnkm=0,gap_km=0;
				
				String ZONECOLOR_RED = "Red";
				String ZONECOLOR_YELLOW = "Yellow";
				String ZONECOLOR_GREEN = "Green";
				
				int osInRedZoneCount=0,osInYellowZoneCount=0,osInGreenZoneCount=0,osDurationInRedZone=0,osDurationInYellowZone=0,osDurationInGreenZone=0,osGreaterThan65=0,osGreaterThan65dur=0,osCntGreaterThan65=0;
				String sql11="select * from t_veh"+vehcode+" where Thefielddatadatetime>='"+stdate+" "+sttime+"' and Thefielddatadatetime<='"+enddate+" "+endtime+"' and TheFiledTextFileName='SI' Order by Thefielddatadatetime asc limit 1 ";
				
				
				//sql11="select Distance from t_veh"+vehcode+" where concat(TheFieldDataDate,TheFieldDataTime) >=concat('"+stdate+"', '"+sttime+"') and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) asc";
				 rs11=stmt1.executeQuery(sql11);
				 System.out.println("vehcode querrtasc---------->"  +sql11);
				 if(rs11.next())
				 {
					stkm=rs11.getInt("Distance");	 
				 }
				 else
				 {
					 totkm=0;
				 }
				 if(stkm!=0)
				 {
				  String sql13="select * from t_veh"+vehcode+" where Thefielddatadatetime<='"+enddate+" "+endtime+"' and Thefielddatadatetime>='"+stdate+" "+sttime+"' and TheFiledTextFileName='SI' Order by Thefielddatadatetime desc limit 1 ";
				 //sql13="select Distance from t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+enddate+" "+endtime+"' and TheFiledTextFileName='SI' order by concat(TheFieldDataDate,TheFieldDataTime) asc";
				 rs13=stmt1.executeQuery(sql13);
				 System.out.println("vehcode querrt-desc--------->"  +sql13);

				 if(rs13.next())
				 {
					endkm=rs13.getInt("Distance");	 
				 }
				 }
				 totkm=endkm-stkm;	
				 System.out.println("totalkm------>  " +totkm);
				/* sql14="SELECT * FROM t_veh"+vehcode+" where concat(TheFieldDataDate,' ',TheFieldDataTime) >='"+stdate+" "+sttime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+enddate+" "+endtime+"' and LonginDec>0 and TheFiledTextFileName in ('AC','DC','OS') order by concat(TheFieldDataDate,TheFieldDataTime) desc";
				 rs14=stmt1.executeQuery(sql14);
				 while(rs14.next())
				 {
					 Stamp=rs14.getString("TheFiledTextFileName");
					 
					 if (Stamp.equals("OS"))
					 {
						 //oscount++;
						 osdur=osdur+rs14.getDouble("Distance");
					 }
						else if (Stamp.equals("AC"))
					 {
					 	if (rs14.getInt("Distance")>5)
					 	{
					 		account++;
					 	}
					 }
					 else if (Stamp.equals("DC"))
					 {
							if (rs14.getInt("Distance")<120)
							{
								dccount++;	
							}
					 }	
				 }*/	
				 
				 String sqlOSzone = "SELECT * FROM db_gpsExceptions.t_veh"+vehcode+"_overspeed WHERE concat(FromDate,' ',FromTime)>='"+stdate+" "+sttime+"' AND concat(ToDate,' ',ToTime)<='"+enddate+" "+endtime+"'";
					ResultSet rsOSzone = stmt2.executeQuery(sqlOSzone);
					while(rsOSzone.next())
					{
						String zoneColor = rsOSzone.getString("Zone");
						if(ZONECOLOR_RED.equalsIgnoreCase(zoneColor))
						{
							osInRedZoneCount++; //OS Red Zone Count
							osDurationInRedZone+= rsOSzone.getInt("Duration"); //OS Duration in Red Zone
						}
						if(ZONECOLOR_YELLOW.equalsIgnoreCase(zoneColor))
						{
							osInYellowZoneCount++; //OS Yellow Zone Count
							osDurationInYellowZone+= rsOSzone.getInt("Duration"); //OS Duration in Yellow Zone
						}
						if(ZONECOLOR_GREEN.equalsIgnoreCase(zoneColor))
						{
							osInGreenZoneCount++; //OS Green Zone Count
							osDurationInGreenZone+= rsOSzone.getInt("Duration"); //OS Duration in Green Zone
						}
					}
					
					/****************************************OS having speed >65 (not yet inserted in completed journey table)***************************************************/
					osGreaterThan65=0;osCntGreaterThan65=0;
					String sqlOS = "SELECT sum(Duration)as Duration ,count(*) as count FROM db_gpsExceptions.t_veh"+vehcode+"_overspeed WHERE concat(FromDate,' ',FromTime)>='"+stdate+" "+sttime+"' AND concat(ToDate,' ',ToTime)<='"+enddate+" "+endtime+"' and Speed>65";
					//System.out.println("sqlOS>65"+sqlOS);
					ResultSet rsOS = stmt2.executeQuery(sqlOS);
					if(rsOS.next()){
						osGreaterThan65=rsOS.getInt("Duration");
						osCntGreaterThan65=rsOS.getInt("count");
					}
					
					
					/***************************************************************************************************************/
					
				 
				String sql15="select count(*) as cnt from db_gpsExceptions.t_veh"+vehcode+"_nd where concat(FromDate,' ',FromTime) between '"+stdate+" "+sttime+"' and '"+enddate+" "+endtime+"'";
				System.out.println("ndcnt--------------->"+sql15);

					rs15=stmt2.executeQuery(sql15);
				 if(rs15.next())
				 {
					 ndcount=rs15.getInt("cnt");
				 }
				/* add on 04 March 2016*/
				 /*************************************code for CD**************************************** */
				 String sql151="Select count(*) as cnt from db_gpsExceptions.t_veh"+vehcode+"_cr where concat(fromdate,' ',fromtime)>='"+stdate+" "+sttime+"' and concat(todate,' ',totime)<='"+enddate+" "+endtime+"'";
				

					rs151=stmt2.executeQuery(sql151);
					System.out.println("ndcnt--------------->"+sql151);
				 if(rs151.next())
				 {
					 cdcount=rs151.getInt("cnt");
				 }
				 
				 /*************************************code for stops**************************************** */

                String timean="";
				 Double timean1=0.0;
			 	String sql16="select *,(HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time1 from t_veh"+vehcode+" where TheFiledTextFileName='SP' and concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+stdate+" "+sttime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+ enddate+" "+endtime+"' order by concat(TheFieldDataDate,TheFieldDataTime) asc";
				// System.out.println("querrrrrrrrrrrrrrr-------------------------------------->  " +sql16);

				 rs16= stmt1.executeQuery(sql16);
				 
				 while(rs16.next())
				 {
					 
					 timean=rs16.getString("time1");
					timean1= Double.parseDouble(timean);
					 String sql17="select *,(HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) as time2 from t_veh"+vehcode+" where TheFiledTextFileName='ST' and concat(TheFieldDataDate,' ',TheFieldDataTime)>='"+stdate+" "+sttime+"' and concat(TheFieldDataDate,' ',TheFieldDataTime)<='"+enddate+" "+endtime+"' and TheFieldDataDate='"+rs16.getString("TheFieldDataDate")+"' and (HOUR(TheFieldDataTime)*60+MINUTE(TheFieldDataTime)+SECOND(TheFieldDataTime)/60) > "+timean1+" and abs(LatinDec - "+rs16.getString("LatinDec")+") <=0.5 order by concat(TheFieldDataDate,TheFieldDataTime) asc limit 1";
					// System.out.println("querrrrrrrrrrrrrrr-------------------------------------->  " +sql17);

				 	rs17= stmt3.executeQuery(sql17);
				 //	System.out.println("querrrrrrrrrrrrrrr-------------------------------------->  " +sql17);
				 	if(rs17.next())
				 	{
				 		if(rs17.getDouble("time2")-rs16.getDouble("time1") >=Integer.parseInt(session.getAttribute("stop11").toString()))
				 		{
				 			stcount++;
				 		}
				 	}
				 }	
				 /* ************************************************************************* */
				 
				 /* **********************Calculating Rating********************* */
				 	double rating=0;
				 	if(totkm>0)
				 	{
				 		rating=(account/totkm)*100 + (dccount/totkm)*100 +((osdur/10)/totkm)*100;
				 	}
				 
				 /* ************************************************************************* */
				String sql18="select * from t_completedjourney where VehId='"+vehcode+"' and DriverId='"+driverid+"' and OwnerName='"+ownername+"' and GPName='"+gpname+"' and JDCode='"+tripid+"' ";
				   // System.out.println("Selectsql::>>"+sql18);  
					rs18=stmt4.executeQuery(sql18);
				    System.out.println("Selectsql::>>"+sql18);  

					if(rs18.next())
					{
						String tripid1=rs18.getString("TripId");
						//String vehcode=rs18.getString("VehId");
						 vehcode=rs18.getString("VehId");
						String vehregno=rs18.getString("VehRegNo");
						String startplace=rs18.getString("StartPlace");
						String startdate=rs18.getString("StartDate");
						String starttime=rs18.getString("StartTime");
						//String endplace=rs18.getString("EndPlace");
						 endplace=rs18.getString("EndPlace");
						String enddate1=rs18.getString("EndDate");
						String endtime1=rs18.getString("EndTime");
						//String driverid=rs18.getString("DriverId");
						 driverid=rs18.getString("DriverId");
						//String drivername=rs18.getString("DriverName");
						 drivername=rs18.getString("DriverName");
						//String ownername=rs18.getString("OwnerName");
						 ownername=rs18.getString("OwnerName");
						//String gpname=rs18.getString("GPName");
						gpname=rs18.getString("GPName");
						String jdcode=rs18.getString("JDCode");
						String weight1=rs18.getString("Weight");
						String vendor1=rs18.getString("Vendor");
						String tripcat1 = rs18.getString("TripCategory");
						Unloadingcomment=rs18.getString("Unloadingcomments");
						podnumber=rs18.getString("pod");
						delayrsn =rs18.getString("DelayReason");
						
						String sql2="update t_completedjourney SET JDCode='"+jdcode+"',VehId='"+vehcode+"', VehRegNo='"+vehregno+"',StartPlace='"+startplace+"',StartDate='"+startdate+"',StartTime='"+starttime+"',EndPlace='"+endplace+"',EndDate='"+enddate1+"',EndTime='"+endtime1+"',JourneyStatus='Completed',DriverId='"+driverid+"',DriverName='"+drivername+"',OwnerName='"+ownername+"',GPName='"+gpname+"' where TripId='"+tripid1+"' and VehId='"+vehcode+"' and DriverId='"+driverid+"' and OwnerName='"+ownername+"' and GPName='"+gpname+"' and JDCode='"+jdcode+"',Weight='"+weight1+"',Vendor='"+vendor+"',Unloadingcomments='"+Unloadingcomment.replaceAll("'"," ")+"',pod='"+podnumber.replaceAll("'"," ")+"',DelayComments='"+delayrsn.replaceAll("'"," ")+"',TripCategory='"+tripcat1+"',podfilename='"+InsertDateTime+"_"+itemName+"' where TripId='"+tripid1+"'";
						stmt4.executeUpdate(sql2);
					    System.out.println("executeUpdate::>>"+sql2);  

					}
					else
					{
					  //sql2="insert into t_completedjourney (TripId,JDCode, VehId, VehRegNo, StartPlace, StartDate, StartTime, EndPlace, EndDate, EndTime, JourneyStatus, DriverId, DriverName, OwnerName, GPName) values ('"+tripid+"','"+tripid+"', '"+vehcode+"', '"+vehreg+"', '"+stplace+"', '"+stdate+"', '"+sttime+"', '"+endplace+"', '"+enddate+"', '"+endtime+"', 'Completed', '"+driverid+"', '"+drivername+"', '"+user+"', '"+user+"') ";   
			          // out.print(sql2);
					  // stmt1.executeUpdate(sql2);
					String sqlloading="select concat('',TIMEDIFF('"+stdate+" "+sttime+"','"+rptdatetme+"')) as loadingDateDiff";
					//System.out.println(sqlloading);
					ResultSet rstloading=stmt1.executeQuery(sqlloading);
					if(rstloading.next())
					{
						loadingdelay=rstloading.getString("loadingDateDiff");	
					}
					
					
					String sqlUnloading="select concat('',TIMEDIFF('"+unloaddate+" "+unloadtime+"','"+enddate+" "+endtime+"')) as UnloadingDateDiff";
					//stmt1.executeUpdate(sql3);
					//System.out.println(sqlUnloading);
					ResultSet rstUnloading=stmt1.executeQuery(sqlUnloading);
					if(rstUnloading.next())
					{
						Unloadingdelay=rstUnloading.getString("UnloadingDateDiff");	
					}
					String sql2="insert into t_completedjourney (TripId, VehId, VehRegNo, StartPlace, StartCode, StartDate, StartTime, EndPlace, EndCode, EndDate, EndTime, StartKm, EndKm, KmTravelled, JourneyStatus, DriverId, DriverName, OwnerName, GPName, JDCode, RACount, RDCOunt, OSCOunt,OSDurationInRedZone,OSDurationInYellowZone,OSDurationInGreenZone,CRCount, NDCount, StopDuration, OSDuration, TripRating,Weight,Vendor,UnloadDateTime,LoadingDelay,UnloadingDelay,Unloadingcomments,DelayReason,TripCategory,pod,podfilename,Tripclosingcomment) values ('"+tripid+"', '"+vehcode+"', '"+vehreg+"', '"+stplace+"', '"+stcode+"', '"+stdate+" "+sttime+"', '"+sttime+"', '"+endplace+"', '"+endcode+"', '"+enddate+" "+endtime+"', '"+endtime+"', '"+stkm+"', '"+endkm+"', '"+totkm+"', 'Completed', '"+driverid+"', '"+drivername+"', '"+ownername+"', '"+gpname+"', '"+tripid+"', '"+account+"', '"+dccount+"', '"+oscount+"','"+osDurationInRedZone+"','"+osDurationInYellowZone+"' ,'"+osDurationInGreenZone+"' ,'"+cdcount+"', '"+ndcount+"', '"+stcount+"', '"+osdur+"', '"+rating+"','"+weight+"','"+vendor+"','"+unloaddate+" "+unloadtime+"','"+loadingdelay+"','"+Unloadingdelay+"','"+Unloadingcomment.replaceAll("'"," ")+"','"+delayrsn.replaceAll("'"," ")+"','"+tripcat+"','"+podnumber.replaceAll("'"," ")+"','"+InsertDateTime+"_"+itemName+"','"+Reasonnew+"')";   
					System.out.println("data inserted succesfully...." +sql2);

					/*Query to insert query in db_gps.t_sqlquery table*/
					
					stmt1.executeUpdate(sql2);
					System.out.println("data inserted succesfully...." +sql2);
					
					
					String sql3="update t_startedjourney set JStatus='Completed',EndedBy='"+rfname+" "+rlname+"' where TripID='"+tripid+"' ";
					  /*Query to insert query in db_gps.t_sqlquery table*/
                   System.out.println("update started journey------------------------------------> "+sql3);
					/*****************************/
					  stmt1.executeUpdate(sql3); 
					  System.out.println("update started journey------------------------------------> "+sql3);
					  System.out.println("JDtrip------------------------------------> "+JDtrip);
					  if(JDtrip.equalsIgnoreCase("Yes"))
					  {
						  String subject = "Manual Trip Closure of  "+tripid+"-"+ownername,toid = "k_manoj@transworld-compressor.com",tocc = "fleetviewReports@mobile-eye.in",body = "",mailname = "Manual Trip Closure";
						  
						  sql3 = "select * from db_gps.t_mailid where username = 'Manual Trip Closure' ";
						  ResultSet rsmailid = stmt1.executeQuery(sql3);
						  if(rsmailid.next())
						  {
							  toid = rsmailid.getString("toid");
							  tocc = rsmailid.getString("Tocc");
						  }
						  
						  body = "<html><head><style type=text/css>table.mytable{font:13px arial,sans-serif;border-collapse: collapse; border: 1px solid #839E99;background: #f1f8ee;}</style> </head><body><table border=^18^  bordercolor=^#E6E6FA^ "+
							" align=^center^ width=^55%^><tr align=^center^><td align=^left^  style=^border: 0px;^  width=^100%^><table  style=^margin-left: 1em;margin-right: 1em;width: 100%;height: 100%;^><tr><td width=^100%^><table width = ^97%^ >"+
							"<tr><td><a href=^http://www.mobile-eye.in^  target=^_blank^><img src=^http://myfleetview.com/DiarySystem/images/mobile.jpg^ style=^height: 80px; width: 100px;^  title=^Mobile-eye^ id=^logo^ alt=^Logo^ /></a></td>"+
							"<td  align = ^right^ ><img src=^http://myfleetview.com/FleetView/newimages/transworld.jpg^  style=^height: 80px; width: 400px;^ /></td></tr></table><font style=^color: #D8D8D8^>____________________________________________________________________________________"+
							"</font><br><div width = ^100%^><font face = ^Arial^ size = ^3^><a href=^http://www.myfleetview.com^>www.myFleetView.com</a><br>Manual Trip Closure<br><br><font size = ^2^ face = ^Arial^><table width = ^90%^ align = ^center^>"+
							"<tr><td width = ^28%^ valign = ^top^><font size = ^2^>Trip ID:</font></td><td valign = ^top^><font size = ^2^>"+tripid+"</font></td></tr>"+
							"<tr><td width = ^28%^ valign = ^top^><font size = ^2^>Vehicle No:</font></td><td valign = ^top^><font size = ^2^>"+vehreg+"</font></td></tr>"+
							"<tr><td width = ^28%^ valign = ^top^><font size = ^2^>Transporter:</font></td><td valign = ^top^><font size = ^2^>"+ownername+"</font></td></tr>"+
							"<tr><td width = ^28%^ valign = ^top^><font size = ^2^>Start DateTime:</font></td><td valign = ^top^><font size = ^2^>"+new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(stdate+" "+sttime))+"</font></td></tr>"+
							"<tr><td width = ^28%^ valign = ^top^><font size = ^2^>Origin:</font></td><td valign = ^top^><font size = ^2^>"+stplace+"</font></td></tr>"+
							"<tr><td width = ^28%^ valign = ^top^><font size = ^2^>End DateTime:</font></td><td valign = ^top^><font size = ^2^>"+new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(enddate+" "+endtime))+"</font></td></tr>"+
							"<tr><td width = ^28%^ valign = ^top^><font size = ^2^>Destination:</font></td><td valign = ^top^><font size = ^2^>"+endplace+"</font></td></tr>"+
							"<tr><td width = ^28%^ valign = ^top^><font size = ^2^>Ended By:</font></td><td valign = ^top^><font size = ^2^>"+rfname+" "+rlname+"</font></td></tr>"+
							"<tr><td width = ^28%^ valign = ^top^><font size = ^2^>Closed DateTime:</font></td><td valign = ^top^><font size = ^2^>"+new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date())+"</font></td></tr>"+
							"</table></font><br><br><div><font face = ^Arial^ size = ^2^>Transworld Support Team<br>Phone: +91-20-41214444 +91-9762007124 +91-9762007125"+
							"<br>Email: avlsupport@mobile-eye.in<br><br>Thanks and Regards,<br>Transworld Team</div></div></td></tr></table></td></tr></table></body></html>";
						  
						  sql3 ="Insert into db_gps.t_allpendingmailtable (MailName ,Description ,MailBody,subjectline,Toid,Tocc,MailStatus,SenderName ,EntryDateTime)  values ('"+mailname+"', '-', '"+body+"','"+subject+"','"+toid+"','"+tocc+"','Pending','Processing','"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())+"' )  ";
						  System.out.println("sql3  Before ////////////////////////////////////////////////////////////////////&&&&&&&&&&&&&&&&&&&&&&&&&&&&------------------------------------> \n"+sql3);	
						  stmt1.executeUpdate(sql3);
						  System.out.println("sql3 After  ////////////////////////////////////////////////////////////////////&&&&&&&&&&&&&&&&&&&&&&&&&&&&------------------------------------> \n"+sql3);	
					  }
					/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~new code for disconnection count & km~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
					
					
								/***********************verify if the trip id reported in disconnection table is valid or not**********************************/
							
							try{	
							    String finaltrip="";
								String r3="";String r4="";
								//String sqldisconn="Select * from t_disconnectionData where tripid like '%"+tripid+"%' and ignoredstamp='No' and Duration>='0:30'";
								String sqldisconn="Select * from t_disconnectionData where ((OffTimeFrom >= '"+stdate+" "+sttime+"'  and  OffTimeFrom<='"+enddate+" "+endtime+"') or (OffTimeTo >= '"+stdate+" "+sttime+"'  and  OffTimeTo<='"+enddate+" "+endtime+"') or (OffTimeFrom <= '"+stdate+" "+sttime+"' and OffTimeTo >= '"+enddate+" "+endtime+"')  ) and vehiclecode = '"+vehcode+"'  and ignoredstamp='No' and Duration>='0:30'";
								ResultSet rstdisconn=stmt4.executeQuery(sqldisconn);
								while(rstdisconn.next())
								{
									String disconntripid=rstdisconn.getString("Tripid");
									String r1=rstdisconn.getString("OfftimeFrom");
									String r2=rstdisconn.getString("OffTimeTo");
									String sqlGetTripId="SELECT DriverID ,DriverName ,startdate,starttime,enddate,endtime,tripid from  db_gps.t_completedjourney where tripid = '"+tripid+"' ";
								//	System.out.println("completed ----> "+sqlGetTripId);
									ResultSet rsGetTripID=stmt1.executeQuery(sqlGetTripId);
									if(rsGetTripID.next())
									{
										r3=rsGetTripID.getString("startdate");
										r4=rsGetTripID.getString("enddate");
									
									if(r3.length()<12){
										r3=r3+" "+rsGetTripID.getString("starttime");
									}

									if(r4.length()<12){
										r4=r4+" "+rsGetTripID.getString("endtime");
									}
									}
								//	System.out.println("r4 ----> "+r4);
								//	System.out.println("r3 ----> "+r3);
									flag=intersects(
											new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(r3).getTime()
											, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(r4).getTime()
											, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(r1).getTime()
											, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(r2).getTime()
									);

									if(flag==true)
									{
										
									}
									else{
										   if(disconntripid.contains(","))
										   {
											   String trip=disconntripid.replace("'"+tripid+"'","");
											   if(trip.endsWith(","))
											   {
												   			
												   			StringBuilder s = new StringBuilder(trip);
												   			s.replace(trip.lastIndexOf(","), trip.lastIndexOf(",") + 1, "" );
												   			finaltrip = s.toString();
												   			System.out.println("finaltrip---->"+finaltrip);
											   }
											   else if(trip.startsWith(","))
											   {
												 			 finaltrip = trip.substring(1);
												   		//	System.out.println("finaltrip---->"+finaltrip);
											   }
											   else if(trip.contains(",,"))
											   {
												   			finaltrip=trip.replace(",,",",");
												   		//	System.out.println("finalstr---->"+finaltrip);
											   }
										
										String sqlupdt="update t_disconnectionData set Tripid='"+finaltrip+"' where offTimefrom ='"+r1+"' and offTimeTo='"+r2+"' and tripid='"+disconntripid+"' and ignoredstamp='No'";
										stmt1.executeUpdate(sqlupdt);
									}
										 else{
											 String sqlupdt="update t_disconnectionData set Tripid='"+finaltrip+"' where offTimefrom ='"+r1+"' and offTimeTo='"+r2+"' and tripid='"+disconntripid+"' and ignoredstamp='No'";
											 stmt1.executeUpdate(sqlupdt);
										 }
										
									}
								}
								System.out.println("disconnection data count....");

							}catch (Exception e) {
							System.out.println("get tripid exception "+e);
							e.printStackTrace();
							//tripid="-";
						}
							
							
							/*************************************Disconn cnt &km***************************/
							String sqldisconn="";
							sqldisconn="Select count(*) as cntdis, sum(Distance) as distance from db_gps.t_disconnectionData where tripid like '%"+tripid+"%' and Reason='Disconnection' and ignoredstamp='No' and Duration>='0:30' ";
							//System.out.println("sqldisconn ------->"+sqldisconn); 
							ResultSet rstdisconn=stmt1.executeQuery(sqldisconn);
							if(rstdisconn.next())
							{
								disconn_cnt=rstdisconn.getInt("cntdis");
								disconnkm  =rstdisconn.getDouble("distance");
							}
							
							
							
							/*****************************************************************************/
							/**************************************Gap*********************************/
							
							 sqldisconn="Select count(*) as cntgap, sum(Distance) as distance from db_gps.t_disconnectionData where tripid like '%"+tripid+"%' and Reason='Gap' and ignoredstamp='No' ";
							//System.out.println("sqldisconn ------->"+sqldisconn); 
							 ResultSet rstgap=stmt1.executeQuery(sqldisconn);
							 if(rstgap.next())
							 {
								gap_cnt=rstgap.getInt("cntgap");
								gap_km=rstgap.getDouble("distance");
							 }
																
							/**************************************************************************/		
							 
							 String completedupdate="update db_gps.t_completedjourney set DisconnectionCount='"+disconn_cnt+"',DisconnectionKm='"+disconnkm+"',GapCount='"+gap_cnt+"',GapKm='"+gap_km+"'  where tripid='"+tripid+"' ";
								stmt1.executeUpdate(completedupdate);
							/****************************************************************************/
							
					/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
					
					}  
					
					  String sql4="select * from t_warehousedata where WareHouseCode='"+stcode+"' and Owner='"+user+"' ";
					//out.print(sql4);
		      			 rs4=stmt1.executeQuery(sql4);
		        		 if(rs4.next())
		        		 {
				
		        		 }
					 else
		     			{
						 String sql5="select * from t_veh"+vehcode+" where TheFieldDataDate='"+stdate+"' and TheFieldDataTime<='"+sttime+"' and TheFiledTextFileName='SI' order by TheFieldDataTime desc limit 1 ";  
					//	out.print(sql5);
		        		     rs5=stmt1.executeQuery(sql5);
		        		      if(rs5.next())
		        		      { 
		        		          stlat=rs5.getDouble("LatinDec");
		        		          stlong=rs5.getDouble("LonginDec");

		        		          String sql6="insert into t_autogeofenced (WareHouseCode, WareHouse, Owner, Transporter, Latitude, SLatitude, ELatitude, Longitude, SLongitude, ELongitude, WType, Location, StoredDateTime, TripId, User) values ('-', '"+stplace+"', '"+user+"', '"+user+"', '"+stlat+"', '"+stlat+"', '"+stlat+"', '"+stlong+"', '"+stlong+"', '"+stlong+"', 'WH',  GeomFromText('POINT("+stlat+" "+stlong+")'), '"+nwfrmtdte1+"', '"+tripid+"', '"+loginuser+"' )";
						  /*Query to insert query in db_gps.t_sqlquery table*/
		        		         stmt1.executeUpdate(sql6); 
		        		      } 
		        		}

		             
		        		 String sql7="select * from t_warehousedata where WareHouseCode='"+endcode+"' and Owner='"+user+"' ";
		    	
		        		 rs7=stmt1.executeQuery(sql7);
		        		 if(rs7.next())
		        		 {
					//	out.print("in if");
		        		 }
					 else
		        		 {
						 String sql8="select * from t_veh"+vehcode+" where TheFieldDataDate='"+enddate+"' and TheFieldDataTime<='"+endtime+"'  and TheFiledTextFileName='SI' order by TheFieldDataTime desc limit 1 ";  
		        		      rs8=stmt1.executeQuery(sql8);
		        		      if(rs8.next())
		        		      { 
		        		          endlat=rs8.getDouble("LatinDec");
		        		          endlong=rs8.getDouble("LonginDec"); 
				
		        		          String sql9="insert into t_autogeofenced (WareHouseCode, WareHouse, Owner, Transporter, Latitude, SLatitude, ELatitude, Longitude, SLongitude, ELongitude, WType, Location, StoredDateTime, TripId, User) values ('"+endplace+"', '"+endplace+"', '"+user+"', '"+user+"', '"+endlat+"', '"+endlat+"', '"+endlat+"', '"+endlong+"', '"+endlong+"', '"+endlong+"', 'WH', GeomFromText('POINT("+endlat+" "+endlong+")'), '"+nwfrmtdte1+"', '"+tripid+"', '"+loginuser+"' )";
		        		    stmt1.executeUpdate(sql9); 
		        		      }
		        		 }
		        		 System.out.println("enddate1111111111111111111111111111122222222222222222222222222222-------------------------------------------------------------------->>");
		        		  ///////////////////////////NEW CODING FOR RETURN ROUTE////////////////////////////////////
						 try
						 {
						 String sqlchk="select * from db_gps.t_startedjourney where Vehid='"+vehcode+"' and  concat(startdate,' ',starttime)>'"+stdate+" "+sttime+"' and TripCategory='tanker' order by concat(startdate,' ',starttime) and jstatus ='tobeclosed' desc  limit 1";
						 //End Location
						// System.out.println("select from start------------------> "+sqlchk);
						 ResultSet rs71=st1R.executeQuery(sqlchk);
						 System.out.println("select from start------------------> "+sqlchk);
						    if(rs71.next())
						//    if(rs71.getString("JStatus").equalsIgnoreCase("Completed"))				    
						{
								 System.out.println("Inside if----------------------------------------------> ");
								int osInRedZoneCount1=0,osInYellowZoneCount1=0,osInGreenZoneCount1=0,osDurationInRedZone1=0,osDurationInYellowZone1=0,osDurationInGreenZone1=0,osGreaterThan651=0,osGreaterThan65dur1=0,osCntGreaterThan651=0;
								double startdist1 = 0,enddist1 = 0,Distance1 = 0,racount1 = 0,oscount1 = 0,OSDuration1 = 0,AC1=0.0,DC1=0.0,os1=0.0,RDCount1 = 0.0,endlat1=0.0,Rating1=0,endlong1=0.0,distanceissue1=0.0;
								int ndcnt1=0,STcount1=0,cdcnt1=0;
						    	   String lStartDate1="",lStartTime1="",lgpname1="",lstartkm1="",lStartPlace1="",lStartDT="";
						    	  String ZONECOLOR_RED1 = "Red";
						    	  String ZONECOLOR_YELLOW1 = "Yellow";
						    	  String ZONECOLOR_GREEN1 = "Green";
						    	
						    	  
						    	  String sqlchk1="select * from db_gps.t_completedjourney where TripID='"+tripid+"'  limit 1"; // Start Location
								    ResultSet rs711=st2R.executeQuery(sqlchk1);
								    System.out.println("select com journey--->"+sqlchk1);
								    if(rs711.next())
								    {
								    	lStartDate1=rs711.getString("EndDate");
								    	lStartTime1=rs711.getString("EndTime");
								    	lStartDT=lStartDate1+" "+lStartTime1;
								    	 lstartkm1=rs711.getString("EndKm");											    	
								    	 lgpname1=rs711.getString("gpname");
								    	 lStartPlace1=rs711.getString("Startplace");
								    	
								    }	
						    	  
								    System.out.println("**********************************************************************************************************1111111111111111111111111111111111111");
								    ////////////////////////////////////////Insertion of DistributorName in startedjorney/////////////////////////////
									String Endloccode="";
									String distributor="select Endloccode from db_gps.castrolJD where TRIP_NO ='"+tripid+"' ";
									//System.out.println("Endloccode Querry******************************************************     "  +distributor);
									ResultSet rsdist=st2R.executeQuery(distributor);
									//System.out.println("Endloccode Querry111111111111111111111111111111111111111111111111111111111111    "  +distributor);
									if(rsdist.next())
									{
										Endloccode=rsdist.getString("Endloccode");
										//System.out.println("Endloccode    "  +Endloccode);
										
									}
								
								    
						    	  
						    	  String lTripid1=tripid+"-R";
						    	
						    	String lDriverName1=rs71.getString("DriverName");
						    	String lDriverCode1=rs71.getString("DriverCode");
						    	String l1=rs71.getString("EndPlace");
						    	String lStartCode1=rs71.getString("EndCode");
						    	
						    	String lEndDate1=rs71.getString("StartDate");
						    	String lEndTime1=rs71.getString("StartTime");
						    	String lEndDT=lEndDate1+" "+lEndTime1;
						    	String lEndPlace1=rs71.getString("EndPlace");		
						    	String lEndCode1=rs71.getString("EndCode");
						    	
						        String  nsql5="insert into t_startedjourney(TripID,Vehid,VehRegNo,StartPlace,StartCode,EndPlace,EndCode,StartDate,StartTime,DriverCode," +
								"DriverName,OwnerName,GPName,TripCategory,updateddt,JDDate,timetochecktripend,Vendor," +
								"distributername,jstatus,tankerreturntripstatus)values" +
								"('"+lTripid1+"','"+vehcode+"','"+vehreg+"','"+lStartPlace1+"','"+lStartCode1+"','"+lEndPlace1+"','"+lEndCode1+"','"+lStartDate1+"','"+lStartTime1+"','"+lDriverCode1+"'," +
										"'"+lDriverName1+"','"+ownername+"','Castrol','"+tripcat+"','"+today1+"','"+lEndDate1+"','"+today1+"','Castrol India Ltd','"+Endloccode+"','Completed','Return')";
								//System.out.println("nsql5  "+nsql5);
						       st3R.executeUpdate(nsql5);
						      System.out.println("started journey insert-return------------------------->  "+nsql5);
						    	
						      //////////////////////////////////////////////////////////////////////////////////////////////////////
						      

								
								 racount1 = 0;
								String sqld5="Select count(*) as racount from db_gpsExceptions.t_veh" + vehcode +"_ra where concat(thedate,' ',thetime)>='"+lStartDT+"' and concat(thedate,' ',thetime)<='"+lEndDate1+" "+lEndTime1+"'";
								ResultSet rst9=st3R.executeQuery(sqld5);
							      System.out.println("racount-------------------------->  "+sqld5);

								if(rst9.next())
								{
									racount1 = rst9.getInt("racount");
								}
								 RDCount1 = 0;   		      
								String sqld6= "Select count(*) as RDCount  from db_gpsExceptions.t_veh" + vehcode+"_rd where concat(thedate,' ',thetime)>='"+lStartDT+"' and concat(thedate,' ',thetime)<='"+lEndDT+"'";
								ResultSet rst73=st3R.executeQuery(sqld6);
							      System.out.println("RDCount-------------------------->  "+sqld6);

								if(rst73.next())
								{
									RDCount1 = rst73.getInt("RDCount"); 
								}
								 OSDuration1 = 0;
								 oscount1 = 0;

								String sqld7="Select count(*) as oscount  from db_gpsExceptions.t_veh"+vehcode+"_overspeed where concat(fromdate,' ',fromtime)>='"+lStartDT+"' and concat(ToDate,' ',ToTime)<='"+lEndDT+"'";

								ResultSet rst6=st3R.executeQuery(sqld7);
							      System.out.println("oscount-------------------------->  "+sqld7);

								if(rst6.next())
								{
									oscount1 = rst6.getInt("oscount");
								}

								String sqld8= "Select sum(duration) as duration  from db_gpsExceptions.t_veh"+vehcode+ "_overspeed where concat(fromdate,' ',fromtime)>='"+lStartDT+"' and concat(ToDate,' ',ToTime)<='"+lEndDT+"'";
								ResultSet rst7=st3R.executeQuery(sqld8);
							      System.out.println("duration-------------------------->  "+sqld8);

								if(rst7.next())
								{
									OSDuration1 = rst7.getInt("duration"); 													
								}
									
								String sqlOSzone1 = "SELECT * FROM db_gpsExceptions.t_veh"+vehcode+"_overspeed WHERE concat(FromDate,' ',FromTime)>='"+lStartDT+"' AND concat(ToDate,' ',ToTime)<='"+lEndDT+"'";
								ResultSet rsOSzone1 = st3R.executeQuery(sqlOSzone1);
							      System.out.println("osInRedZoneCount-------------------------->  "+sqlOSzone1);

								while(rsOSzone1.next())
								{
									String zoneColor = rsOSzone1.getString("Zone");
									if(ZONECOLOR_RED1.equalsIgnoreCase(zoneColor))
									{
										osInRedZoneCount++; //OS Red Zone Count
										osDurationInRedZone+= rsOSzone1.getInt("Duration"); //OS Duration in Red Zone
									}
									if(ZONECOLOR_YELLOW1.equalsIgnoreCase(zoneColor))
									{
										osInYellowZoneCount++; //OS Yellow Zone Count
										osDurationInYellowZone+= rsOSzone1.getInt("Duration"); //OS Duration in Yellow Zone
									}
									if(ZONECOLOR_GREEN1.equalsIgnoreCase(zoneColor))
									{
										osInGreenZoneCount++; //OS Green Zone Count
										osDurationInGreenZone+= rsOSzone1.getInt("Duration"); //OS Duration in Green Zone
									}
								}
								
								/****************************************OS having speed >65 (not yet inserted in completed journey table)***************************************************/
								osGreaterThan65=0;osCntGreaterThan65=0;
								String sqlOS1 = "SELECT sum(Duration)as Duration ,count(*) as count FROM db_gpsExceptions.t_veh"+vehcode+"_overspeed WHERE concat(FromDate,' ',FromTime)>='"+lStartDT+"' AND concat(ToDate,' ',ToTime)<='"+lEndDT+"' and Speed>65";
							//	System.out.println("sqlOS>65"+sqlOS);
								ResultSet rsOS1 = st3R.executeQuery(sqlOS1);
								System.out.println("sqlOS>65--------------->"+sqlOS1);

								if(rsOS1.next()){
									osGreaterThan65=rsOS1.getInt("Duration");
									osCntGreaterThan65=rsOS1.getInt("count");
								}
																					
								/***************************************************************************************************************/
																			
								if(Distance1 > 0 )
								{
								    AC1 = (racount1 / Distance1) * 100;
									DC1 = (RDCount1 / Distance1) * 100;
									os1 = ((OSDuration1 / 10) / Distance1) * 100;
									Rating1 = AC1 + DC1 + os1;
								
								}
								else
								{
									Rating1=0.0;
								}
								
								ndcnt1=0;
								String sqld9= "Select count(*) as cnt from db_gpsExceptions.t_veh"+vehcode+ "_nd where concat(fromdate,' ',fromtime)>='"+lStartDT+"' and concat(fromdate,' ',fromtime)<='"+lEndDT+"'";
								System.out.println("ndcnt--------------->"+sqld9);

								ResultSet rst8=st3R.executeQuery(sqld9);
								System.out.println("ndcnt--------------->"+sqld9);

								if(rst8.next())
								{
									ndcnt1 = rst8.getInt("cnt"); 														
									int x = 0;

								}
								
								cdcnt1=0;
								String sqld91= "Select count(*) as cnt from db_gpsExceptions.t_veh"+vehcode+ "_nd where concat(fromdate,' ',fromtime)>='"+lStartDT+"' and concat(todate,' ',totime)<='"+lEndDT+"'";
								System.out.println("ndcnt--------------->"+sqld91);

								ResultSet rst81=st3R.executeQuery(sqld91);
								System.out.println("ndcnt--------------->"+sqld91);

								if(rst81.next())
								{
									cdcnt1 = rst81.getInt("cnt"); 														
									int x = 0;

								}
								/**************************************** **************************************************/
																																								
								 /*******************************Calculation of Jrm Km ******************************************************/
								
								 
						      
						      /////////////////////////////////////////////////////////////////////////////////////////////////////
						      
						      
						      
						      
						    
						      

					int ins=0;
					String sqlavailablecompleted="select * from t_completedjourney where TripID='" +lTripid1+ "'";
					ResultSet rstavailcompleted=st3R.executeQuery(sqlavailablecompleted);
					if(rstavailcompleted.next())
					{

						String completedupdate="delete  from   t_completedjourney where tripid='"+lTripid1+"' ";
						System.out.println("completedupdate"+completedupdate);
						
							st4R.executeUpdate(completedupdate);
							System.out.println("completedupdatedelrtr---->"+completedupdate);

					//	System.out.println("reason>>>>>>>"+reason);
						String sqli= "Insert into t_completedjourney (TripID,Vehid,VehRegNo,StartPlace,StartCode,StartDate,StartTime,"+
						"EndPlace,EndCode,EndDate,EndTime,StartKm,KmTravelled,RACount,RDCount,OSCount,OSDuration,"+
						"OSDurationInRedZone,OSDurationInYellowZone,OSDurationInGreenZone,CRCount,NDCount,JourneyStatus,DriverID,"+
						"DriverName,OwnerName,GPName,TripRating,TripCategory,Stoppagecount,tankerreturntripstatus,Tripclosingcomment) values('" + lTripid1+ "',"+
						"'" +vehcode + "','" + vehreg+ "','" + lStartPlace1 + "','" + 
						lStartCode1 + "','" +lStartDate1 +"','" + lStartTime1 + 
						"','"+lEndPlace1 + "','" + lEndCode1 + "','" +lEndDT+"','" + 
						lEndTime1 + "','" + lstartkm1 + "','"+ Distance1 + "','" + racount1 + "','" + RDCount1 + "','" + oscount1 + "','"+ 
						OSDuration1 + "','"+ osDurationInRedZone1 + "','"+ osDurationInYellowZone1 + "','"+ osDurationInGreenZone1 + "','"+cdcnt1+"','" + 
						ndcnt1 + "','Completed','" + lDriverCode1 + "','" + lDriverName1 + "','" + 
						ownername + "','"+lgpname1+"','" + Rating1 +"','tanker','"+STcount1+"','Return','"+Reasonnew+"')";
						//System.out.println("sqli>>>>>"+sqli);
						
								ins=st4R.executeUpdate(sqli);
						System.out.println("inserted t_completedjourney ret5urn>>>>>>>>>>>>>>>>>>>>>>>> "+ins);								
					}
					else
					{

						//	System.out.println("reason>>>>>>>"+reason);
							try
							{
								
								String sqli= "Insert into t_completedjourney (TripID,Vehid,VehRegNo,StartPlace,StartCode,StartDate,StartTime,"+
								"EndPlace,EndCode,EndDate,EndTime,StartKm,KmTravelled,RACount,RDCount,OSCount,OSDuration,"+
								"OSDurationInRedZone,OSDurationInYellowZone,OSDurationInGreenZone,CRCount,NDCount,JourneyStatus,DriverID,"+
								"DriverName,OwnerName,GPName,TripRating,TripCategory,Stoppagecount,tankerreturntripstatus,Tripclosingcomment) values('" + lTripid1+ "',"+
								"'" +vehcode + "','" + vehreg+ "','" + lStartPlace1 + "','" + 
								lStartCode1 + "','" +lStartDate1 +"','" + lStartTime1 + 
								"','"+lEndPlace1 + "','" + lEndCode1 + "','" +lEndDT+"','" + 
								lEndTime1 + "','" + lstartkm1 + "','"+ Distance1 + "','" + racount1 + "','" + RDCount1 + "','" + oscount1 + "','"+ 
								OSDuration1 + "','"+ osDurationInRedZone1 + "','"+ osDurationInYellowZone1 + "','"+ osDurationInGreenZone1 + "','"+cdcnt1+"','" + 
								ndcnt1 + "','Completed','" + lDriverCode1 + "','" + lDriverName1 + "','" + 
								ownername + "','"+lgpname1+"','" + Rating1 +"','tanker','"+STcount1+"','Return','"+Reasonnew+"')";
							
								ins=st4R.executeUpdate(sqli);
							
							System.out.println("inserted into completed--->>>>>"+sqli);
							}
							catch(Exception e)
							{
								System.out.println(e);
							}
						
					}
						    
					try
					  {								
			     	String sqlupdate=null;
			        sqlupdate="update db_gps.t_completedjourney set tankerreturntripstatus='Yes' where tripid='"+rs71.getString("TripID")+"'";
				 //   System.out.println("castrolroutesssssssssssssssssssssssssssssssssssssssssss "  +sqlupdate);
				    st4R.executeUpdate(sqlupdate);
				     System.out.println("return update completed journey------------> "  +sqlupdate);
					  
				     String distupdate1="Update db_gps.t_startedjourney set tankerreturntripstatus= 'Yes' where TripID='"+rs71.getString("TripID")+"'";
						// System.out.println("distance updatequerry"   +distupdate);
						  st4R.executeUpdate(distupdate1);
					  System.out.println("distance updatequerry1"   +distupdate1);
					  
					  
					  }
					  catch(Exception e)
					  {
						  System.out.println("Exception in castrol routes update   "   +e);
					  }
					  
						      
						      
						    }
						    
						    
						 }
						 catch(Exception e)
						 {
							 System.out.println("exception in new coding--->" +e);
						 }
						    
						  
						  
						  
						  
						  
						  
						  ///////////////////////////////END CODING FOR RETURN ROUTE/////////////////////////////////////////////////////////
						  	 
		        		 
		        		 
		        		 
		        		 
		        		 
		%>   
				
				
<!--					<table border="0" width="100%" class="stats">-->
<!--					<tr>-->
<!--						<td align="center"> <font> <B>Successfully Done </B> </font> </td>-->
<!--					</tr>-->
<!--					<tr>-->
					<%
				//	System.out.println("pageflag-->>"+pageflag);
				//	if(pageflag.equals("currentposition"))
				//	{
					
					%>
<!--						<td align="center"> <font> <B> Note: </B> Please refresh 'Current Position' page to reflect the changes. </font> </td>-->
					<%
					//}else{ %>
<!--							<td align="center"> <font> <B> Note: </B> Please refresh 'My Trips' page to reflect the changes. </font> </td>-->
				<%//} %>
<!--					</tr>	-->
<!--					</table>-->

		<%
		String sql10="select * from t_onlinedata where VehicleCode='"+vehcode+"' ";
		rs10=stmt1.executeQuery(sql10);
		if(rs10.next())
		{
			location=rs10.getString("Location");
			System.out.println("------------->loc " +location);
			latitu=rs10.getString("LatitudePosition");
			longi=rs10.getString("LongitudePosition");
		}
		if((sttime==null) || (sttime.equals("")))
		{
			sttime="00:00:00";	
		}
		response.sendRedirect("endtrip.jsp?Parameter4=yes&pageflag="+page+"&locat11="+location);

		//close of outer else
		}
	
	
	
			
			
			
	
}catch(Exception e)
{
	e.printStackTrace();
}
	
	
	
	
	
finally
{
	conn.close();
	
}
%>
<!-- <table border="0">-->
<!--	<tr align="center"><td><font color="BROWN" size="5">< %out.print("INSERTED SUCCESSFULLY");%></font></td></tr>-->
<!--	<td><a href="castrolroutes.jsp">Back To FIRST PAGE</a></td>	-->
<!--	</table>-->


</body>
</html>
</jsp:useBean>