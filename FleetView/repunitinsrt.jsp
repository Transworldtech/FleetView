<!--  < %@page import="com.einnovates.controllers.SendMsgParameter"%> -->
   <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="javax.swing.*" import="java.net.*" import="java.io.*" errorPage="" %>

<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*" %>
<!-- 
  Module Name : Replacement Unit Details insertion
  Creator : Azhar G B
  Date of Creation : 31/05/08
  Modifier :
  Date of Modification :
  Reason of Modification :
  Description : This page is to add details of replaced unit. This won't be visible.
-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script language="javascript">
function validate()
{

alert("hi");
return false;	
}



</script>
</head>
<body>
<%!
Connection con2, con1;
String send="";
%>

<%
try {
	
	System.out.println("=====1111=========");
	String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";
	String MM_dbConn_USERNAME="fleetview";
	String MM_dbConn_PASSWORD="1@flv";
	String MM_dbConn_STRING="jdbc:mysql://localhost/db_gps";
	String MM_dbConn_STRING1="jdbc:mysql://localhost/db_CustomerComplaints";
	String MM_dbConn_STRING3="jdbc:mysql://localhost/db_CustomerComplaints";
	String SiteRoot="http://localhost:8080/AVL/";
	
	
	
	
	System.out.println("=====2222=========");
Class.forName(MM_dbConn_DRIVER);
con2 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

Statement stmt2=con2.createStatement(), stmt3=con2.createStatement(), stmt4=con1.createStatement(), stmt12=con2.createStatement(), stmt11=con2.createStatement(),stmttd=con2.createStatement(),stmttd1=con2.createStatement(),stmttd2=con2.createStatement();
Statement stmtinsert=con2.createStatement(),stmtinsert1=con2.createStatement();
String sql1="", sql2="", sql3="", sql4="", sql5="", sql6="", sql12="", sql13="", sql14="",  sql15="", sql17="", sql18="", sql19="", sql20="", sql21="", sql22="", sql23="",sqltd="";
ResultSet rs1=null, rs5=null, rs6=null, rs12=null, rs13=null, rs14=null, rs15=null, rs21=null, rs22=null;
String ownname="",para="",form="", vehreg="",oldunid="", newunid="", instdate="", instat="", typeunit="", email="", instby="", tme="", tmetoinsrt="", newtme="", othloc="", locinsrt="", entby="",  instime="00:00:00", hour="", minutes="", mobno="", simno="", warcomment="";
String RA="0",RD="0",OS="0",ST="0",TX="0";
String finalRA=RA,finalRD=RD,finalOS=OS,finalST=ST,finalTX=TX;
String custnme="", vehnumb="", drivname="", drivcode="", drivmob="", voice1="", voice2="";
String oldunitcond="", newdamageopt="", newunitrunon="", damageopt="", oldunitwith="",CodeVersion="";

String trsql="",trsql1="";
System.out.println("=====333=========");

int i1=0, i2=0, i3=0, i4=0; 
Format formatter1=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
   java.util.Date d=new java.util.Date();
   String dte= "" + (d.getYear()+1900) + "-" + (1+d.getMonth()) + "-" + d.getDate();

   java.util.Date datefrmdb=new SimpleDateFormat("yyyy-MM-dd").parse(dte);
   Format formatter=new SimpleDateFormat("yyyy-MM-dd");
   String nwfrmtdte=formatter.format(datefrmdb);
java.util.Date datefrmdb1=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(d));
   String nwfrmtdte1=formatter.format(datefrmdb1);
entby=(String)session.getAttribute("fname");
String aks="NO";
String usr =(String)session.getAttribute("user");

String usr1 =(String)session.getAttribute("mainuser");

String sessionEmail1=session.getValue("email").toString();

System.out.println("=====44444====sessionEmail1====="+sessionEmail1);


String user2=entby+" "+usr1;
System.out.println("=====44444====usr====="+usr);
System.out.println("=====44444====entby====="+entby);
System.out.println("=====44444====usr1====="+usr1);

System.out.println("=====44444====user2====="+user2);
/* *********** get all the fileds from the form ************* */

ownname=request.getParameter("owner");
form=request.getParameter("page");
para=request.getParameter("parameter");
vehreg=request.getParameter("vehreg");
oldunid=request.getParameter("oldunid");
newunid=request.getParameter("newunid");
instdate=request.getParameter("calender");
Format fmt1 = new SimpleDateFormat("dd-MM-yyyy HH:mm");
instdate=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").parse(instdate));


System.out.println("=====44444=^^^^^^===datefrmdb2====="+instdate);


instat=request.getParameter("instat");
typeunit=request.getParameter("typeunit");
instby=request.getParameter("instby");
tme=request.getParameter("tme");
newtme=request.getParameter("newtme");
othloc=request.getParameter("othinst");
//entby=request.getParameter("entby");
hour=request.getParameter("hour");
minutes=request.getParameter("minutes");
simno=request.getParameter("simno");
mobno=request.getParameter("mobno");
drivname=request.getParameter("drivername");
drivcode=request.getParameter("drivercode");
drivmob=request.getParameter("drivermob");
oldunitcond=request.getParameter("phydamaged");
newunitrunon=request.getParameter("unitrunon");
oldunitwith=request.getParameter("oldunitwith");
warcomment=request.getParameter("warcom");
String redlight="-";
String greenlight="-";
String gpslight="-";
String ringing="-";
String spcom="-";
String extracomm="-";
String whyoption=request.getParameter("whyoption");

String vid=request.getParameter("vid"); 

String tid ="0";
RA=request.getParameter("RA");
RD=request.getParameter("RD");
OS=request.getParameter("OS");
ST=request.getParameter("ST");
TX=request.getParameter("TX");
String getRA=request.getParameter("getRA");

System.out.println("=====InstDate========="+instdate);

System.out.println("=====RA========="+RA);
System.out.println("=====RD========="+RD);
System.out.println("=====OS========="+OS);
System.out.println("=====ST========="+ST);
System.out.println("=====TX========="+TX);
System.out.println("=====getRA========="+getRA);


System.out.println("=====mobno========="+mobno);

if("".equalsIgnoreCase(getRA)||"null".equalsIgnoreCase(getRA)){
	finalRA=RA;	
}else{
	finalRA=getRA;	
}
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
String getST=request.getParameter("getST");
if("".equalsIgnoreCase(getST)||"null".equalsIgnoreCase(getST)){
	finalST=ST;
}else{
	finalST=getST;	
}
String getTX=request.getParameter("getTX");
if("".equalsIgnoreCase(getTX)||"null".equalsIgnoreCase(getTX)){
	finalTX=TX;
}else{
	finalTX=getTX;	
}
System.out.println(whyoption);
System.out.println(extracomm+"   "+warcomment);

/* **************************************************** */
String warcomment1="";
if(warcomment.equalsIgnoreCase("Yes"))
{
	warcomment1=request.getParameter("comment");
}
else
{
	warcomment1="No Comment";
}



String type="",hld="NA";

trsql="select TypeValue from db_gps.t_security where Username = '"+usr1+"'";
ResultSet rus=stmttd1.executeQuery(trsql);
System.out.println("=====trsql========="+trsql);

if(rus.next())
{
type=rus.getString("TypeValue");
	
	
}
//type="Test";
trsql1="select HoldBy from db_gps.t_unitmaster where UnitID = '"+newunid+"' ";
ResultSet rus1=stmttd2.executeQuery(trsql1);
System.out.println("=====trsql1========="+trsql1);

if(rus1.next())
{
	hld=rus1.getString("HoldBy");
	
	
}
//hld="ALL";

System.out.println("=====type====%%%====="+type);
System.out.println("=====hld==%%%====="+hld);







sqltd="select tid from db_gps.t_liveticket where vehid ='"+vid+"' ";


ResultSet td=stmttd.executeQuery(sqltd);
System.out.println("=====sqltd===after======"+sqltd);
if(td.next())
{
tid=td.getString("tid");	
	
}

System.out.println("=====tid========="+tid);


System.out.println("=====qqqq=========");





System.out.println("=====sdsdsdsdsd=========");


if(oldunitcond.equals("Yes"))
{
	String damopt1=request.getParameter("gpsantcut");
	String damopt2=request.getParameter("greenlightoff");
	String damopt3=request.getParameter("loosecon");	
	String damopt4=request.getParameter("powharndam");
	String damopt5=request.getParameter("unitfndop");	

	if(damopt1==null)
	{
	}
	else
	{
		damageopt=damageopt+";"+damopt1;
	}

	if(damopt2==null)
	{
	}
	else
	{
		damageopt=damageopt+";"+damopt2;
	}

	if(damopt3==null)
	{
	}
	else
	{
		damageopt=damageopt+";"+damopt3;
	}

	if(damopt4==null)
	{
	}
	else
	{
		damageopt=damageopt+";"+damopt4;
	}

	if(damopt5==null)
	{
	}
	else
	{
		damageopt=damageopt+";"+damopt5;
	}	

	newdamageopt=request.getParameter("newdamageoption");
	if(!(newdamageopt==null))
	{
		damageopt=damageopt+";"+"Other;"+newdamageopt;

		//sql21="insert into t_unitdamagedoptions (Name) value ('"+newdamageopt+"')";
		//stmt4.executeUpdate(sql21);
	}
}
else
{
	damageopt="No";
}


System.out.println("=====232323======");
out.print(damageopt);


String instdate1=instdate;
   
   if(instdate.length()> 12)
   {
   
	    instdate1=instdate.substring(0,instdate.lastIndexOf(" "));   
	   instime=instdate.substring(instdate.lastIndexOf(" "),instdate.length());
   }
   System.out.println("=====232323==instdate1==####=="+instdate1);
   System.out.println("=====232323==instdate==####=="+instime);
   
int unidint=Integer.parseInt(newunid);

System.out.println("=====232323====####==");

if(typeunit.equals("VOICECALL"))
{
	voice1=request.getParameter("voice1");
	voice2=request.getParameter("voice2");
}
else
{
	voice1="NA";
	voice2="NA";
}

System.out.println("=====232323====####111==");

System.out.println("=====66666666=="+instime);

String unidchk="";

String emailunit="me"+oldunid+"@mobile-eye.in";
String emailunit1="me"+oldunid+"@transworld-compressor.com";
int vehcode=0;
String InstalledDate="";
sql6="select VehicleCode,InstalledDate from db_gps.t_vehicledetails where VehicleRegNumber like '%"+vehreg+"%' and OwnerName not like '%del'";
System.out.println(sql6);
   rs6=stmt2.executeQuery(sql6);
   System.out.println("=====sql66666666=="+sql6);
   while(rs6.next())
   {
     vehcode=rs6.getInt("VehicleCode");
     InstalledDate=rs6.getString("InstalledDate");
   } 

/* *********** checking if the Unit ID is already configured in other Vehicle ************* */
sql15="select * from db_gps.t_vehicledetails where UnitID='"+newunid+"'";
System.out.println(sql15);
rs15=stmt3.executeQuery(sql15);
if(rs15.next())
{

	System.out.println("=====inside****==");
	custnme=rs15.getString("OwnerName"); 
vehnumb=rs15.getString("VehicleRegNumber");
	
System.out.println("=====inside111==");





if(form!=null && form.equalsIgnoreCase("repunit"))
	{
		response.sendRedirect("repunit1.jsp?vid="+vehcode+"&unidchk="+newunid+"&own="+custnme+"&vehnumb="+vehnumb);
		return;
	}
	else
	{
	 	response.sendRedirect("repunit.jsp?vid="+vehcode+"&unidchk="+newunid+"&own="+custnme+"&vehnumb="+vehnumb+"&parameter="+para);
    	return;
	}

}

System.out.println("=====type====%%%=111===="+type);
System.out.println("=====hld==%%%==2222==="+hld);
System.out.println(type!=hld);
System.out.println(type.equalsIgnoreCase(hld));

//if(!(whyoption.equalsIgnoreCase("-"))){}

/*
sql1="select TheFieldFromEmailAddress from t_vehicledetails " ;
rs1=stmt2.executeQuery(sql1);
while(rs1.next())
{
   String email1=rs1.getString("TheFieldFromEmailAddress");
  
    String unid1="";
    int len=email1.length();
    if(len>1)
    {
       int pos=email1.indexOf('@');
       unid1=email1.substring(2,pos);
   
  
      if(unid1.equals(newunid))
      {
         String unchk1="me"+unid1+"@transworld-compressor.com";
         String unchk2="me"+unid1+"@mobile-eye.in";
        
         sql15="select * from t_vehicledetails where TheFieldFromEmailAddress in('"+unchk1+"', '"+unchk2+"') ";
         rs15=stmt3.executeQuery(sql15);
         while(rs15.next())
         {
           custnme=rs15.getString("OwnerName"); 
           vehnumb=rs15.getString("VehicleRegNumber"); 
         } 

         if(form!=null && form.equalsIgnoreCase("repunit"))
         {
       response.sendRedirect("repunit.jsp?vid="+vehcode+"&unidchk="+newunid+"&own="+custnme+"&vehnumb="+vehnumb+"&parameter="+para);
       return;
         }
         else
         {
        	 response.sendRedirect("repunit1.jsp?vid="+vehcode+"&unidchk="+newunid+"&own="+custnme+"&vehnumb="+vehnumb);
             return;
         }
      }
      else {  }
   }
}*/
/* **************************************************** */





   email="me"+unidint+"@mobile-eye.in";


if(tme==null)
{
   tmetoinsrt=newtme;
}
else
{
   tmetoinsrt="5.30000019073486";
}
 

if(instat.equals("Other"))
{
locinsrt=othloc;
}

else
{
locinsrt=instat;
}

/* ******** Checking if Type of COnfi is Temp flow. If yes, then entry will go in t_tempsensorcust*********************************************** */

if(typeunit.equals("TEMPSENSOR"))
{
	sql22="select * from t_tempsensorcust where Transporter='"+ownname+"' ";
	rs22=stmt2.executeQuery(sql22);
	if(rs22.next())
	{
	}
	else
	{
		
		
		
			sql23="insert into t_tempsensorcust (Transporter,TicketID) values ('"+ownname+"','"+tid+"')";
			
		
		
		
		//Query for t_sqlquery
			String abcd=sql23.replace("'","#");	
			abcd=abcd.replace(",","$");								
			stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd+"')");
		stmt3.executeUpdate(sql23);
	}
}

/* ***************************************************************************************** */
/* ******** If all the conditions meet, it gets updated in DB on both the servers************ */

sql3="update db_gps.t_vehicledetails set TheFieldFromEmailAddress='"+email+"', UnitID='"+newunid+"', LastRepPlace='"+locinsrt+"', Description='"+typeunit+"', LastRepBy='"+instby+"',LastRepDate='"+nwfrmtdte+"', Status='-',ST='"+finalST+"',TX='"+finalTX+"',RA='"+finalRA+"',RD='"+finalRD+"',OS='"+finalOS+"'  where VehicleRegNumber='"+vehreg+"' ";
//Query for t_sqlquery
System.out.println(">null>>"+sql3);
String abcd1=sql3.replace("'","#");	
abcd1=abcd1.replace(",","$");								
stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd1+"')");
stmt2.executeUpdate(sql3);  
System.out.println(sql3);
String LastDataDate="",LastDataTime="";
String latest="select * from db_gps.allconnectedunits where UnitID='"+oldunid+"'";
System.out.println(latest);
ResultSet rslatest=stmtinsert.executeQuery(latest);
if(rslatest.next()){
	LastDataDate=rslatest.getString("TheDate");
	LastDataTime=rslatest.getString("TheTime");
	System.out.println(LastDataDate+"--"+LastDataTime);
}
String replace="SELECT * FROM db_gps.`t_unitreplacement` WHERE NewUnitID='"+oldunid+"' order by InstDate DESC limit 1";
System.out.println(replace);
ResultSet rsreplace=stmtinsert.executeQuery(replace);
String replacementdate="";
if(rsreplace.next()){
	replacementdate=rsreplace.getString("InstDate");
}
String unitlife="select TO_DAYS('"+LastDataDate+"')-TO_DAYS('"+replacementdate+"') as days";
System.out.println(unitlife);
 int days=0;
ResultSet rsunitlife=stmtinsert.executeQuery(unitlife);
if(rsunitlife.next()){

 days=rsunitlife.getInt("days");
}
System.out.println(days);
String warranty="";

String sqlamc="select * from db_gps.t_amchistory where VehNo = '"+vehreg+"' order by NewDate desc limit 1";
ResultSet rsamcc=stmtinsert.executeQuery(sqlamc);
System.out.println(">>sqlamc>>"+sqlamc);
if(rsamcc.next())
{
	if(!(null==rsamcc.getDate("WarrantyTill")))
	{
	try{	
		String sqlamc1="select TO_DAYS('"+rsamcc.getDate("WarrantyTill")+"')-TO_DAYS('"+instdate1+"') as days";
		System.out.println(sqlamc1);
		ResultSet rsamcc1=stmtinsert1.executeQuery(sqlamc1);
		if(rsamcc1.next())
		{
			if(rsamcc1.getInt("days") > 0)
			{
				warranty="Yes";
			}
			else
			{
				warranty="No";
			}
		}
		}
		catch(Exception X)
		{
			warranty="-";
		}
	}
	else
	{
		sql4="select TO_DAYS('"+instdate1+"')-TO_DAYS('"+InstalledDate+"') as days";
		ResultSet rst222=stmtinsert1.executeQuery(sql4);
		if(rst222.next())
		{
			if(rst222.getInt("days") > 365)
				{
					warranty="NO";
				}
			else
			{
				warranty="YES";
			}
		}
	}
}else{
	sql4="select TO_DAYS('"+instdate1+"')-TO_DAYS('"+InstalledDate+"') as days";
	ResultSet rst222=stmtinsert1.executeQuery(sql4);
	if(rst222.next())
	{
		if(rst222.getInt("days") > 365)
				{
			warranty="NO";
				}
		else
		{
			warranty="YES";
		}
	}
}
System.out.println(warranty);
System.out.println(">>####>>");
int rid=0;
sql5="select max(RID) from db_gps.t_unitreplacement";
rs5=stmt2.executeQuery(sql5);
System.out.println(">>##sql5##>>"+sql5);
while(rs5.next())
{
  rid=rs5.getInt(1);
}
rid=rid+1;


System.out.println(">>####111111>>");	
//if(tid==null || tid.equals("null") || tid.equals("-")){
//sql4="insert into db_gps.t_unitreplacement (VehCode, VehRegNo, OwnerName, OldUnitID, NewUnitID, InstDate, InstTime, InstBy, InstPlace, InstType, EntBy, SimNo, MobNo, DriverName, DriverCode, DriverMobNo, TypeUnit, VoiceCallNo1, VoiceCallNo2, OldUnitDamaged, NewUnitRunOn, OldUnitWith, EntDate,UnitLife,WasWarranty,adminoption) values ('"+vehcode+"', '"+vehreg+"', '"+ownname+"', '"+oldunid+"', '"+newunid+"', '"+instdate+"', '"+instime+"', '"+instby+"', '"+locinsrt+"', 'Rep', '"+entby+"', '"+simno.trim()+"', '"+mobno.trim()+"', '"+drivname+"', '"+drivcode+"', '"+drivmob+"', '"+typeunit+"', '"+voice1+"', '"+voice2+"', '"+damageopt+"', '"+newunitrunon+"', '"+oldunitwith+"', '"+nwfrmtdte+"','"+days+"','"+warranty+"','"+whyoption+"')" ;
//}else{
	
		
	
//}
	  
sql4="insert into db_gps.t_unitreplacement (TicketID,VehCode, VehRegNo, OwnerName, OldUnitID, NewUnitID, InstDate, InstTime, InstBy, InstPlace, InstType, EntBy, SimNo, MobNo, DriverName, DriverCode, DriverMobNo, TypeUnit, VoiceCallNo1, VoiceCallNo2, OldUnitDamaged, NewUnitRunOn, OldUnitWith, EntDate,UnitLife,WasWarranty,adminoption) values ('"+tid+"','"+vehcode+"', '"+vehreg+"', '"+ownname+"', '"+oldunid+"', '"+newunid+"', '"+instdate1+"', '"+instime+"', '"+instby+"', '"+locinsrt+"', 'Rep', '"+entby+"', '"+simno.trim()+"', '"+mobno.trim()+"', '"+drivname+"', '"+drivcode+"', '"+drivmob+"', '"+typeunit+"', '"+voice1+"', '"+voice2+"', '"+damageopt+"', '"+newunitrunon+"', '"+oldunitwith+"', '"+nwfrmtdte+"','"+days+"','"+warranty+"','"+whyoption+"')" ;

	//Query for t_sqlquery
	System.out.println(sql4);
	String abcd3=sql4.replace("'","#");	
	abcd3=abcd3.replace(",","$");								
	stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd3+"')");
	//out.print(sql4);
	stmt2.executeUpdate(sql4);
	System.out.println(">>####sql4>&&&&&>"+sql4);
	
	
	sql4="update db_gps.t_vehicledetails set LastReplacementDate='"+instdate1+" "+instime+"' where VehicleRegNumber='"+vehreg+"' "; 
	//Query for t_sqlquery
	  abcd3=sql4.replace("'","#");	
	abcd3=abcd3.replace(",","$");								
	stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd3+"')");
	out.print(sql4);
	stmt2.executeUpdate(sql4);
	System.out.println(">>###sql4#>>"+sql4);

/*-------------------------------------------------------------------------------------*/
if("-".equalsIgnoreCase(oldunid))
{}else{
	String sqlcomm="";
	//if(tid==null || tid.equals("null") || tid.equals("-")){
	
	// sqlcomm="insert into db_CustomerComplaints.t_techspecialrep (EntDateTime, TechName, UnitId, RedLight,  GreenLight, GPSLight, Ringing, VehRegNo, Transp, SpComment, EntBy, WarComment ,Extra_comment ,cmmt_type) values ('"+nwfrmtdte1+"', '"+instby+"', '"+oldunid+"', '"+redlight+"', '"+greenlight+"','"+gpslight+"', '"+ringing+"', '"+vehreg+"', '"+ownname+"', '"+spcom+"', '"+entby+"', '"+warcomment1+"','"+extracomm+"','Unit')";

	//}else{
		
		
		sqlcomm="insert into db_CustomerComplaints.t_techspecialrep (TicketID,EntDateTime, TechName, UnitId, RedLight,  GreenLight, GPSLight, Ringing, VehRegNo, Transp, SpComment, EntBy, WarComment ,Extra_comment ,cmmt_type) values ('"+tid+"','"+nwfrmtdte1+"', '"+instby+"', '"+oldunid+"', '"+redlight+"', '"+greenlight+"','"+gpslight+"', '"+ringing+"', '"+vehreg+"', '"+ownname+"', '"+spcom+"', '"+entby+"', '"+warcomment1+"','"+extracomm+"','Unit')";
		
	//}
	
	System.out.println(">>sxqlcomm>>>>"+sqlcomm);
//Query for t_sqlquery
String abc=sqlcomm.replace("'","#");	
abc=abc.replace(",","$");								
stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_CustomerComplaints','"+abc+"')");
stmt4.executeUpdate(sqlcomm);
}
/*-------------------------------------------------------------------------------------*/
System.out.println(">>>>ggggg>");
/* ************************************************************************************ */
sql12="select * from db_gps.t_unitmaster where UnitID='"+newunid+"' ";
rs12=stmt2.executeQuery(sql12);
System.out.println(">>>>sql12>"+sql12);
if(rs12.next())
{
	String RecByTech="No",RecByCust="No";
	RecByTech=rs12.getString("RecByTech");
	RecByCust=rs12.getString("RecByCust");
	if(("No".equalsIgnoreCase(RecByTech)||
			RecByTech.equalsIgnoreCase("No")||
				"0".equalsIgnoreCase(RecByTech)||
					"NULL".equalsIgnoreCase(RecByTech))
					&& ("No".equalsIgnoreCase(RecByCust)||
							RecByCust.equalsIgnoreCase("No"))){
		
		sql14="update db_gps.t_unitmaster set SimNo='"+simno+"', MobNo='"+mobno.trim()+"', InstType='New',RecByTech='Yes',RecConfirmByRep='"+entby+"',RecDateTime='"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(d)+"' where UnitID='"+newunid.trim()+"' ";
		//Query for t_sqlquery
		String abcd4=sql14.replace("'","#");	
		abcd4=abcd4.replace(",","$");								
		stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd4+"')");
	  	stmt3.executeUpdate(sql14);
	  	System.out.println(">>>>sql14>>>111"+sql14);
	}else{
		sql14="update db_gps.t_unitmaster set SimNo='"+simno+"', MobNo='"+mobno.trim()+"', InstType='New' where UnitID='"+newunid.trim()+"' ";
		//Query for t_sqlquery
		String abcd4=sql14.replace("'","#");	
		abcd4=abcd4.replace(",","$");								
		stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd4+"')");
	  	stmt3.executeUpdate(sql14);
	  	System.out.println(">>>>sql14>>>222>>"+sql14);
	}
	
}
else
{
	System.out.println(">>>>sql14>>>&&&");
	System.out.println(">>>>wwwwww>>>");
	//if(tid==null || tid.equals("null") || tid.equals("-")){
	
	//}else{
		
		
		
//	}
	
	sql13="insert into db_gps.t_unitmaster (TicketID,UnitID, SIMNo, MobNo, InstType) values('"+tid+"','"+newunid+"', '"+simno.trim()+"', '"+mobno.trim()+"', 'New')" ;	
	System.out.println(">>>>++++++>>>");
 // sql13="insert into db_gps.t_unitmaster (UnitID, SIMNo, MobNo, InstType) values('"+newunid+"', '"+simno.trim()+"', '"+mobno.trim()+"', 'New')" ;
	System.out.println(">>>>sql13>>>&&&"+sql13);
  //Query for t_sqlquery
	String abcd5=sql13.replace("'","#");	
	abcd5=abcd5.replace(",","$");								
	stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd5+"')");
  stmt2.executeUpdate(sql13);
	System.out.println(">>>>sql13>>>afeter&&&"+sql13);
  
  
} 
/* ***************************************************************************** */


/* ***************Updating on whose name the unit will remain ************* */

System.out.println(">>>>>>1111>%%%");

  sql17="update db_gps.t_unitmaster set HoldBy='"+ownname+"' where UnitId='"+newunid+"' ";
	//Query for t_sqlquery
	String abcd6=sql17.replace("'","#");	
	abcd6=abcd6.replace(",","$");								
	stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd6+"')");
 //out.print(sql17);
  stmt2.executeUpdate(sql17);

  String oldunitholdname="";
  System.out.println(">>>>>>222>%%%");
  if(oldunitwith.equals("Cust"))
  {
     oldunitholdname=ownname;
     sql18="update db_gps.t_unitmaster set HoldBy='"+oldunitholdname+"' where UnitId='"+oldunid+"' ";
  }
  else if(oldunitwith.equals("Tech"))
  {
      oldunitholdname=instby;
      sql18="update db_gps.t_unitmaster set HoldBy='"+oldunitholdname+"', FaultyUnit='Yes' where UnitId='"+oldunid+"' ";
  }
  else
  {
     oldunitholdname="Transworld";
     sql18="update db_gps.t_unitmaster set HoldBy='"+oldunitholdname+"' where UnitId='"+oldunid+"' ";
  }
//Query for t_sqlquery
	String abcd7=sql18.replace("'","#");	
	abcd7=abcd7.replace(",","$");								
	stmtinsert.executeUpdate("Insert into db_gps.t_sqlquery (dbname,query) values ('db_gps','"+abcd7+"')");
  
	System.out.println(">>>>>>sql18>%%%"+sql18);
	stmt2.executeUpdate(sql18); 

send="inserted";  
System.out.println(">>>hiiiiiiiiiii<<");

//if(tid==null || tid.equals("null") || tid.equals("-")){
	
	
	
	
		
	
	
//}else{
//String sqlths="insert into db_gps.t_tickethistory (TicketID,Action,ActionComment,ActionBy,Vehid,VehRegNo,Transporter) values ('"+tid+"','Unit Replacement','"+extracomm+"','"+entby+"','"+vehcode+"','"+vehreg+"','"+ownname+"') ";
//stmt3.executeUpdate(sqlths);
//System.out.println(">>>sqlths<<<"+sqlths);
//}

/**********************************query to find out codeversion of respective unitid******************************************************************/

String sqlths="insert into db_gps.t_tickethistory (TicketID,Action,ActionComment,ActionBy,Vehid,VehRegNo,Transporter) values ('"+tid+"','Unit Replacement','"+extracomm+"','"+entby+"','"+vid+"','"+vehreg+"','"+ownname+"') ";
stmt3.executeUpdate(sqlths);
System.out.println(">>>sqlths<<<"+sqlths);


System.out.println(">>>hiiii2222322222iiiiiii<<");


String sqlCode="select CodeVersion from db_gps.t_ftplastdump where UnitID='"+newunid+"'";
ResultSet rsCode=stmt12.executeQuery(sqlCode);
if(rsCode.next()){
	CodeVersion=rsCode.getString("CodeVersion");
	System.out.println(CodeVersion+"<--------code ver");
}
String addvehicle="Replacement";

  if(vid!=null){
	  



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
	         msg.setSubject("Replacement done using admin option");
	         msg.setSentDate(new java.util.Date());
	        // Address add1=new InternetAddress(email,email2);
	   //     	System.out.println("stp1"+chkdcntr1);
	      			  //  mail id-------------
	      			  String sessionEmail=session.getValue("email").toString();

	      	      Address recipientAddrs[] = new InternetAddress[2];
	      		  recipientAddrs[0] = new InternetAddress("p_khedkar@transworld-compressor.com");
	      		  recipientAddrs[1] = new InternetAddress(sessionEmail);
			      Address recipientAddrs1[] = new InternetAddress[1];
	             recipientAddrs1[0] = new InternetAddress("a_laddha@myfleetview.com");
	         msg.addRecipients(Message.RecipientType.TO,recipientAddrs);
	      //  msg.addRecipients(Message.RecipientType.CC,recipientAddrs1);
	         Address fromAddress=new InternetAddress("noreply@transworld-compressor.com","Transworld"); // in second "", it is short name
	      	System.out.println("stp4");
	         msg.setFrom(fromAddress);
	      	System.out.println("stp5");
	   String body="Sir, <br>Replacement done for vehicle "+vehreg+" using admin option.<br><html><body>"+
	   "<table align=center  cellpadding=0 cellspacing=0 width=100% border=1><tr BGCOLOR=#99CCFF>"+
	   "<td>Vehicle Reg No:</td><td>Transporter</td><td>UnitID</td><td>OldUnitID</td><td>Installed At</td><td>Installed By</td>"+
	   "</tr><tr><td>"+vehreg+"</td><td>"+ownname+"</td><td>"+newunid+"</td><td>"+oldunid+"</td><td>"+instat+"</td><td>"+instby+"</td></table></body></html>";
	   System.out.println(body);
	         msg.setContent(body,"text/html; charset=ISO-8859-1"); 
	         // Send the message
	         Transport t = session1.getTransport("smtps");
	         msg.saveChanges(); // don't forget this
	      	System.out.println("stp6");
	       
	         try
	         {
	     	 	System.out.println("stp7");
	              t.connect(host, user, pass);
	         	System.out.println("stp8");
	              t.sendMessage(msg, msg.getAllRecipients());
	              System.out.println("stp8");
	         }
	         catch(Exception e)
	         {
	             System.out.print("Exception----->"+e);
	            
	         } 
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
    
//SendMsgParameter msg = new SendMsgParameter();	
//msg.Send(CodeVersion,vehcode+"",vehreg,"none",ownname,newunid,mobno,addvehicle,entby);
/*
String SmsFormat="",smsParameter="";
try{
	String sqlSms="select Message from db_gps.t_messageFormat where Parameter='ST'";
	System.out.println(sqlSms);
	ResultSet rsSms=stmt12.executeQuery(sqlSms);
	if(rsSms.next()){
	 SmsFormat=rsSms.getString("Message");
	 System.out.println(SmsFormat);
	 String sms="";
	 int parameterValueForTX=0,parameterValueForST=0;
	 if(CodeVersion.contains("AVL_LITE")){
	 	parameterValueForST=(Integer.parseInt(finalST)*1000)/500;
	 	 System.out.println(parameterValueForST);
	 	parameterValueForTX=(Integer.parseInt(finalTX)*1000)/500;
	 	 System.out.println(parameterValueForTX);
	 }else{
		 parameterValueForST=(Integer.parseInt(finalST)*1000)/100;
	 	 System.out.println(parameterValueForST);
	 	parameterValueForTX=(Integer.parseInt(finalTX)*1000)/100;
	 	 System.out.println(parameterValueForTX);
	 }
	 	SmsFormat=SmsFormat.replace("ST",parameterValueForST+"");
	 	SmsFormat=SmsFormat.replace("TX",parameterValueForTX+"");
	 	System.out.println(SmsFormat);
	 	SmsFormat="UI"+newunid+SmsFormat;
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
			"'"+newunid+"','"+mobno+"','"+SmsFormat+"','ST,TX parameter','"+entby+"','"+formatter1.format(d)+"','"+vehreg+"','"+ownname+"','Pending','Auto')";
			System.out.println("sqlSentMessage====>"+sqlSentMessage);
			stmt11.executeUpdate(sqlSentMessage);
			System.out.println("sqlSentMessage====>"+sqlSentMessage);
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
		 	sms="UI"+newunid+SmsFormat;
		 	Format formatter2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 	stmt11.executeUpdate("insert into db_gps.t_msgNotSendDetails(UnitID,MobNo,Msg,InsertedDateTime,MsgType,SenderID,VehicleRegNo,Transporter) values ('"+newunid+"','"+mobno+"','"+sms+"','"+formatter2.format(d)+"','RA,RD,OS parameter','"+entby+"','"+vehreg+"','"+ownname+"') ");
		 sms=URLEncoder.encode(sms);
		 System.out.println(sms);
			  String smsurl="http://india.timessms.com/http-api/receiverall.asp?username=Transworld-INT&password=mobeye&sender=transw&cdmasender=&to="+mobno+"message="+sms;
			URL url=new URL(smsurl);
			URLConnection connection = url.openConnection();
			connection.connect();
			BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			String line;
			while ((line = in.readLine()) != null )
			{
				String sqlSentMessage="insert into db_gps.t_msgSentDetails "+ 
				"(UnitID,MobNo,ActualMsg,MsgType,SenderID,Date_Time,VehicleRegNo,Transporter,ConfStatus) values ("+
				"'"+newunid+"','"+mobno+"','"+sms+"','RA,RD,OS parameter','"+entby+"','"+formatter1.format(d)+"','"+vehreg+"','"+ownname+"','Pending')";
				System.out.println("sqlSentMessage====>"+sqlSentMessage);
				stmt11.executeUpdate(sqlSentMessage);
			} 
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		*/

		
		
		
		
	
	
		
	//aks="No";	
		
		if(form!=null && form.equalsIgnoreCase("repunit"))
{
response.sendRedirect("repunit1.jsp?send=inserted&vid="+vehcode);
return; 
}
else
{
	response.sendRedirect("repunit.jsp?send=inserted&vid="+vehcode+"&parameter=para");
	return; 
}

		
		
		
} catch(Exception e) { out.println("Exception----->"+e);e.printStackTrace(); }

finally
{
	try
	{
		con1.close();
		con2.close();
	}catch(Exception e)
	{
		
	}
}
%>
</body>
</html>