<%@ include file="Connections/conn.jsp" %>

<%!
	Connection con1;
	String sql1="",sql3="";
%>

<%
	String trinerName="",tripClassi="",drengage="";
	String gpscapt="",percGPS="",Serviceable="",tripdata="",reactive="",replaced="",OtherObs="",jrmdb="",drivearlier="";
	String unsched="",routdev="",jrmrisk="",vehfit="",servicedue="",visibledamage="",overall="",driverfit="",visibleabnorm="";
	
	String zonechangewarning="",otherFeedback="",JRMinstalled="",routeUpload="";
	String drrespons="",drfitothobs="",tripsamedriver="",drvresp="",drvMobNo="",AllOthrObs="",remark="",AllOthrObscom="",brfid="";
	
	String drengagecom="",Serviceablecom="",specinstcomm="";
	String tripdatacom="",reactivecom="",replacedcom="",OtherObscom="",jrmdbcom="",drivearliercom="",unschedcom="",routdevcom="";
	String serviceduecom="",visibledamagecom="",overallcom="",driverfitcom="",visabnormcom="",drresponscom="",drfitothobscom="";
	
	String zonechangewarningcom="",otherFeedbackcom="",JRMinstalledcom="",routeUploadcom="";
	String drivername="",driverid="",tripid="",tripsamedrivercom="",vehfitcom="",jrmriskcom="",mobno="";
	int pos=0,pos1=0,pos2=0,pos3=0,pos4=0;
	
	try
	{ 
		java.util.Date tdydte = new java.util.Date();
		Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dbrfdate=formatter.format(tdydte);
		Class.forName(MM_dbConn_DRIVER);
		con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		Statement stmt1=con1.createStatement();  
		Statement stmt2=con1.createStatement();  
		Statement stquery=con1.createStatement();
		tripClassi=request.getParameter("tripClassi");
		String trainerName = (String) session.getAttribute("user");
		remark=request.getParameter("Rem");
		String transporter=request.getParameter("transporter");
		String group=session.getValue("usertypevaluemain").toString();
		//System.out.println("group--->"+group);
		//if(null==tripClassi||"null".equalsIgnoreCase(tripClassi)||tripClassi.equals("Trip"))
		//{
			tripid=request.getParameter("tripid");
		//}
		//else
		//{
			//tripid="NA";
		//}
		driverid=request.getParameter("driverid");
		//System.out.println("driverid-->"+driverid);
		drivername=request.getParameter("drivername");
		brfid=request.getParameter("brfid");
		//trinerName=request.getParameter("trinerName");
		
		
		gpscapt=request.getParameter("gpscapt");
		//System.out.println("gpscapt-->"+gpscapt);
		if(gpscapt.equals("Yes"))
		{
			percGPS=request.getParameter("percGPS");
		}
		else
		{
			percGPS="NA";
		}
		if(gpscapt.equals("Yes"))
		{
			Serviceable="NA";
			tripdata="NA";
			reactive="NA";
			replaced="NA";
			OtherObs="NA";
			try
			{
				session.setAttribute("Serviceablecom","");
	
			}
			catch(Exception e)
			{
				
			}
			try
			{
				session.setAttribute("tripdatacom","");
	
			}
			catch(Exception e)
			{
				
			}
			try
			{
				session.setAttribute("reactivecom","");
	
			}
			catch(Exception e)
			{
				
			}
			try
			{
				session.setAttribute("replacedcom","");
	
			}
			catch(Exception e)
			{
				
			}
			try
			{
				session.setAttribute("OtherObscom","");
			}
			catch(Exception e)
			{
				
			}
		}
		else
		{
			Serviceable=request.getParameter("Serviceable");
			tripdata=request.getParameter("tripdata");
			reactive=request.getParameter("reactive");
			replaced=request.getParameter("replaced");
			OtherObs=request.getParameter("OtherObs");
		}
	
		jrmdb=request.getParameter("jrmdb");
		if(jrmdb == null || jrmdb.equals("null"))
		{
			jrmdb = "No";
		}
		
		
		if(jrmdb.equals("No"))
		{
			drivearlier="NA";
			unsched="NA";
			routdev="NA";
			jrmrisk="NA";
			zonechangewarning="NA";
			otherFeedback="NA";
			JRMinstalled="NA";
			routeUpload="NA";
			try
			{
				session.setAttribute("drivearliercom","");
	
			}
			catch(Exception e)
			{
				
			}
			try
			{
				session.setAttribute("unschedcom","");
	
			}
			catch(Exception e)
			{
				
			}
			try
			{
				session.setAttribute("routdevcom","");
	
			}
			catch(Exception e)
			{
				
			}
			try
			{
				session.setAttribute("jrmriskcom","");
			}
			catch(Exception e)
			{
				
			}
			///////////////////////
			try
			{
				session.setAttribute("zonechangewarningcom","");
			}
			catch(Exception e)
			{
				
			}
			
			try
			{
				session.setAttribute("otherFeedbackcom","");
			}
			catch(Exception e)
			{
				
			}
			
			try
			{
				session.setAttribute("JRMinstalledcom","");
			}
			catch(Exception e)
			{
				
			}
			
			try
			{
				session.setAttribute("routeUploadcom","");
			}
			catch(Exception e)
			{
				
			}
			
			
			//////////////
		}
		else
		{
			drivearlier=request.getParameter("drivearlier");
			unsched=request.getParameter("unsched");
			routdev=request.getParameter("routdev");
			jrmrisk=request.getParameter("jrmrisk");
		//	System.out.println("jrmrisk--->"+jrmrisk);
			zonechangewarning=request.getParameter("zonechangewarning");
		//	System.out.println("zonechangewarning--->"+zonechangewarning);
			otherFeedback=request.getParameter("otherFeedback");
		//	System.out.println("otherFeedback--->"+otherFeedback);
			JRMinstalled=request.getParameter("JRMinstalled");
		//	System.out.println("JRMinstalled--->"+JRMinstalled);
			routeUpload=request.getParameter("routeUpload");
		//	System.out.println("routeUpload--->"+routeUpload);
		}
		vehfit=request.getParameter("vehfit");
		if(vehfit.equals("No"))
		{
			servicedue="NA";
			visibledamage="NA";
			overall="NA";
			try
			{
				session.setAttribute("serviceduecom","");
	
			}
			catch(Exception e)
			{
				
			}
			try
			{
				session.setAttribute("visibledamagecom","");
	
			}
			catch(Exception e)
			{
				
			}
			try
			{
				session.setAttribute("overallcom","");
			}
			catch(Exception e)
			{
				
			}
		}
		else
		{
			servicedue=request.getParameter("servicedue");
			visibledamage=request.getParameter("visibledamage");
			overall=request.getParameter("overall");
		}
		
		driverfit=request.getParameter("driverfit");
		if(driverfit.equals(""))
		{
			visibleabnorm="NA";
			drrespons="NA";
			drfitothobs="NA";
			tripsamedriver="NA";
			try
			{
				session.setAttribute("visibledamagecom","");
	
			}
			catch(Exception e)
			{
				
			}
			try
			{
				session.setAttribute("overallcom","");
	
			}
			catch(Exception e)
			{
				
			}
			try
			{
				session.setAttribute("driverfitcom","");
	
			}
			catch(Exception e)
			{
				
			}
			try
			{
				session.setAttribute("visabnormcom","");
			}
			catch(Exception e)
			{
				
			}
		}
		else
		{
			visibleabnorm=request.getParameter("visibleabnorm");
			drrespons=request.getParameter("drrespons");
			drfitothobs=request.getParameter("drfitothobs");
			tripsamedriver=request.getParameter("tripsamedriver");
		}
		drvresp=request.getParameter("drvresp");
		pos=drvresp.indexOf("'");
			if(pos>0)
			{
	        		drvresp=drvresp.replace("'","");
			}
		drvMobNo=request.getParameter("drvMobNo");
		mobno=request.getParameter("mobno");
		if(mobno.equals("Yes"))
		{
			drvMobNo=request.getParameter("drvMobNo");
		}
		else
		{
			drvMobNo="NA";
		}
		AllOthrObs=request.getParameter("AllOthrObs");
		
		try
		{
			Serviceablecom=session.getAttribute("Serviceablecom").toString();
			Serviceablecom=Serviceablecom.substring(1,Serviceablecom.length());
		}
		catch(Exception e)
		{
			Serviceablecom="-";
		}

		try
		{
			tripdatacom=session.getAttribute("tripdatacom").toString();
			tripdatacom=tripdatacom.substring(1,tripdatacom.length());
		}
		catch(Exception e)
		{
			tripdatacom="-";
		}

		try
		{
			reactivecom=session.getAttribute("reactivecom").toString();
			reactivecom=reactivecom.substring(1,reactivecom.length());
		}
		catch(Exception e)
		{
			reactivecom="-";
		}
		try
		{
			replacedcom=session.getAttribute("replacedcom").toString();
			replacedcom=replacedcom.substring(1,replacedcom.length());
		}
		catch(Exception e)
		{
			replacedcom="-";
		}

		try
		{
			OtherObscom=session.getAttribute("OtherObscom").toString();
			OtherObscom=OtherObscom.substring(1,OtherObscom.length());
		}
		catch(Exception e)
		{
			OtherObscom="-";
		}

		try
		{
			jrmdbcom=session.getAttribute("jrmdbcom").toString();
			jrmdbcom=jrmdbcom.substring(1,jrmdbcom.length());
		}
		catch(Exception e)
		{
			jrmdbcom="-";
		}

		try
		{
			drivearliercom=session.getAttribute("drivearliercom").toString();
			drivearliercom=drivearliercom.substring(1,drivearliercom.length());
		}
		catch(Exception e)
		{
			drivearliercom="-";
		}

		
		try
		{
			unschedcom=session.getAttribute("unschedcom").toString();
			unschedcom=unschedcom.substring(1,unschedcom.length());
		}
		catch(Exception e)
		{
			jrmdbcom="-";
		}

		try
		{
			routdevcom=session.getAttribute("routdevcom").toString();
			routdevcom=routdevcom.substring(1,routdevcom.length());
		}
		catch(Exception e)
		{
			routdevcom="-";
		}

		try
		{
			jrmriskcom=session.getAttribute("jrmriskcom").toString();
			//System.out.println("jrmriskcom--->"+jrmriskcom);
			jrmriskcom=jrmriskcom.substring(1,jrmriskcom.length());
		}
		catch(Exception e)
		{
			jrmriskcom="-";
		}
		
		//////////////////////////////////
		try
		{
			zonechangewarningcom=session.getAttribute("zonechangewarningcom").toString();
		//	System.out.println("zonechangewarningcom--->"+zonechangewarningcom);
			zonechangewarningcom=zonechangewarningcom.substring(1,zonechangewarningcom.length());
		}
		catch(Exception e)
		{
			zonechangewarningcom="-";
		}

		
		try
		{
			otherFeedbackcom=session.getAttribute("otherFeedbackcom").toString();
		//	System.out.println("otherFeedbackcom--->"+otherFeedbackcom);
			otherFeedbackcom=otherFeedbackcom.substring(1,otherFeedbackcom.length());
		}
		catch(Exception e)
		{
			otherFeedbackcom="-";
		}

		try
		{
			JRMinstalledcom=session.getAttribute("JRMinstalledcom").toString();
		//	System.out.println("JRMinstalledcom--->"+JRMinstalledcom);
			JRMinstalledcom=JRMinstalledcom.substring(1,JRMinstalledcom.length());
		}
		catch(Exception e)
		{
			JRMinstalledcom="-";
		}

		try
		{
			routeUploadcom=session.getAttribute("routeUploadcom").toString();
			//System.out.println("routeUploadcom--->"+routeUploadcom);
			routeUploadcom=routeUploadcom.substring(1,routeUploadcom.length());
		}
		catch(Exception e)
		{
			routeUploadcom="-";
		}
		
		//////////////////////////////////
		
		try
		{
			vehfitcom=session.getAttribute("vehfitcom").toString();
			vehfitcom=vehfitcom.substring(1,vehfitcom.length());
		}
		catch(Exception e)
		{
			vehfitcom="-";
		}

		try
		{
			serviceduecom=session.getAttribute("serviceduecom").toString();
			serviceduecom=serviceduecom.substring(1,serviceduecom.length());
		}
		catch(Exception e)
		{
			serviceduecom="-";
		}

		try
		{
			visibledamagecom=session.getAttribute("visibledamagecom").toString();
			visibledamagecom=visibledamagecom.substring(1,visibledamagecom.length());
		}
		catch(Exception e)
		{
			visibledamagecom="-";
		}

		try
		{
			overallcom=session.getAttribute("overallcom").toString();
			overallcom=overallcom.substring(1,overallcom.length());
		}
		catch(Exception e)
		{
			overallcom="-";
		}

		try
		{
			driverfitcom=session.getAttribute("driverfitcom").toString();
			driverfitcom=driverfitcom.substring(1,driverfitcom.length());
		}
		catch(Exception e)
		{
			driverfitcom="-";
		}

		try
		{
			visabnormcom=session.getAttribute("visabnormcom").toString();
			visabnormcom=visabnormcom.substring(1,visabnormcom.length());
		}
		catch(Exception e)
		{
			visabnormcom="-";
		}

		try
		{
			drresponscom=session.getAttribute("drresponscom").toString();
			drresponscom=drresponscom.substring(1,drresponscom.length());
		}
		catch(Exception e)
		{
			drresponscom="-";
		}

		try
		{
			drfitothobscom=session.getAttribute("drfitothobscom").toString();
			drfitothobscom=drfitothobscom.substring(1,drfitothobscom.length());
		}
		catch(Exception e)
		{
			drfitothobscom="-";
		}

		try
		{
			tripsamedrivercom=session.getAttribute("tripsamedrivercom").toString();
			tripsamedrivercom=tripsamedrivercom.substring(1,tripsamedrivercom.length());
		}
		catch(Exception e)
		{
			tripsamedrivercom="-";
		}

		try
		{
			AllOthrObscom=session.getAttribute("AllOthrObscom").toString();
			AllOthrObscom=AllOthrObscom.substring(1,AllOthrObscom.length());
		}
		catch(Exception e)
		{
			AllOthrObscom="-";
		}
		try
		{
			specinstcomm=session.getAttribute("specinstcomm").toString();
			specinstcomm=specinstcomm.substring(1,specinstcomm.length());
		}
		catch(Exception e)
		{
			specinstcomm="-";
		}
		String fdname="";

	//out.print("Lai bhari vatat");
			int ins=0;																																																																																																																																																																																																																														
	sql1="insert into t_debriefing(briefid,Debriefdate,DriverName,driverid,tripid,gpscapture,gpscapturecomm,gpsserviciable,gpsserviciablecom,gpscomptrip,gpscomptripcom,gpsreactive,gpsreactivecomm,gpsreplace,gpsreplacecom,gpsothobs,gpsothobscomm,jrm,jrmcom,jrmdrivearli,drivearliercom,jrmunschedule,jrmunschedulecom,jrmdeviroot,jrmdevirootcom,jrmrisk,jrmriskcom,zoneChangewarning,zoneChangeCom,otherJRMFeedBack,otherFeedBackCom,JRMInstalled,JRMInstalledCom,routeUploaded,routeUploadedCom,vehfitnext,vehfitnextcom,vehfitdue,vehfitduecom,vehfitvisibledam,vehfitvisibledamcom,vehfitoverall,vehfitoverallcom,driverfit,driverfitcom,drfitvisibleabnorm,drfitvisibleabnormcom,drfitdriverresp,driverrespcomm,drfitothobs,drfitothobscom,drfittripsamedriver,drfittripsamecom,driverresponce,drivermobno,othobs,othobscom,Remark,remarkcom,Trainername,transporter,GPNAME)values('"+brfid+"','"+dbrfdate+"','"+drivername+"','"+driverid+"','"+tripid+"','"+gpscapt+"','"+percGPS+"','"+Serviceable+"','"+Serviceablecom+"','"+tripdata+"','"+tripdatacom+"','"+reactive+"','"+reactivecom+"','"+replaced+"','"+replacedcom+"','"+OtherObs+"','"+OtherObscom+"','"+jrmdb+"','"+jrmdbcom+"','"+drivearlier+"','"+drivearliercom+"','"+unsched+"','"+unschedcom+"','"+routdev+"','"+routdevcom+"','"+jrmrisk+"','"+jrmriskcom+"','"+zonechangewarning+"','"+zonechangewarningcom+"','"+otherFeedback+"','"+otherFeedbackcom+"','"+JRMinstalled+"','"+JRMinstalledcom+"','"+routeUpload+"','"+routeUploadcom+"','"+vehfit+"','"+vehfitcom+"','"+servicedue+"','"+serviceduecom+"','"+visibledamage+"','"+visibledamagecom+"','"+overall+"','"+overallcom+"','"+driverfit+"','"+driverfitcom+"','"+visibleabnorm+"','"+visabnormcom+"','"+drrespons+"','"+drresponscom+"','"+drfitothobs+"','"+drfitothobscom+"','"+tripsamedriver+"','"+tripsamedrivercom+"','"+drvresp+"','"+drvMobNo+"','"+AllOthrObs+"','"+AllOthrObscom+"','"+remark+"','"+specinstcomm+"','"+trainerName+"','"+transporter+"','"+group+"')";
	try{
		  ins=stmt1.executeUpdate(sql1);
		  System.out.println("****ins"+ins);
		  if(ins>0){
				String sql2="select debriefid as fdname from t_debriefing where driverid='"+driverid+"' order by Debriefdate desc limit 1  ";
				ResultSet rs2=stmt2.executeQuery(sql2);
				if(rs2.next()){
					fdname=rs2.getString("fdname");
					 System.out.println("****fdname"+fdname);
					 }
					 
					String abcd=sql1.replace("'","#");
					abcd=abcd.replace(",","$");
					stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
					/*****************************/

					sql3="update t_briefing set debrifstatus='debriefed' where driverid='"+driverid+"' ";
					
					/*Query to insert query in db_gps.t_sqlquery table*/
					String abcd1=sql3.replace("'","#");
					abcd1=abcd1.replace(",","$");
					stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
					/*****************************/
					
					stmt1.executeUpdate(sql3);
					
					session.setAttribute("traininginptcom","");
					session.setAttribute("rdinductcom","");
					session.setAttribute("lastTrDetcom","");
					session.setAttribute("nextTrainingcom","");
					session.setAttribute("MedicalChkupcom","");
					session.setAttribute("drengagecom","");
					session.setAttribute("Serviceablecom","");
					session.setAttribute("tripdatacom","");
					session.setAttribute("reactivecom","");
					session.setAttribute("replacedcom","");
					session.setAttribute("OtherObscom","");
					session.setAttribute("jrmdbcom","");
					session.setAttribute("drivearliercom","");
					session.setAttribute("unschedcom","");
					session.setAttribute("routdevcom","");
					session.setAttribute("jrmriskcom","");
					/////////////////////
					session.setAttribute("zonechangewarningcom","");
					session.setAttribute("otherFeedbackcom","");
					session.setAttribute("JRMinstalledcom","");
					session.setAttribute("routeUploadcom","");
					/////////////////////
					session.setAttribute("vehfitcom","");
					session.setAttribute("serviceduecom","");
					session.setAttribute("visibledamagecom","");
					session.setAttribute("overallcom","");
					session.setAttribute("driverfitcom","");
					session.setAttribute("visabnormcom","");
					session.setAttribute("drresponscom","");
					session.setAttribute("drfitothobscom","");
					session.setAttribute("tripsamedrivercom","");
					session.setAttribute("AllOthrObscom","");
					session.setAttribute("specinstcomm","");
					
					response.sendRedirect("driver_debriefing.jsp?inserted=successfull&drivername="+drivername+"&debriefId="+fdname);
					return;
		  }
			else {
				response.sendRedirect("alert.jsp?fromPage=De-Brief");
			}

	}catch(Exception e){
		e.printStackTrace();
		response.sendRedirect("alert.jsp?fromPage=De-Brief");
	}
	
	
	
	
	return;
}
catch(Exception e)
{
	//out.println("Exception----->" +e);	
	e.printStackTrace();
}
finally
{
 	try
 	{
 		con1.close();
 	}catch(Exception e)
 	{
 		
 	}
}
%>
