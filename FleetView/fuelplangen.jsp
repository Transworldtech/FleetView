<%@ include file="Connections/conn.jsp" %>

<%@page import="java.util.Date"%>
<%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%-- <%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%> --%>
   <%@ page import="java.sql.*" %>

  	<%-- <%@ page import = "java.io.FileNotFoundException"%>
  	<%@ page import = "java.io.FileOutputStream"%>
  	<%@ page import = "java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>
  	<%@page import="java.io.BufferedReader" import="java.io.InputStreamReader" import="java.net.URL" %>
  	<%@page import="java.net.URLEncoder" import="java.net.URLConnection"%> --%>
  	
  	 

<%!
Connection con1;
Statement st,st1,st2,st3,st4,st5;
%>
<% 
try {
	//out.println("here********************************************************************");
	String owner=session.getAttribute("usertypevalue").toString();
	//out.println("here"+owner);
	String user=session.getAttribute("mainuser").toString();
	//out.println("here"+user);
	//String routeid=request.getParameter("routid");
	String stdate=request.getParameter("stdate");
	//out.println("here"+stdate);
	String fuelplan=request.getParameter("fuelplan");
	//out.println("here"+fuelplan);
	String StartCode=request.getParameter("StartPlace");
	//out.println("here"+StartCode);
	String EndCode=request.getParameter("EndPlace");
	//out.println("EndCode"+EndCode);
	String Kmpl=request.getParameter("Kmpl");
	//out.println("Kmpl"+Kmpl);
	String GPName=request.getParameter("GPName");
	String routecodenew=request.getParameter("routecodenew");
	String vehcode=request.getParameter("vehcode");
	//out.println("GPName"+GPName);
	
	//String Totaldistance=request.getParameter("Kmval");
	//double Totaldistancem=Double.parseDouble(Totaldistance);
	//System.out.println("fulmaster**Totaldistance***Totaldistancem********************************************"+Totaldistancem);
	//System.out.println("fulmaster**Totaldistance***********************************************"+Totaldistance);
	//double que=Double.parseDouble(Quantity);
	Format fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String insertdate = fmt.format(new java.util.Date());
		//out.println("here"+insertdate);
	
	
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();

ResultSet rst=null;
String sql="",body="",prevoiusdistance="0";
boolean flag=false;
String sql3="",JRMRouteID="";
String Rname="",nodays="",geofencename="",geofenceid="",Km="",distance="",Fuel="";
Double fuelrate=0.0;
int nday;

String fmt1 = "yyyy-MM-dd";
String fmt2 = "dd-MMM-yyyy";
//String dt = "2016-04-22";
java.text.DateFormat df = new java.text.SimpleDateFormat(fmt1);
java.text.DateFormat df1 = new java.text.SimpleDateFormat(fmt2);
java.util.Calendar cal = java.util.Calendar.getInstance();
//out.println("here");
//int distancem=Integer.parseInt(distance);
//double distancem=Double.parseDouble(distance);
//System.out.println("fulmaster*************************************************:-"+distancem);
//System.out.println("Totaldistancemnopqr*************************************************:-"+distancem);
//int Totaldistancem=to t;
//System.out.println("Totaldistancem*************************************************:-"+Totaldistancem);

//////////////////////////Find route code here..../////////////////////////////////////////
String sql5="select * from db_gps.routeprofilemaster where routecode=?";
	PreparedStatement preparedStatement123 =con1.prepareStatement(sql5);
	preparedStatement123.setString(1, routecodenew);
	//preparedStatement123.setString(2, EndCode);
	ResultSet rs5=preparedStatement123.executeQuery();
	if(rs5.next()){
		JRMRouteID=rs5.getString("rid");
		//Km=rs.getDouble("Km");
		//StartPlace=rs.getString("StartPlace");
		//EndPlace=rs.getString("EndPlace");
		//StartCode=rs.getString("StartCode");
		//StartCode=StartCode.trim();
		//EndCode=rs.getString("EndCode");
		//Owner=rs.getString("Owner");
		//tripdays=rs.getDouble("tripdays");
		//startend=StartPlace+"-"+EndPlace;
	}
//////////////////////////////////////////////////////////////////////////////////////
/////////////////////////Default fuel rate ...............//////////////////////////////////
	

String fueltype="select Fuel from db_gps.t_VehMst where VehId='"+vehcode+"' ";
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
	
/////////////////////////////////////////////////////////////////////////////////////

if(fuelplan.equals("Daywise")){
	//out.println("1");
	//out.println("<font size='2' color='red'>Distance should not greater than Total distance</font>");
	StringBuffer str=new StringBuffer("");
	int i=1,totinp=0;
    str.append("<table class='sortable' border='1' style='width:30%;' ><tr><th><b>Date</b></th><th><b>Quantity</b></th><th><b>Amount(Rs)</b></th></tr>");
                
    //out.println("2");
	String day="select * from db_gps.t_daywisefuelplan where StartPlace=? and EndPlace=? and owner=? order by day asc";
	//out.println("owner"+owner);
    PreparedStatement ps=con1.prepareStatement(day);
    ps.setString(1, StartCode);
    ps.setString(2, EndCode);
    ps.setString(3, owner);
	//ps.setString(1, owner);
	ResultSet rs=ps.executeQuery();
	// out.println("3");
	while(rs.next()){
		nodays=rs.getString("day");
		nday=Integer.parseInt(nodays);
		// out.println("4"+nday);
		 /* if(nday==1){
			 nday=nday-1;	 
		 } */
		 nday=nday-1;
		 
		//out.println("5"+nday);
		try {
			
		    cal.setTime(df.parse(stdate));
		    cal.add(java.util.Calendar.DATE, nday);
		    //cal.add(df.parse(stdate), nday);
		    //cal.ad
		    //out.println("6");
		    //System.out.println(cal.getTime());
		    //System.out.println("final"+df.format(cal.getTime()));
		    //System.out.println("final1"+df1.format(cal.getTime()));
		} catch (Exception e) {
			out.println("exception:-"+e);
		}
		String inp="<div align='left'><input type='text' style='width: 100px;' name='fuelentr"+i+"' id='fuelentr"+i+"' value='' onkeyup=''/>Ltrs</div>";
		str.append("<tr>");
		
		str.append("<td align='right'><div align='right' id='fdate"+i+"'>"+df1.format(cal.getTime())+"<input type='hidden' name='fdate"+i+"' id='fdate"+i+"' value='"+df1.format(cal.getTime())+"'/></div></td>"); 
		str.append("<td align='right'>"+inp+"</td>");
		str.append("<td align='right'><div align='right' id='amt"+i+"'>0.0<input type='hidden' name='amt9"+i+"' id='amt9"+i+"' value='' /></div></td></tr>");
		/* str.append("<td align='right'><div align='right'>"+rsd.getInt("quantity")+"</div></td> " ); */
		//str.append("<td align='right'><div align='right'>"+Balance+"</div></td>");
		//str.append("<td><div  align='center'><a href='' onClick='return deletdistance('"+rs.getString("routeid")+"','"+rs.getString("distance")+"','"+rs.getString("ID")+"');'>Delete</a></div></td></tr>");
		//out.println("3");
		//totinp+=Integer.parseInt(inp);
		i++;
	  
	} //close while loop
	//out.println("4");
	//str.append("<tr><td><div align='right' id='totfdate'><b>Total</b></div></td><td><div align='right' id='totfdate"+i+"'><b></b></div></td><td><div align='right' id='amt"+i+"'><b></b></div></td></tr>");
	str.append("</table>");
	str.append("<table width='30%' border='0'><br><tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id='saveForm1' name='submit1'  class='button_text' type='button'  value='Expence' onclick='genamount();' />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id='saveForm2' name='submit2'  class='button_text' style='display: none;' type='Submit'  value='Save' onclick='' /></td></tr></table>");
	Rname=Rname+str.toString();
	System.out.print(Rname);
	Rname=Rname+"#"+i;
	out.print(Rname); 
	
}else if(fuelplan.equals("Geofence")){
	
	//out.println("in geofence");
	
	StringBuffer strgeo=new StringBuffer("");
	 	 	
	strgeo.append("<table class='sortable' border='1' style='width:30%;' ><tr><th><b>Location</b></th><th><b>KM</b></th><th><b>Quantity</b></th><th><b>Fuel Amount(Rs)</b></th></tr>");
                
	Double dKm=0.0,dKmpl=0.0,Qnty=0.0;
	Double deffuelrate,fuelamount=0.0,totdKm=0.0,totQnty=0.0,totfuelamount=0.0;
	int i=1,j=1,k=1;
	String prevgeofencename="",mainprevgeofencename="",mainprevgeofenceid="",prevgeofenceid="";
	dKmpl=Double.parseDouble(Kmpl);
	
	
	//out.println("in fuelrate"+fuelrate);
	String geo="select geofenceid,geofencename,Km from db_gps.t_geofencefuelplan where owner=? and routeid=? order by rid asc";
	//out.println("owner"+owner);
    PreparedStatement ps1=con1.prepareStatement(geo);
    //ps1.setString(1, "Castrol");
      ps1.setString(1, owner);
      ps1.setString(2, JRMRouteID);
	ResultSet rs1=ps1.executeQuery();
	    
	while(rs1.next()){
		geofencename=rs1.getString("geofencename");
		geofenceid=rs1.getString("geofenceid");
		Km=rs1.getString("Km");
		dKm=Double.parseDouble(Km);
		   /* if(rs1.previous()){
		prevgeofencename=rs9.getString("geofencename");
		System.out.println("prevgeofencename:-"+prevgeofencename);
		mainprevgeofencename=geofencename+"-"+prevgeofencename;
		} */   
		//if(Km.equals("0") || dKm==0 )
		//{
			/* if(j==1){
			String prevgeo="select geofenceid,geofencename,Km from db_gps.t_geofencefuelplan where owner=? and routeid=? order by rid asc";
	        PreparedStatement ps9=con1.prepareStatement(prevgeo);
	        //ps9.setString(1, "Castrol");
	        ps9.setString(1, owner);
	        ps9.setString(2, JRMRouteID);
			ResultSet rs9=ps9.executeQuery();
			if(rs9.next()){
			prevgeofencename=rs9.getString("geofencename");
			prevgeofenceid=rs9.getString("geofenceid");
			System.out.println("prevgeofencename:-"+prevgeofencename);
			}
			j=j+1;
			} */
		//}else{
			
			/* if(prevgeofencename.equals(geofencename))
			{
				//mainprevgeofencename=geofencename;
				//mainprevgeofenceid=geofenceid;
				prevgeofencename=geofencename;
				prevgeofenceid=geofenceid;
				
			}else{
				mainprevgeofencename=prevgeofencename+"-"+geofencename;
				mainprevgeofenceid=prevgeofenceid+"-"+geofenceid;
			} */
			
			//prevgeofencename=geofencename;
			//prevgeofenceid=geofenceid;
			mainprevgeofencename=geofencename;
			mainprevgeofenceid=geofenceid;
			System.out.println("prevgeofencename out side:-"+prevgeofencename);
			
			try{
			Qnty=dKm/dKmpl;
			Qnty = Math.round(Qnty * 100.0) / 100.0;
			//Qnty = (double) Math.round(Qnty);
			//out.println("in Qnty"+Qnty);
			fuelamount=Qnty*fuelrate;
			//fuelamount = (double) Math.round(fuelamount);
			fuelamount = Math.round(fuelamount * 100.0) / 100.0;
			//out.println("in fuelamount"+fuelamount);
			}catch(Exception e){
				e.printStackTrace();
			}
			 //k=i-2;
			if(!(Km.equals("0")) || dKm!=0 )
			{
			strgeo.append("<tr>");
			strgeo.append("<td align='right'><div align='left' id='geofencename"+i+"'>"+mainprevgeofencename+"<input type='hidden' name='geofencename"+i+"' id='geofencename"+i+"' value='"+mainprevgeofencename+"'/><input type='hidden' name='geofenceid"+i+"' id='geofenceid"+i+"' value='"+mainprevgeofenceid+"'/></div></td>");
			strgeo.append("<td align='right'><div align='right' id='Km"+i+"'>"+dKm+"<input type='hidden' name='geoKm"+i+"' id='geoKm"+i+"' value='"+dKm+"'/></div></td>");
				
			
			strgeo.append("<td align='right'><div align='right' id='quantity"+i+"'>"+Qnty+"<input type='hidden' name='geoquantity"+i+"' id='geoquantity"+i+"' value='"+Qnty+"'/></div></td>");
			strgeo.append("<td align='right'><div align='right' id='amt"+i+"'>"+fuelamount+"<input type='hidden' name='geoamt"+i+"' id='geoamt"+i+"' value='"+fuelamount+"' /></div></td>");
			}
			i++;
		//}
			totdKm+=dKm;
			totQnty+=Qnty;
			totQnty = Math.round(totQnty * 100.0) / 100.0;
			totfuelamount+=fuelamount;
			totfuelamount = Math.round(totfuelamount * 100.0) / 100.0;
		
	}// close while loop of geofence
	 //}
	strgeo.append("<tr><td><div align='left' id='totfdate'><b>Total</b></div></td><td><div align='right' id='geoKm"+i+"'><b>"+totdKm+"</b></div></td><td><div align='right' id='geoquantity"+i+"'><b>"+totQnty+"</b></div></td><td><div align='right' id='geoamt"+i+"'><b>"+totfuelamount+"</b></div></td></tr>");
	strgeo.append("</table>");
	strgeo.append("<table width='30%' border='0'><br><tr><td><div align='center'><input id='saveForm2' name='submit2'  class='button_text' style='' type='Submit'  value='Save' onclick='' /></div></td></tr></table>");
	Rname=Rname+strgeo.toString();
	System.out.print(Rname);
	Rname=Rname+"#"+i;
	out.print(Rname); 

}else if(fuelplan.equals("Km")){
	
	StringBuffer strdist=new StringBuffer("");
	 	
	strdist.append("<table class='sortable' border='1' style='width:30%;' ><tr><th><b>Distance Range</b></th><th><b>Quantity</b></th><th><b>Fuel Amount(Rs)</b></th></tr>");
                
	Double ddistance=0.0,dKmpl=0.0,Qnty=0.0,totddistance=0.0,totQnty=0.0,grandtotfuelamount=0.0;
	Double fuelamount=0.0,dprevdistance=0.0,calmaindistance=0.0;
	int i=1,j=1;
	String prevdistance="",mainprevdistance="",distrange="";
	dKmpl=Double.parseDouble(Kmpl);
	
	String dt="select distance,distrange from db_gps.t_dtwisefuelplan where owner=? and routeid=? order by distance asc";
	PreparedStatement ps6=con1.prepareStatement(dt);
	    //ps6.setString(1, "Castrol");
	      ps6.setString(1, owner);
	      ps6.setString(2, JRMRouteID);
	      ResultSet rs6=ps6.executeQuery();

	    while(rs6.next()){
			distance=rs6.getString("distance");
			//out.println("curr distance:-"+distance);
			distrange=rs6.getString("distrange");
			//Km=rs6.getString("Km");
			ddistance=Double.parseDouble(distance);
			 if(j==1){
				String prevdt="select distance,distrange from db_gps.t_dtwisefuelplan where owner=? and routeid=? order by distance asc";
		        PreparedStatement ps7=con1.prepareStatement(prevdt);
		        //ps7.setString(1, "Castrol");
		        ps7.setString(1, owner);
		        ps7.setString(2, JRMRouteID);
				ResultSet rs7=ps7.executeQuery();
				if(rs7.next()){
				prevdistance=rs7.getString("distance");
				//out.println("prevdistance distance:-"+prevdistance);
				dprevdistance=Double.parseDouble(prevdistance);
				System.out.println("prevdistance:-"+prevdistance);
				}
				j=j+1;
				} 
				
			//}else{
				
				dprevdistance=Double.parseDouble(prevdistance);
				mainprevdistance=prevdistance+"-"+distance;
				//out.println("mainprevdistance distance:-"+mainprevdistance);
				//out.println("dprevdistance:-"+dprevdistance);
				//out.println("ddistance:-"+ddistance);
				//calmaindistance=dprevdistance-ddistance;
				calmaindistance=ddistance-dprevdistance;
				//out.println("calmaindistance distance:-"+calmaindistance);
				
				//out.println("prevdistance distance:-"+prevdistance);
				System.out.println("mainprevdistance out side:-"+mainprevdistance);
				
				try{
				//out.println("before calcualtion dprevdistance:-"+dprevdistance);
				//out.println("before dKmpl:-"+dKmpl);
				if(i==1){
					Qnty=dprevdistance/dKmpl;
				}else{
					Qnty=calmaindistance/dKmpl;
				}
				 
				//Qnty=dprevdistance/dKmpl;
				//out.println("Qnty distance:-"+Qnty);
				
				//Qnty = (double) Math.round(Qnty);
				Qnty = Math.round(Qnty * 100.0) / 100.0;
				//out.println("Qnty distance:-"+Qnty);
				//out.println("in Qnty"+Qnty);
				fuelamount=Qnty*fuelrate;
				//out.println("fuelamount distance:-"+fuelamount);
				
				//fuelamount = (double) Math.round(fuelamount);
				fuelamount = Math.round(fuelamount * 100.0) / 100.0;
				
				//out.println("in fuelamount"+fuelamount);
				}catch(Exception e){
					e.printStackTrace();
				}
				prevdistance=distance;
				//dprevdistance=0.0;
				//if(!(Km.equals("0")) || ddistance!=0 )
				//{
					strdist.append("<tr>");
					strdist.append("<td align='right'><div align='right' id='distancernge"+i+"'>"+distrange+"<input type='hidden' name='distancernge"+i+"' id='distancernge"+i+"' value='"+ddistance+"'/></div></td>");
					/* strdist.append("<td align='right'><div align='right' id='Km"+i+"'>"+ddistance+"<input type='hidden' name='distKm"+i+"' id='distKm"+i+"' value='"+ddistance+"'/></div></td>"); */
					
				
					strdist.append("<td align='right'><div align='right' id='distquantity"+i+"'>"+Qnty+"<input type='hidden' name='distquantity"+i+"' id='distquantity"+i+"' value='"+Qnty+"'/></div></td>");
					strdist.append("<td align='right'><div align='right' id='amt"+i+"'>"+fuelamount+"<input type='hidden' name='distamt"+i+"' id='distamt"+i+"' value='"+fuelamount+"' /></div></td>");
				//}
				i++;
			//}
				
				totQnty+=Qnty;
				totQnty = Math.round(totQnty * 100.0) / 100.0;
				grandtotfuelamount+=fuelamount;
				grandtotfuelamount = Math.round(grandtotfuelamount * 100.0) / 100.0;
			
		}// close while loop of geofence
		strdist.append("<tr><td><div align='right' id='totfdate'><b>Total</b></div></td><td><div align='right' id='distquantity"+i+"'><b>"+totQnty+"</b></div></td><td><div align='right' id='distamt"+i+"'><b>"+grandtotfuelamount+"</b></div></td></tr>");
		strdist.append("</table>");
		
		strdist.append("<table width='30%' border='0'><br><tr><td><div align='center'><input id='saveForm2' name='submit2'  class='button_text' style='' type='Submit'  value='Save' onclick='' /></div></td></tr></table>");
		Rname=Rname+strdist.toString();
		System.out.print(Rname);
		Rname=Rname+"#"+i;
		out.print(Rname); 
	
}
else{
	
	out.println("<font size='2' color='red'>Please select Fuel plan.</font>");
	/* try{
		 String dis="select distance from db_gps.t_dtwisefuelplan where owner=? order by distance asc"; 
	    PreparedStatement ps=con1.prepareStatement(dis);
		ps.setString(1, owner);
		ResultSet rs=ps.executeQuery();
		while(rs.next()){
			prevoiusdistance=rs.getString("distance");
			
		}  */
		

	//int prevoiusdistancem=Integer.parseInt(prevoiusdistance);


			
	/* String insrtmaster="insert into db_gps.t_dtwisefuelplan(routeid,distance,entby,insertdate,owner) values(?,?,?,?,?) ";
	//out.println("fulmaster*************************************************:-"+insrtmaster);
	PreparedStatement ps1=con1.prepareStatement(insrtmaster);
	//out.println("fulmaster*************************************************:-"+insrtmaster);
	ps1.setString(1, routeid);
	ps1.setString(2, distance);
	ps1.setString(3, user);
	ps1.setString(4, insertdate);
	ps1.setString(5, owner);

	ps1.executeUpdate();
	 */
	/* String concatdist="";
	String Sqlday1="select * from db_gps.t_dtwisefuelplan where owner=? order by ID";
	System.out.println("route name=====>"+Sqlday1);
	PreparedStatement ps5=con1.prepareStatement(Sqlday1);
	ps5.setString(1, owner);
	ResultSet rsd5=ps5.executeQuery();
	//int countrow=rsd.getRow();
	if(rsd5.next()){
	 concatdist=prevoiusdistance+"-"+rsd5.getString("distance");
	 System.out.println("fulmaster*************************************************:-"+concatdist);
	} */
	/* String concatdist="";
	concatdist=prevoiusdistance+"-"+distance;
	String distmaster="update db_gps.t_dtwisefuelplan set distrange=? where routeid=? and distance=? and owner=? ";
	System.out.println("fulmaster*************************************************:-"+distmaster);
	PreparedStatement ps4=con1.prepareStatement(distmaster);
	System.out.println("fulmaster*************************************************:-"+distmaster);
	ps4.setString(1, concatdist);
	ps4.setString(2, routeid);
	ps4.setString(3, distance);
	ps4.setString(4, owner);

	ps4.executeUpdate(); */

	 //response.sendRedirect("RoutePlan.jsp");
	 /* StringBuffer str=new StringBuffer("");
	 str.append("<table class='sortable' border='1' style='width:25%;' ><tr><th><b>Sr.No</b></th><th><b>Distance</b></th><th><b>Delete</b></th></tr>");
	    int i=1,Balance=0;
		String Sqlday="select * from db_gps.t_dtwisefuelplan where owner=? order by ID";
		System.out.println("route name=====>"+Sqlday);
		PreparedStatement ps2=con1.prepareStatement(Sqlday);
		ps2.setString(1, owner);
		ResultSet rsd=ps2.executeQuery(); */
		//int countrow=rsd.getRow();
	    
	/* 
		while(rsd.next())
		{ 
			//str.append("<tr><td><div  align='left'><a href='javascript:deletStop('"+tripid+"','"+briefid+"','"+driverid+"','"+i+"','"+rsd.getString("geofencename")+"','"+rsd.getString("Km")+"','"+Balance+"');'>Delete</a></div>	</td>");
			
			//out.print("mystring*************************"+str);
			str.append("<tr>");
			str.append("<td align='right'><div align='right'>"+i+"</div></td>"); 
			str.append("<td align='right'><div align='right'>"+rsd.getString("distrange")+"</div></td>");
			/* str.append("<td align='right'><div align='right'>"+rsd.getInt("quantity")+"</div></td> " ); */
			//str.append("<td align='right'><div align='right'>"+Balance+"</div></td>");
			//str.append("<td><div  align='center'><a href='' onClick='return deletdistance('"+rsd.getString("routeid")+"','"+rsd.getString("distance")+"','"+rsd.getString("ID")+"');'>Delete</a></div></td></tr>");
			
			//i++;
		//}
		//str.append("</table>");
		////Rname=Rname+str.toString();
		//System.out.print(Rname);
		//prevoiusdistance="";
		//out.print(Rname); 
	 //out.print("1");
	//System.out.println("fulmaster**************************************************************************************:-");
	 //return;





	/* }catch(Exception e)
	{e.printStackTrace();} */
}//else of total distance graeter than current


} catch(Exception e) { 
	out.print("NotDone"+e);
	e.printStackTrace();
	}
	finally
	{
		//st.close();
		//st1.close();
		con1.close();
	}

%>