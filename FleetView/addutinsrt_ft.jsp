<!-- < % @page import="com.einnovates.controllers.SendMsgParameter"%> -->
<%@page import="java.security.acl.Owner"%><%@ page import="java.util.*" language="java" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="javax.swing.*" import="java.net.*" import="java.io.*" errorPage="" %>
<%@ include file="Connections/conn.jsp" %>
<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*" %>

<%!
Connection con2;
int vehcode=0, nwunitid=0;
String unidchk="", send=""; 
%>
<%
try {
/********************************************Create Connection and statement********************************************************************/

System.out.println("=====1111=========");
	String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
	String MM_dbConn_USERNAME="fleetview";
	String MM_dbConn_PASSWORD="1@flv";
	String MM_dbConn_STRING="jdbc:mysql://localhost/db_gps";
	String MM_dbConn_STRING1="jdbc:mysql://localhost/db_CustomerComplaints";
	String MM_dbConn_STRING3="jdbc:mysql://localhost/db_CustomerComplaints";
	String SiteRoot="http://localhost:8080/AVL/";
	


	System.out.println("=====2222222=========");



Class.forName(MM_dbConn_DRIVER);

System.out.println("=====333333333=========");
con2 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt2=con2.createStatement(), stmt3=con2.createStatement(),stmtinsert=con2.createStatement();
Statement stmt4=con2.createStatement(), stmt5=con2.createStatement(),stmt6=con2.createStatement();
Statement stmt7=con2.createStatement(), stmt8=con2.createStatement(),stmt9=con2.createStatement();
Statement stmt10=con2.createStatement(), stmt11=con2.createStatement(),stmt12=con2.createStatement();
Statement stadmin=con2.createStatement();
Statement strepre=con2.createStatement();
Statement stpt=con2.createStatement();
Statement stgp=con2.createStatement();


System.out.println("=====444444444=========");

/***********************************Variable declaration***************************************************************************************/
String sql1="", sql2="", sql3="", sql4="", sql5="", sql6="", sql7="", sql8="", sql9="", sql10="", sql11="", sql12="",sqlgp="";
String sql13="", sql14="", sql15="", sql16="", sql17="", sql18="", sql19="", sql20="";
ResultSet rs3=null, rs7=null, rs9=null, rs11=null, rs12=null, rs15=null, rs16=null, rs19=null;
String ownname="", custname="", vehreg="", unid="0", instdate="", instat="", typeunit="", email="", instby="", tme="";
String tmetoinsrt="", newtme="", othloc="", locinsrt="", entby="", instime="", hour="", minutes="", mobno="", simno="";
String custnme="",vehmodel="",vehdesc="", vehnumb="",vehtype="", drivname="", drivcode="", drivmob="", voice1="", voice2="";
String newunitrunon="",osdur="",RA="0",RD="0",OS="0",ST="0",TX="0";
String finalRA=RA,finalRD=RD,finalOS=OS,finalST=ST,finalTX=TX;

String vehtypnw="";

System.out.println("=====555555=========");


int i1=0, i2=0, i3=0, i4=0, i5=0, i6=0,vehiclecode=0, nextvehcode=0,rid=0;;
String InstalledDate="",CodeVersion="";
/******************************************************************************************************************************************/
java.util.Date d=new java.util.Date();
String dte= "" + (d.getYear()+1900) + "-" + (1+d.getMonth()) + "-" + d.getDate();
java.util.Date datefrmdb=new SimpleDateFormat("yyyy-MM-dd").parse(dte);
Format formatter=new SimpleDateFormat("yyyy-MM-dd");
Format formatter1=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
Format formatter2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String nwfrmtdte=formatter.format(datefrmdb);

/* *********** get all the fileds from the form ************* */
System.out.println("=====666666=========");

//entby=session.getValue("username").toString();
String sessionEmail=""; 

java.util.Date dte1 = new java.util.Date();
Format formatter11 = new SimpleDateFormat("yyyy-MM-dd");
String today = formatter11.format(dte1);

entby =(String)session.getAttribute("mainuser");

 sessionEmail=session.getValue("email").toString();


 System.out.println("=====*****!!!========="+entby);
 System.out.println("=====******========"+sessionEmail);
 
 
sessionEmail=session.getValue("email").toString();
ownname=request.getParameter("owner");

System.out.println("=====777777777=========");


if(ownname==null)
{
	ownname=request.getParameter("hiddentransp");
}


vehtypnw=request.getParameter("vehtypenew");

System.out.println("vehtypnw>%%%%%%%%%%%%%%"+vehtypnw);



System.out.println("=====88888=========");
custname=request.getParameter("cust");
osdur=request.getParameter("osdur");
vehreg=request.getParameter("vehreg");
unid=request.getParameter("uid");
instdate=request.getParameter("calender");
instat=request.getParameter("instat");
typeunit=request.getParameter("typeunit");
instby=request.getParameter("instby");
tme=request.getParameter("tme");
newtme=request.getParameter("newtme");
othloc=request.getParameter("othinst");
hour=request.getParameter("hour");
minutes=request.getParameter("minutes");
simno=request.getParameter("simno");
mobno=request.getParameter("mobno");
vehmodel=request.getParameter("vehmodel");
vehtype=request.getParameter("vehtype");
vehdesc=request.getParameter("vehdesc");
drivname=request.getParameter("drivername");
drivcode=request.getParameter("drivercode");
drivmob=request.getParameter("drivermob");
newunitrunon=request.getParameter("unitrunon");
String soldout=request.getParameter("soldout");
String mailreuiredTo=request.getParameter("to");
String mailreuiredCC=request.getParameter("cc");
String whyoption=request.getParameter("whyoption");
RA=request.getParameter("RA");
RD=request.getParameter("RD");
OS=request.getParameter("OS");
ST=request.getParameter("ST");
TX=request.getParameter("TX");


//String vehcat=request.getParameter("vehtypenew");


System.out.println("=====9999999=====mailreuiredTo===="+mailreuiredTo);
System.out.println("=====9999999=====mailreuiredCC===="+mailreuiredCC);
//System.out.println("=====9999999=====vehcat$$$$$$$$$$$$$$$$$$$$$$===="+vehcat);
System.out.println("=====9999999=====OS===="+OS);
System.out.println("=====9999999=====ST===="+ST);
System.out.println("=====9999999=====TX===="+TX);




String getRA=request.getParameter("getRA");
if("".equalsIgnoreCase(getRA)||"null".equalsIgnoreCase(getRA)){
	finalRA=RA;	
}else{
	finalRA=getRA;	
}


System.out.println("=====9999999=-----========");
String getRD=request.getParameter("getRD");
if("".equalsIgnoreCase(getRD)||"null".equalsIgnoreCase(getRD)){
	finalRD=RD;
}else{
	finalRD=getRD;	
}
String getOS=request.getParameter("getOS");
if("".equalsIgnoreCase(getOS)||"null".equalsIgnoreCase(getOS)){
	finalOS=OS;
}else{
	finalOS=getOS;	
}

System.out.println("=====9999999=-----111========");

String getST=request.getParameter("getST");
if("".equalsIgnoreCase(getST)||"null".equalsIgnoreCase(getST)){
	finalST=ST;
}else{
	finalST=getST;	
}

System.out.println("=====9999999=-----2222========");
String getTX=request.getParameter("getTX");
if("".equalsIgnoreCase(getTX)||"null".equalsIgnoreCase(getTX)){
	finalTX=TX;
}else{
	finalTX=getTX;	
}

System.out.println("=====9999999=-----3333========");

System.out.println("=====9999999=-----#####========");

//whyoption=whyoption.replace("'","\'");

System.out.println("=====9999999=-----#####11111========");

if(mailreuiredTo==null||mailreuiredTo.equalsIgnoreCase("")){
}else{
if(mailreuiredTo.endsWith(",")){
	int a=mailreuiredTo.length()-1;
	mailreuiredTo=mailreuiredTo.substring(0,a);
}
}
if(mailreuiredCC==null||mailreuiredCC.equalsIgnoreCase("")){
}else{
if(mailreuiredCC.endsWith(",")){
	int a=mailreuiredCC.length()-1;
	mailreuiredCC=mailreuiredCC.substring(0,a);
}
}
/* **************************************************** */
instime=hour+":"+minutes+":00";


System.out.println("=====9999999=-----4444========");
int unidint=0;
System.out.println("=====9999999=-----4444====unid===="+unid);

if(unid!=null)
{
unidint =Integer.parseInt(unid);

}
System.out.println("=====9999999=-----^^^^^===typeunit=unid===="+typeunit);






System.out.println("=====10=========");


/* *********** Checking if the Vehicle Reg No is already configured ************* */


/*
sql16="select * from db_gps.t_vehicledetails where unitid='"+unid+"' ";
rs16=stmt2.executeQuery(sql16);
System.out.println("sql16>%%%%%%%%%%%%%%"+sql16);

if(rs16.next())
{
   String ownnam=rs16.getString("OwnerName");
   String emailadd=rs16.getString("TheFieldFromEmailAddress");
   String unitid="";
   if(rs16.getString("Status").equals("Removed") || rs16.getString("Status").equals("Deleted"))	
   {
	unitid="0";
   }	
   else 
   {
      unitid=unid;
   }
   response.sendRedirect("addunit_ft.jsp?dupveh="+vehreg+"&unidinveh="+unitid+"&ownernam="+ownnam);
   return;
}

System.out.println("=====11=========");
*/

/* ************************************************************************************ */
/*
email="me"+unidint+"@mobile-eye.in";
if(tme==null)
{
   tmetoinsrt=newtme;
}
else
{
   tmetoinsrt="5.30000019073486";
}
if(instat.equals("Other")){
	locinsrt=othloc;
}else{
	locinsrt=instat;
}

*/
/****************************Query to find out max(VehicleCode)***************************************************************/


//tmetoinsrt=0.00;
System.out.println("=====12=========");

sql11="select max(VehicleCode) from db_gps.t_vehicledetails" ;
rs11=stmt2.executeQuery(sql11);
System.out.println("sql11>%%%%%%%%%%%%%%"+sql11);


while(rs11.next())
{
  vehiclecode=rs11.getInt("max(VehicleCode)");
}
nextvehcode=vehiclecode+1;
/* ******** Checking if Type of COnfi is Temp flow. If yes, then entry will go in t_tempsensorcust************ */

/*
if(typeunit.equals("TEMPSENSOR"))
{
	sql19="select * from t_tempsensorcust where Transporter='"+ownname+"' ";
	rs19=stmt2.executeQuery(sql19);
	System.out.println("sql19>%%%%%%%%%%%%%%"+sql19);
	if(rs19.next())
	{
	}
	else
	{
		sql20="insert into t_tempsensorcust (Transporter) values ('"+ownname+"')";
		String abcd=sql20.replace("'","#");	
		abcd=abcd.replace(",","$");								
		stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd+"')");
 		stmt3.executeUpdate(sql20);
 		System.out.println("sql20>%%%%%%%%%%%%%%"+sql20);
 		
	}
}

*/
String vhregno="",duplctentry="";
String vhrg="select GPName from   db_gps.t_group  where VehRegno  ='"+ownname+"' ";

System.out.println(">>>2222  vhregno=Before query=>"+vhrg);
ResultSet vh=stmt10.executeQuery(vhrg);
System.out.println(">>>2222  vhregno=query=>"+vhrg);
if(vh.next() )
{
	vhregno=vh.getString("GPName");
	duplctentry="yes";
	
	
	//response.sendRedirect("addunit_ft.jsp?duplicate="+duplctentry);
	
}



unid="-";


sqlgp="insert into db_gps.t_group (GPName,VehRegno,transporter,VehCode,SepReport,Active) values ('"+vhregno+"', '"+ownname+"','"+vehreg+"','"+nextvehcode+"', 'Yes', 'yes') ";
System.out.println("sql2>>insert sqlgp>>>>"+sqlgp);
//stgp.executeUpdate(sqlgp);
System.out.println("sql2>>insert sqlgp>>>>"+sqlgp);

/* ******** If all the conditions meet, it gets inserted in DB on both the servers************ */
 
	sql2="insert into db_gps.t_vehicledetails "+ 
			"(VehicleCode, VehicleRegNumber, OwnerName,UnitID, InstalledDate,"+
			" InstalledPlace, InstalledBy, Description,VehModel,VehType1,VehDesc,SoldOut,LastReplacementDate,ST,TX,RA,RD,OS,vehtype)"+
			" values ('"+nextvehcode+"', '"+vehreg+"','"+ownname+"','"+unid+"', '"+today+"', '"+locinsrt+"',"+
			" '"+instby+"', '"+typeunit+"','"+vehmodel+"','"+vehtype+"','"+vehdesc+"','"+soldout+"',"+
			"'"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())+"','"+finalST+"','"+finalTX+"','"+finalRA+"','"+finalRD+"','"+finalOS+"','"+vehtypnw+"')";
System.out.println("sql2>>insert query>>>BEFORE>"+sql2);	
stmt2.executeUpdate(sql2);
	
	System.out.println("sql2>>insert query>>>>"+sql2);
	
	
		String abc=sql2.replace("'","#");	
		abc=abc.replace(",","$");								
		stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abc+"')");
	String sql="select DATE_ADD('"+today+"',INTERVAL 1 YEAR) as InstalledDate1 ";
	 ResultSet rs1=stmt2.executeQuery(sql);
	 if(rs1.next()){
		  InstalledDate = rs1.getString("InstalledDate1");
	 }
	/***********entry to change warranty of vehicle***************************************************************************************/
	 sql2="insert into db_gps.t_amchistory (Transporter, VehCode, VehNo,OldDate,NewDate,EntBy,WarrantyTill)"+
	 		" values ('"+ownname+"', '"+nextvehcode+"','"+vehreg+"','"+today+"','"+today+"','"+entby+"','"+InstalledDate+"')";
	stmt2.executeUpdate(sql2);
	
	System.out.println("sql2>%%%%%%%%%insert%%%%%"+sql2);
			String abcd1=sql2.replace("'","#");	
			abcd1=abcd1.replace(",","$");								
			stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd1+"')");
	/*****************************entry for new installation to maintain history***********************************************************************/
	
	
	
	sql9="select max(RID) from db_gps.t_unitreplacement";
	rs9=stmt2.executeQuery(sql9);
	
	System.out.println("sql9>%%%%%%%%%%%%%%"+sql9);
	
	while(rs9.next())
	{
  		rid=rs9.getInt(1);
	}
	rid=rid+1;
	
	
	
	
	sql5="insert into db_gps.t_unitreplacement (VehCode, VehRegNo, OwnerName,InstDate, InstType, EntBy,DriverName, DriverCode, DriverMobNo,EntDate) values ('"+nextvehcode+"', '"+vehreg+"', '"+ownname+"','"+today+"','New', '"+entby+"','"+drivname+"', '"+drivcode+"', '"+drivmob+"', '"+nwfrmtdte+"')" ;
		String abcd4=sql5.replace("'","#");	
		abcd4=abcd4.replace(",","$");								
		stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd4+"')");
	
		System.out.println("sql5>%%%%%%%%%%%BEFORE%%%"+sql5);
		stmt2.executeUpdate(sql5);
	
	System.out.println("sql5>%%%%%%%%%%%%%%"+sql5);
		
	
	
	/**********************************query to find out codeversion of respective unitid******************************************************************/
	/*
	String sqlCode="select CodeVersion from db_gps.t_ftplastdump where UnitID='"+unid+"'";
	ResultSet rsCode=stmt2.executeQuery(sqlCode);
	
	System.out.println("sqlCode>%%%%%%%%%%%%%%"+sqlCode);
	
	if(rsCode.next()){
		CodeVersion=rsCode.getString("CodeVersion");
		System.out.println(CodeVersion+"<--------code ver");
	}
	
	*/
	/*********if vehicle is added in group ***********/

	System.out.println("sql2>$$$$$$$"+custname);
	
	
	///entry into t_group is avoided as it is not included the form 

	
	/*
	if((!custname.equals("None")))
{
   
		
		
	
		System.out.println("Inside>$$$$$$$");
		sql10="insert into db_gps.t_group (GPName, VehRegNo, transporter, VehCode, Sepreport) values ('"+custname+"', '"+ownname+"', '"+vehreg+"', '"+nextvehcode+"', 'Yes')";
		String abcd5=sql10.replace("'","#");	
		abcd5=abcd5.replace(",","$");								
		stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd5+"')");
   stmt2.executeUpdate(sql10);
   
   System.out.println("sql10>%%%%%%%%%%%%%%"+sql10);

   */
   
   /******if transporter is castrol then email sent to respective person****/
 
   /*
   if(custname.equalsIgnoreCase("Castrol")||custname.contains("Castrol")){
	try{
        Properties props = new Properties();
        String host="smtp.transworld-compressor.com";
        String protocol="smtp";
        String user="tripend@mobile-eye.in"; 
        String pass="transworld";
        props.put("mail.smtp.starttls.enable","true");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.user", "user");
        props.put("mail.smtp.password", "pass");  
        props.put("mail.store.protocol", protocol);
        props.put("mail.smtps.host", host);
        java.security.Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
        Session session1 = Session.getDefaultInstance(props, null);
         // Construct the message
         Message msg = new MimeMessage(session1);
         msg.setSubject("New Vehicle added in castrol and Transporter is "+ownname);
         msg.setSentDate(new java.util.Date());
        // Address add1=new InternetAddress(email,email2);
      			  //  mail id-------------
      			  String MailID="";
         String sqladmin="select * from db_CustomerComplaints.t_admin where Name='"+user+"'";
			ResultSet rsadmin=stadmin.executeQuery(sqladmin);
			if(rsadmin.next()){
				MailID=rsadmin.getString("Email");
			}
      	      Address recipientAddrs[] = new InternetAddress[1];
      		  recipientAddrs[0] = new InternetAddress("s_shinde@transworld-compressor.com");
		      Address recipientAddrs1[] = new InternetAddress[2];
             //recipientAddrs1[0] = new InternetAddress("a_laddha@mydiary.com");
             recipientAddrs1[0] = new InternetAddress("a_thakur@transworld-compressor.com");
             
             recipientAddrs1[1] = new InternetAddress(MailID);
         msg.addRecipients(Message.RecipientType.TO,recipientAddrs);
      //  msg.addRecipients(Message.RecipientType.CC,recipientAddrs1);
         Address fromAddress=new InternetAddress("noreply@transworld-compressor.com","Transworld"); // in second "", it is short name
         msg.setFrom(fromAddress);
   String body="Sir, <br>New vehicle is added in "+custname+" group.<br>"+
   "<html><body><<table align=center  cellpadding=0 cellspacing=0 width=100% border=1><tr BGCOLOR=#99CCFF>"+
   "<td>Vehicle Reg No:</td><td>UnitID</td><td>Transporter"+
   "</td><td>Added By</td></tr><tr><td>"+vehreg+"</td><td>"+unid+"</td><td>"+ownname+"</td><td>"+entby+"</td></tr><br></table></body></html>";
         msg.setContent(body,"text/html; charset=ISO-8859-1"); 
         Transport t = session1.getTransport("smtps");
         msg.saveChanges(); // don't forget this
         try
         {
              t.connect(host, user, pass);
              t.sendMessage(msg, msg.getAllRecipients());
         }
         catch(Exception e)
         {e.printStackTrace();} 
         finally 
         {
             t.close();
         } 
    		try{
    			 Transport.send(msg);
    		}catch(Exception e){
    			
    		}
}catch(Exception e){
e.printStackTrace();
}
}
}
	
	
	
	*/
	
	
/*********mail alert for new installation in vehicle***************/
	try{
		try{
	       
			
			 String subjct="New Vehicle added in transporter "+ownname,Description="",MailName="",toid="",tocc="",SenderName=""; 
			
				
			 DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		        Calendar cal = Calendar.getInstance();
		        String DateTime = dateFormat.format(cal.getTime());
		        System.out.println(DateTime);
			
			
			
	        // Address add1=new InternetAddress(email,email2);
	   //     	System.out.println("stp1"+chkdcntr1);
	      			  //  mail id-------------
	         String sqlrepre="select * from db_CustomerComplaints.t_asgndtranstoreps where Transporter='"+ownname+"'";
	      		String RepresentativeMailID="";
	      		ResultSet rsrepre=strepre.executeQuery(sqlrepre);
	      		
	      		System.out.println("sqlrepre>%%%%%%%%%%%%%%"+sqlrepre);
				if(rsrepre.next()){
					String representative=rsrepre.getString("Representative");
					String sqladmin="select * from db_CustomerComplaints.t_admin where Name='"+representative+"'";
					ResultSet rsadmin=stadmin.executeQuery(sqladmin);
					System.out.println("sqladmin>%%%%%%%%%%%%%%"+sqladmin);
					if(rsadmin.next()){
						RepresentativeMailID=rsadmin.getString("Email");
					}
				}
	      		System.out.println("RepresentativeMailID----->"+RepresentativeMailID);
	      		
	      		
	      		
	      	       toid=mailreuiredTo+","+RepresentativeMailID;
	      		    
	      		
	      		
	      		
	      		
	      		
	      		
	      		System.out.println("222222");
	      		
	             
	      		System.out.println("333333333");
	      		String Username ="";
	             int pendingcount=0;
	        
	         
	       // msg.addRecipients(Message.RecipientType.CC,recipientAddrs1);
	        
	      	String sqlsecurity="select * from db_gps.t_security where Typevalue='"+ownname+"'";
	      	ResultSet rssecurity=strepre.executeQuery(sqlsecurity);
	      	
	        System.out.println("sqlsecurity>>>"+sqlsecurity);
	      	if(rssecurity.next()){
	      		Username=rssecurity.getString("Username");
	      		System.out.println("Username------------->"+Username);
	      		String sqlpending="SELECT a.UnitLimit - b.count as pendingcount, a.UnitLimit, b.count, b.OwnerName "+
	      		"FROM db_gps.t_transporter a	"+
	      		"	INNER JOIN (	"+
	      		"	SELECT count( * ) AS count, OwnerName	"+
	      		"	FROM db_gps.t_vehicledetails"+
	      		"	WHERE STATUS <> 'Deleted'"+
	      		"	AND OwnerName = '"+ownname+"' "+
	      		"	)b ON ( a.TypeValue = b.OwnerName )";
	      		ResultSet rspending=stadmin.executeQuery(sqlpending);
	      		System.out.println("sqlpending==========>"+sqlpending);
	      		
	      		
	      		if(rspending.next()){
	      			pendingcount=rspending.getInt("pendingcount");
	      			System.out.println(pendingcount);
	      			if(pendingcount<0){
	      				pendingcount=0;	
	      			}
	      		}
	      		
	      	}else{
	      		Username="FleetView ID Not Created, Please Send your email ID for which User ID to be created to sales@transworld-compressor.com";
	      	}
	  
	      	
	      	   	
	      	
	      	
	      	String body="Dear Sir/Madam, <br>Vehicle has been configured without Mobile-eye , Details are as below:"+
	   "<br><html><body><table align=center  cellpadding=0 cellspacing=0 width=100% border=1><tr BGCOLOR=#99CCFF>"+
	   "<td>Customer Name</td><td>Vehicle No</td><td>Driver Name</td><td>Driver Mobile"+
	   "</td><td>Vehicle Model</td><td>Vehicle Type</td><td>Vehicle Description</td><td>Vehicle Category</td>"+
	   "<br><tr>"+
	   "<tr><td>"+ownname+"</td><td>"+vehreg+"</td><td>"+drivname+"</td>"+
	   "<td>"+drivmob+"</td><td>"+vehmodel+"</td><td>"+vehtype+"</td><td>"+vehdesc+"</td><td>"+vehtypnw+"</td>"+
	   "</tr><tr><td>FleetView UserID:</td><td colspan=10>"+Username+"</td> </tr></table></body></html><br>"+
	    "Pending Installation for Customer:"+pendingcount+"<br>Thanks for Using Mobile-Eye.Thanks for Using Mobile-Eye. <br>For any support please contact us at avlsupport@Mobile-Eye.in OR Call at 020-41214444 & 9762007124/25  <br><br>Thanks<br>Transworld Team";
	   System.out.println(body);
	       
	   
	   
	   try{
	  String q2 = "insert into db_gps.t_allpendingmailtable(MailName,Description,MailBody,subjectline,Toid,Tocc,EntryDateTime,MailStatus,SenderName) values ('TWSupport','New Mail for Vehicle adition without Mobile-eye through Fleetview','"+body+"','"+subjct+"','"+toid+"','"+mailreuiredCC+"','"+DateTime+"','Pending','Transworld')";
       System.out.println("q2>>>> :"+q2);
       stpt.executeUpdate(q2);
       System.out.println("the record has been successfully inserted into table"); 
	    
	   }catch(Exception e1)
	   {
		   
		  e1.printStackTrace();
		  System.out.println("e1>>>>Exception>>>> :"+e1);
		   
	   }
	  
	  
	         
	}catch(Exception e){
	e.printStackTrace();
	}

	

}catch(Exception e){
	e.printStackTrace();
}
/*****if vehicle is added using admin option then mail alert is sent to ajay laddha**/

try{


  
/* ***************Updating on whose name the unit will remain ************* */
 
/* ************************************************************************************ */
}catch(Exception e){
	e.printStackTrace();	
}
String sqlvehicle="";
try{
String sqlforvehcode="CREATE TABLE IF NOT EXISTS t_veh"+nextvehcode+" ("+
" `TheFieldDataDate` date default NULL,"+
" `TheFieldDataTime` time default NULL,"+
" `Latitude` double default '0',"+
" `LatitudeDir` varchar(10) default '-',"+
" `Longitude` double default '0',"+
" `LongitudeDir` varchar(10) default '-',"+
" `DataValid` varchar(10) default '-',"+
" `Speed` double default '0',"+
" `DirectionDegree` double default '0',"+
" `TheFiledTextFileName` varchar(100) default '-',"+
" `TheFieldDataStoredDate` date default NULL,"+
" `TheFieldDataStoredTime` time default NULL,"+
" `TheFieldEmailFrom` varchar(100) default '-',"+
" `TheFieldEmailTo` varchar(100) default '-',"+
" `TheFieldDataID` varchar(10) default '-',"+
" `TheFieldFileDate` date default NULL,"+
" `TheFieldFileTime` time default NULL,"+
" `TheFieldAutoNum` double default NULL,"+
" `TheFieldSubject` varchar(100) default '-',"+
" `LocatorStatus` tinyint(3) unsigned default '0',"+
" `EngineStatus` varchar(100) default '-',"+
" `VoiceStatus` varchar(100) default '-',"+
" `RegistrationNo` varchar(100) default '-',"+
" `FuelLevel` tinyint(3) unsigned default '0',"+
" `Distance` double default '0',"+
" `RouteID` int(11) default '0',"+
" `ZoneID` int(11) default '0',"+
" `ZoneDesc` varchar(20) default '-',"+
" `LatinDec` double default '0',"+
" `LonginDec` double default '0',"+
" `Sen1` varchar(50) default '-',"+
" `Sen2` varchar(50) default '-',"+
" `Sen3` varchar(50) default '-',"+
" `Sen4` varchar(50) default '-',"+
" `CDistance` double default '0',"+
" `Thefielddatadatetime` datetime default NULL,"+
" `RDataMailDateTime` datetime default NULL,"+
" `RDataStoredTime` datetime default NULL,"+
" KEY `DateTime` (`TheFieldDataDate`,`TheFieldDataTime`,`TheFiledTextFileName`),"+
" KEY `stampdate` (`TheFieldDataDateTime`,`TheFiledTextFileName`),"+
" KEY `dttime` (`Thefielddatadatetime`)"+
"  ) ENGINE=MyISAM DEFAULT CHARSET=latin1";
stmt4.executeUpdate(sqlforvehcode);

System.out.println("sqlforvehcode>%%%%%%%%%%%%%%"+sqlforvehcode);

String abcd9=sqlforvehcode.replace("'","#");	
abcd9=abcd9.replace(",","$");								
stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gps','"+abcd9+"')");
System.out.println(sqlforvehcode);
}catch(Exception e){
	
}

try{
String sqlfordistance="CREATE TABLE  IF NOT EXISTS db_avlalldata.t_distancecorrection_"+nextvehcode+" ( "+
"  `rid` int(10) unsigned NOT NULL auto_increment,"+
"  `InsertDateTime` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,"+
"  `vehid` varchar(50) default '0',"+
"  `PrevCorrFactor` double default '0',"+
"  `NewCorrFactor` double default '0',"+
"  `PrevStampDateTime` timestamp NULL default NULL,"+
"  `NewStampDateTime` timestamp NULL default NULL,"+
"  `PreStamp` varchar(50) default '-',"+
"  `NewStamp` varchar(50) default '-',"+
"  `PrevDist` double default '0',"+
"  `NewDist` double default '0',"+
"  `Reason` varchar(100) default '-',"+
"  KEY `NewIndex` (`rid`),"+
 " KEY `vehid` (`vehid`),"+
"  KEY `gg` (`vehid`,`NewStampDateTime`)"+
") ENGINE=MyISAM AUTO_INCREMENT=7543 DEFAULT CHARSET=latin1";
stmt5.executeUpdate(sqlfordistance);

System.out.println("sqlfordistance>%%%%%%%%%%%%%%"+sqlfordistance);
String abcd9=sqlfordistance.replace("'","#");	
abcd9=abcd9.replace(",","$");								
stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_avlalldata','"+abcd9+"')");
}catch(Exception e){
	
}
try{
String sqlfords="CREATE TABLE IF NOT EXISTS db_gpsExceptions.t_veh"+nextvehcode+"_ds ("+
"  `VehCode` int(10) unsigned default '0',"+
"  `TheDate` date default NULL,"+
"  `OSCount` int(3) unsigned default '0',"+
"  `OSDuration` double NOT NULL default '0',"+
"  `RACount` int(3) unsigned default '0',"+
"  `RDCount` int(3) unsigned default '0',"+
"  `CRCount` int(3) unsigned default '0',"+
"  `ND` varchar(10) default 'No',"+
"  `Distance` double default '0',"+
"  `Rating` double NOT NULL default '0',"+
"  `Location` varchar(255) default '-',"+
"  `StopCount` int(3) unsigned default '0',"+
"  `RDuration` varchar(100) default '-',"+
"  `RDinSec` double default '0',"+
"  `NRDDuration` double default '0',"+
"  `DName` varchar(50) default '-',"+
"  `DID` varchar(50) default '-',"+
"  `JCode` varchar(50) default '-',"+
"  `DCode` varchar(50) default '-',"+
"  `Transporter` varchar(100) default NULL,"+
"  `FC` double default '0',"+
"  `FAVG` double default '0',"+
"  `FuelValue` double default '0',"+
"  `Refuel` double default '0',"+
"  `Fueltheft` double default '0',"+
"  `FTCount` int(3) default '0',"+
"  `FACount` double default '0',"+
"  `UpdatedDt` datetime default NULL,"+
"  `RDurationinHrs` double unsigned default '0',"+
"  `DayRDuration` varchar(50) default '-',"+
"  `DayRDurationinHrs` double default '0',"+
"  `NightRDuration` varchar(50) default '-',"+
"  `NightRDurationinHrs` double default '0',"+
"  `StopDuration` varchar(50) default '-',"+
"  `StopDurationinHrs` double default '0',"+
"  `DayStopDuration` varchar(50) default '-',"+
"  `DayStopDurationinHrs` double default '0',"+
"  `NightStopDuration` varchar(50) default '-',"+
"  `NightStopDurationinHrs` double default '0',"+
"  `RAvg` double unsigned default '0',"+
"  `Last7DayRDuration` time default '00:00:00',"+
"  `Last7DayRDurationinHrs` double default '0',"+
"  `UpdateDateTime` timestamp NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,"+
"  `gapkm` double NOT NULL default '0',"+
"  `disconnkm` double NOT NULL default '0',"+
"  `gapdur` double NOT NULL default '0',"+
"  `disconndur` double NOT NULL default '0',"+
"  `Disconnection` varchar(20) NOT NULL default 'No',"+
" `Gap` varchar(20) NOT NULL default 'No',"+
"  `UnitId` varchar(20) NOT NULL default '-',"+
"  `Version` varchar(100) NOT NULL default '-',"+
" `AvgSpeedConsidered` varchar(100) NOT NULL default '-',"+
"  KEY `NewIndex` (`TheDate`)"+
") ENGINE=MyISAM DEFAULT CHARSET=latin1";
stmt6.executeUpdate(sqlfords);

System.out.println("sqlfords>%%%%%%%%%%%%%%"+sqlfords);
String abcd9=sqlfords.replace("'","#");	
abcd9=abcd9.replace(",","$");								
stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gpsExceptions','"+abcd9+"')");
}catch(Exception e){
	
}
try{
String sqlforoverspeed="CREATE TABLE IF NOT EXISTS db_gpsExceptions.t_veh"+nextvehcode+"_overspeed ( "+
"  `VehCode` int(10) unsigned default '0',"+
"  `FromDate` date default NULL,"+
"  `FromTime` time default NULL,"+
"  `ToDate` date default NULL,"+
"  `ToTime` time default NULL,"+
"  `Speed` int(3) unsigned default '0',"+
"  `Duration` int(10) unsigned default '0',"+
"  `JCode` varchar(50) default '-',"+
"  `DCode` varchar(50) default '-',"+
"  `Transporter` varchar(100) default NULL,"+
"  `UpdateDateTime` timestamp NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,"+
"  `Zone` varchar(20) NOT NULL default '-',"+
"  KEY `NewIndex` (`FromDate`,`FromTime`)"+
") ENGINE=MyISAM DEFAULT CHARSET=latin1";
stmt7.executeUpdate(sqlforoverspeed);

System.out.println("sqlforoverspeed>%%%%%%%%%%%%%%"+sqlforoverspeed);



String abcd9=sqlforoverspeed.replace("'","#");	
abcd9=abcd9.replace(",","$");								
stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gpsExceptions','"+abcd9+"')");
}catch(Exception e){
	
}
try{
String sqlforra="CREATE TABLE  IF NOT EXISTS db_gpsExceptions.t_veh"+nextvehcode+"_ra ("+
"  `VehCode` int(10) unsigned default '0',"+
"  `TheDate` date default NULL,"+
 " `TheTime` time default NULL,"+
"  `FromSpeed` int(3) unsigned default '0',"+
 " `ToSpeed` int(3) unsigned default '0',"+
 " `JCode` varchar(50) default '-',"+
"  `DCode` varchar(50) default '-',"+
 " `Transporter` varchar(100) default NULL,"+
 " `UpdateDateTime` timestamp NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,"+
"  KEY `NewIndex` (`TheDate`,`TheTime`)"+
") ENGINE=MyISAM DEFAULT CHARSET=latin1";
stmt8.executeUpdate(sqlforra);

System.out.println("sqlforra>%%%%%%%%%%%%%%"+sqlforra);
String abcd9=sqlforra.replace("'","#");	
abcd9=abcd9.replace(",","$");								
stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gpsExceptions','"+abcd9+"')");
}catch(Exception e){
	
}
try{
String sqlforrd="CREATE TABLE  IF NOT EXISTS db_gpsExceptions.t_veh"+nextvehcode+"_rd ("+
"  `VehCode` int(10) unsigned default '0',"+
"  `TheDate` date default NULL,"+
"  `TheTime` time default NULL,"+
"  `FromSpeed` int(3) unsigned default '0',"+
"  `ToSpeed` int(3) default '0',"+
"  `JCode` varchar(50) default '-',"+
"  `DCode` varchar(50) default '-',"+
"  `Transporter` varchar(100) default NULL,"+
"  `UpdateDateTime` timestamp NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,"+
" KEY `NewIndex` (`TheDate`,`TheTime`)"+
") ENGINE=MyISAM DEFAULT CHARSET=latin1";
stmt9.executeUpdate(sqlforrd);

System.out.println("sqlforrd>%%%%%%%%%%%%%%"+sqlforrd);
String abcd9=sqlforrd.replace("'","#");	
abcd9=abcd9.replace(",","$");								
stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gpsExceptions','"+abcd9+"')");
}catch(Exception e){
	
}
try{
String sqlfornd="CREATE TABLE  IF NOT EXISTS db_gpsExceptions.t_veh"+nextvehcode+"_nd ("+
"  `VehCode` int(10) unsigned default '0',"+
"  `FromDate` date default NULL,"+
"  `FromTime` time default NULL,"+
"  `ToDate` date default NULL,"+
"  `ToTime` time default NULL,"+
"  `Distance` double default '0',"+
"  `Duration` varchar(100) default '-',"+
"  `JCode` varchar(50) default '-',"+
"  `DCode` varchar(50) default '-',"+
"  `Transporter` varchar(100) default NULL,"+
"  `UpdateDateTime` timestamp NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,"+
"   NDPreAuthorised VARCHAR( 100 ) NOT NULL DEFAULT 'No', "+ 
"   KEY `NewIndex` (`FromDate`,`FromTime`)"+
") ENGINE=MyISAM DEFAULT CHARSET=latin1";
stmt10.executeUpdate(sqlfornd);

System.out.println("sqlforrd>%%%%%%%%%%%%%%"+sqlfornd);
String abcd9=sqlfornd.replace("'","#");	
abcd9=abcd9.replace(",","$");								
stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gpsExceptions','"+abcd9+"')");
}catch(Exception e){
	
}
try{
String sqlforstsp="CREATE TABLE IF NOT EXISTS db_gpsExceptions.t_veh"+nextvehcode+"_stsp ("+
" `VehCode` int(10) unsigned default '0',"+
"  `FromDate` date default NULL,"+
"  `FromTime` time default NULL,"+
"  `ToDate` date default NULL,"+
"  `ToTime` time default NULL,"+
"  `Duration` varchar(100) default '-',"+
"  `Location` varchar(255) default '-',"+
"  `JCode` varchar(50) default '-',"+
"`DCode` varchar(50) default '-',"+
"`Transporter` varchar(100) default NULL,"+
"`UpdateDateTime` timestamp NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,"+
"`ValidWardStop` varchar(50) NOT NULL default 'No',"+
" KEY `NewIndex` (`FromDate`,`FromTime`)"+
") ENGINE=MyISAM DEFAULT CHARSET=latin1";
stmt11.executeUpdate(sqlforstsp);

System.out.println("sqlforstsp>%%%%%%%%%%%%%%"+sqlforstsp);
String abcd9=sqlforstsp.replace("'","#");	
abcd9=abcd9.replace(",","$");								
stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gpsExceptions','"+abcd9+"')");
}catch(Exception e){
	
}
try{
String sqlforcr="CREATE TABLE IF NOT EXISTS db_gpsExceptions.t_veh"+nextvehcode+"_cr ( "+
"`VehCode` int(10) unsigned default '0', "+
"`FromDate` date default NULL,"+
"`FromTime` time default NULL,"+
"`ToDate` date default NULL,"+
"`ToTime` time default NULL,"+
"`Duration` varchar(100) default '-',"+
"`NoofStops` int(10) unsigned default '0',"+
"`Distance` double default '0',"+
"`JCode` varchar(50) default '-',"+
"`DCode` varchar(50) default '-',"+
"`Transporter` varchar(100) default NULL,"+
"KEY `NewIndex` (`FromDate`,`FromTime`)"+
") ENGINE=MyISAM DEFAULT CHARSET=latin1";
stmt12.executeUpdate(sqlforcr);

System.out.println("sqlforcr>%%%%%%%%%%%%%%"+sqlforcr);
String abcd9=sqlforcr.replace("'","#");	
abcd9=abcd9.replace(",","$");								
stmtinsert.executeUpdate("Insert into t_sqlquery (dbname,query) values ('db_gpsExceptions','"+abcd9+"')");
}catch(Exception e){
	
}
send="inserted"; 
out.println(send);
String SmsFormat="",smsParameter="";
String addvehicle="Installtion";
 //SendMsgParameter msg = new SendMsgParameter();	
//msg.Send(CodeVersion,vehiclecode+"",vehreg,custname,ownname,unid,mobno,addvehicle,entby);
/*
try{
String sqlSms="select Message from db_gps.t_messageFormat where Parameter='ST'";
System.out.println(sqlSms);
ResultSet rsSms=stmt12.executeQuery(sqlSms);
if(rsSms.next()){
 SmsFormat=rsSms.getString("Message");
 System.out.println(SmsFormat);
 String sms="";
 int parameterValueForTX=0,parameterValueForST=0;
 
 if(CodeVersion.contains("M12_avl1pt1") || 
		 CodeVersion.contains("SIMARM")|| CodeVersion.contains("AVL_LITE")||
		 	CodeVersion.contains("FM2200")||CodeVersion.contains("TWP3_TS")||
		 	CodeVersion.contains("TW_P1_TS_RTC")){
 	parameterValueForST=(Integer.parseInt(finalST)*1000)/500;
 	 System.out.println(parameterValueForST);
 	parameterValueForTX=(Integer.parseInt(finalTX)*1000)/500;
 	 System.out.println(parameterValueForTX);
 }else{
	 parameterValueForST=(Integer.parseInt(finalST)*1000)/100;
 	 System.out.println(parameterValueForST);
 	parameterValueForTX=(Integer.parseInt(finalTX)*1000)/100;
 	 System.out.println(parameterValueForTX);
 
 	SmsFormat=SmsFormat.replace("ST",parameterValueForST+"");
 	SmsFormat=SmsFormat.replace("TX",parameterValueForTX+"");
 	System.out.println(SmsFormat);
 	SmsFormat="UI"+unid+SmsFormat;
 sms=URLEncoder.encode(SmsFormat);
 System.out.println(sms);
	//  String smsurl="http://india.timessms.com/http-api/receiverall.asp?username=Transworld-INT&password=mobeye&sender=transw&cdmasender=&to="+mobno+"&message="+sms;
	  String smsurl="http://india.timessms.com/http-api/receiverall.asp?username=Transworld&password=vikram&sender=TransWld&sign=diary&to="+mobno+"&message="+sms+"&gateway=regular";
	  URL url=new URL(smsurl);
	URLConnection connection = url.openConnection();
	connection.connect();
	BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
	String line;
	while ((line = in.readLine()) != null )
	{
		String sqlSentMessage="insert into db_gps.t_msgSentDetails "+ 
		"(UnitID,MobNo,ActualMsg,MsgType,SenderID,Date_Time,VehicleRegNo,Transporter,ConfStatus,EntBy) values ("+
		"'"+unid+"','"+mobno+"','"+SmsFormat+"','ST,TX parameter','"+entby+"','"+formatter1.format(d)+"','"+vehreg+"','"+ownname+"','Pending','Auto')";
		System.out.println("sqlSentMessage====>"+sqlSentMessage);
		stmt11.executeUpdate(sqlSentMessage);
	}
 }
 }
}catch(Exception e){
	e.printStackTrace();
}
try{
String sqlSms1="select Message from db_gps.t_messageFormat where Parameter='RA'";
System.out.println(sqlSms1);
ResultSet rsSms1=stmt12.executeQuery(sqlSms1);
if(rsSms1.next()){
 SmsFormat=rsSms1.getString("Message");
 System.out.println(SmsFormat);
 String sms="";
 if(CodeVersion.contains("M12_avl1pt1") || 
		 CodeVersion.contains("SIMARM")|| CodeVersion.contains("AVL_LITE")||
		 	CodeVersion.contains("FM2200")||CodeVersion.contains("TWP3_TS")||
		 	CodeVersion.contains("TW_P1_TS_RTC")){
	 
 }else{
 int parameterValueForOS=0,parameterValueForRA=0;
 if(Integer.parseInt(finalRA)>Integer.parseInt(finalRD)){
 	parameterValueForRA=Integer.parseInt(finalRD);
 }else{
	 parameterValueForRA=Integer.parseInt(finalRA);
 }
 		System.out.println(parameterValueForRA);
 	parameterValueForOS=Integer.parseInt(finalOS);
 	 System.out.println(parameterValueForOS);
 	SmsFormat=SmsFormat.replace("RA",parameterValueForRA+"");
 	SmsFormat=SmsFormat.replace("OS",parameterValueForOS+"");
 	System.out.println(SmsFormat);
 	sms="UI"+unid+SmsFormat;
    stmt11.executeUpdate("insert into db_gps.t_msgNotSendDetails(UnitID,MobNo,Msg,InsertedDateTime,MsgType,SenderID,VehicleRegNo,Transporter) values ('"+unid+"','"+mobno+"','"+sms+"','"+formatter2.format(d)+"','RA,RD,OS parameter','"+entby+"','"+vehreg+"','"+ownname+"') ");
 sms=URLEncoder.encode(sms);
 System.out.println(sms);
	  String smsurl="http://india.timessms.com/http-api/receiverall.asp?username=Transworld-INT&password=mobeye&sender=transw&cdmasender=&to="+mobno+"&message="+sms;
	URL url=new URL(smsurl);
	URLConnection connection = url.openConnection();
	connection.connect();
	BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
	String line;
	while ((line = in.readLine()) != null )
	{
		String sqlSentMessage="insert into db_gps.t_msgSentDetails "+ 
		"(UnitID,MobNo,ActualMsg,MsgType,SenderID,Date_Time,VehicleRegNo,Transporter,ConfStatus,EntBy) values ("+
		"'"+unid+"','"+mobno+"','"+sms+"','RA,RD,OS parameter','"+entby+"','"+formatter1.format(d)+"','"+vehreg+"','"+ownname+"','Pending','Auto')";
		System.out.println("sqlSentMessage====>"+sqlSentMessage);
		stmt11.executeUpdate(sqlSentMessage);
	}
} }

}catch(Exception e){
	e.printStackTrace();
}
*/

con2.close();




response.sendRedirect("addunit_ft.jsp?send="+send+"&unitidnew="+unid);
return; 
} catch(Exception e) { e.printStackTrace();out.println(e); }

finally
{
	con2.close();
	 
}
%>