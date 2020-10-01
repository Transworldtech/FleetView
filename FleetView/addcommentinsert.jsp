<%@ include file="Connections/conn.jsp" %>
<%!
	Connection con1;
	String sql1="";
%>
<%
try
{
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement stmt1=con1.createStatement(); 	
	Statement stquery=con1.createStatement();
	String cmntinsrtfor=request.getParameter("commentfor");
	String comfrom=request.getParameter("comfrom");
	out.print(comfrom);
	String commtext=request.getParameter("commenttext");
	/*for(int i=0;i<commtext.length();i++){
		if(commtext.charAt(i)=='*'){
			commtext = commtext.replace(commtext.charAt(i),',') ;
			}
	} */
	
	String flag="true";
	String fix=request.getParameter("fix");
	String subm=request.getParameter("submit");
	int cntr=Integer.parseInt(request.getParameter("countcom"));
	
	if(fix==null)
	{
		String[] chkbox=new String[cntr];
		String[] id = new String[cntr];
		String[] x = new String[cntr];
		String commnt="";
		for(int k=0;k<cntr;k++)
		{
			x[k] = request.getParameter("dis"+k );
			if(x[k]==null)
       			{
     	    		}
       			else
       			{
				//chkdcntr++;
 				commnt=commnt+","+x[k];
			}
		}
		commnt=commnt+","+commtext;
		out.print(commnt); 
		commtext=commnt;
		//response.sendRedirect("addrivbrfngcmtn.jsp?inserted=successfull&commentfor="+cmntinsrtfor);
%>
<script language="javascript">
	window.close();
</script>
<%
	}
	else
	{
		//out.print("fixed is pressed");
		//out.print(comfrom);
		if(comfrom.equals("debrief"))
		{
			out.println("commtext--->"+commtext);
		sql1="insert into t_briefingcom(commentfor,comment,commenttype)values('"+cmntinsrtfor+"','"+commtext+"','DeBriefing')";
		/*Query to insert query in db_gps.t_sqlquery table*/
		String abcd=sql1.replace("'","#");
		abcd=abcd.replace(",","$");
		stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
		/*****************************/
		stmt1.executeUpdate(sql1);
		response.sendRedirect("addrivbrfngcmtn.jsp?inserted=successfull&commentfor="+cmntinsrtfor);
		}
		else
		{
			//System.out.println("commtext--->"+commtext);
		sql1="insert into t_briefingcom(commentfor,comment,commenttype)values('"+cmntinsrtfor+"','"+commtext+"','Briefing')";
		/*Query to insert query in db_gps.t_sqlquery table*/
		String abcd=sql1.replace("'","#");
		abcd=abcd.replace(",","$");
		stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
		/*****************************/
		stmt1.executeUpdate(sql1);
		response.sendRedirect("addrivbrfngcmtn.jsp?inserted=successfull&commentfor="+cmntinsrtfor);
		}
		//out.print(sql1);
	}
	

	if(cmntinsrtfor.equals("Serviceable"))
	{
		session.setAttribute("Serviceablecom",commtext);
	}
		
	else if(cmntinsrtfor.equals("tripdata"))
	{
		session.setAttribute("tripdatacom",commtext);
	}
	else if(cmntinsrtfor.equals("PIMC"))
	{
		session.setAttribute("PIMCcom",commtext);
	}
	else if(cmntinsrtfor.equals("reactive"))
	{
		session.setAttribute("reactivecom",commtext);
	}

	else if(cmntinsrtfor.equals("replaced"))
	{
		session.setAttribute("replacedcom",commtext);
	}

	else if(cmntinsrtfor.equals("OtherObs"))
	{
		session.setAttribute("OtherObscom",commtext);
	}
	
	else if(cmntinsrtfor.equals("jrmdb"))
	{
		session.setAttribute("jrmdbcom",commtext);
	}

	else if(cmntinsrtfor.equals("drivearlier"))
	{
		session.setAttribute("drivearliercom",commtext);
	}

	else if(cmntinsrtfor.equals("unsched"))
	{
		session.setAttribute("unschedcom",commtext);
	}

	else if(cmntinsrtfor.equals("routdev"))
	{
		session.setAttribute("routdevcom",commtext);
	}

	else if(cmntinsrtfor.equals("jrmrisk"))
	{
		session.setAttribute("jrmriskcom",commtext);
	}
	
	/////////////////////////////////////
	else if(cmntinsrtfor.equals("zonechangewarning"))
	{
		session.setAttribute("zonechangewarningcom",commtext);
	}
	
	else if(cmntinsrtfor.equals("otherFeedback"))
	{
		session.setAttribute("otherFeedbackcom",commtext);
	}
	
	else if(cmntinsrtfor.equals("JRMinstalled"))
	{
		session.setAttribute("JRMinstalledcom",commtext);
	}
	
	else if(cmntinsrtfor.equals("routeUpload"))
	{
		session.setAttribute("routeUploadcom",commtext);
	}
	////////////////////////////////////
	else if(cmntinsrtfor.equals("vehfit"))
	{
		session.setAttribute("vehfitcom",commtext);
	}

	else if(cmntinsrtfor.equals("briefingremark"))
	{
		session.setAttribute("remarkcom",commtext);
	}
	
	else if(cmntinsrtfor.equals("servicedue"))
	{
		session.setAttribute("serviceduecom",commtext);
	}
	
	else if(cmntinsrtfor.equals("visibledamage"))
	{
		session.setAttribute("visibledamagecom",commtext); 
	}

	else if(cmntinsrtfor.equals("overall"))
	{
		session.setAttribute("overallcom",commtext);
	}

	else if(cmntinsrtfor.equals("driverfit"))
	{
		session.setAttribute("driverfitcom",commtext); 
	}

	else if(cmntinsrtfor.equals("visibleabnorm"))
	{
		session.setAttribute("visabnormcom",commtext);
	}
		
	else if(cmntinsrtfor.equals("drrespons"))
	{
		session.setAttribute("drresponscom",commtext); 
	}

	else if(cmntinsrtfor.equals("drfitothobs"))
	{
		session.setAttribute("drfitothobscom",commtext);
	}
	
	else if(cmntinsrtfor.equals("tripsamedriver"))
	{
		session.setAttribute("tripsamedrivercom",commtext); 
	}
	
	else if(cmntinsrtfor.equals("AllOthrObs"))
	{
		session.setAttribute("AllOthrObscom",commtext);
	}

	else if(cmntinsrtfor.equals("vehiclefamiliarize"))
	{
		session.setAttribute("vehiclefamiliarize",commtext);
	}
	else if(cmntinsrtfor.equals("rdDocuments"))
	{
		session.setAttribute("rdDocumentscomm",commtext);
	}
	else if(cmntinsrtfor.equals("rdlicen"))
	{
		session.setAttribute("rdlicencomm",commtext);
	}
	
	else if(cmntinsrtfor.equals("rdlastTrDet"))
	{
		String traincomm=cmntinsrtfor;
		session.setAttribute("rdlastTrDetcomm",commtext);
	}
else if(cmntinsrtfor.equals("rdTraining"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdTrainingcomm",commtext);
}
else if(cmntinsrtfor.equals("rdStatus"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdStatuscomm",commtext);
}
else if(cmntinsrtfor.equals("rdMedicalChkup"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdMedicalChkupcomm",commtext);
}
else if(cmntinsrtfor.equals("vehiclefamiliarize1"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("vehiclefamiliarizecomm",commtext);
}
else if(cmntinsrtfor.equals("rdtaxpermit"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdtaxpermitcomm",commtext);
}
else if(cmntinsrtfor.equals("rddriven"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rddrivencomm",commtext);
}
else if(cmntinsrtfor.equals("rdhelper"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdhelpercomm",commtext);
}
else if(cmntinsrtfor.equals("vehicl"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("vehiclcomm",commtext);
}
else if(cmntinsrtfor.equals("rdsignldevice"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdsignldevicecomm",commtext);
}
else if(cmntinsrtfor.equals("rdinstrmntpanels"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdinstrmntcomm",commtext);
}
else if(cmntinsrtfor.equals("rdwidescreenmirror"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdwidescrcomm",commtext);
}
else if(cmntinsrtfor.equals("rdtyrepress"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdtyrecomm",commtext);
}
else if(cmntinsrtfor.equals("rdbreaks"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdbreakscomm",commtext);
}
else if(cmntinsrtfor.equals("rdseatbelt"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdseatbeltcomm",commtext);
}
else if(cmntinsrtfor.equals("rdrupd"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdrupdcomm",commtext);

}
else if(cmntinsrtfor.equals("rdSUPD"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdSUPDcomm",commtext);
}
else if(cmntinsrtfor.equals("rdfire"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdfirecomm",commtext);
}
else if(cmntinsrtfor.equals("rdreflector"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdreflectorcomm",commtext);
}
else if(cmntinsrtfor.equals("rdtoolbox"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdtoolboxcomm",commtext);
}
else if(cmntinsrtfor.equals("rdcondveh"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdcondvehcomm",commtext);
}
else if(cmntinsrtfor.equals("rdrootfam"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdrootfamcom",commtext);
}
else if(cmntinsrtfor.equals("rdearlierdriven"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdearldrvcomm",commtext);
}
else if(cmntinsrtfor.equals("rdstopsched"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdschedcomm",commtext);
}
else if(cmntinsrtfor.equals("rdmental"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdmentalcomm",commtext);
}
else if(cmntinsrtfor.equals("rdgenapearance"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdgenappcomm",commtext);
}
else if(cmntinsrtfor.equals("rdvisibleinjury"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdvisiblecomm",commtext);
}
else if(cmntinsrtfor.equals("rdrepetstrech"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdrepetstrechcomm",commtext);
}
else if(cmntinsrtfor.equals("rddrug"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rddrugcomm",commtext);
}
else if(cmntinsrtfor.equals("rdmentalprob"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdmentalprobcom",commtext);
}
else if(cmntinsrtfor.equals("rdadequetsleep"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdadeqcomm",commtext);
}
else if(cmntinsrtfor.equals("rdotherobser"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdotherobscomm",commtext);
}
else if(cmntinsrtfor.equals("rdjrmbrief"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdjrmbriefcomm",commtext);
}
else if(cmntinsrtfor.equals("rdriskunder"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdriskundercom",commtext);
}
else if(cmntinsrtfor.equals("rdAllOthrObs"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdAllOthrObscom",commtext);
}
else if(cmntinsrtfor.equals("rdServiceable"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdServicecom",commtext);
}
else if(cmntinsrtfor.equals("rdReActivated"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdReActivatedcom",commtext);
}
else if(cmntinsrtfor.equals("rdOtherObs"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdOtherObscom",commtext);
}

else if(cmntinsrtfor.equals("rdReplaced"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdReplacedcomm",commtext);
}

else if(cmntinsrtfor.equals("driverreponse"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("driverreponsecomm",commtext);
}
else if(cmntinsrtfor.equals("rdfirstaid"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdfirstaidcomm",commtext);
}
else if(cmntinsrtfor.equals("specinst"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("specinstcomm",commtext);
}
else if(cmntinsrtfor.equals("remark"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("remarkcomm",commtext);
}	
else if(cmntinsrtfor.equals("shortages"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("shortagescomm",commtext);
}
else if(cmntinsrtfor.equals("rtDeviation"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rtDeviationcomm",commtext);
}
else if(cmntinsrtfor.equals("drLicnRd"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("drLicnRdcomm",commtext);
}
else if(cmntinsrtfor.equals("gpsdata"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("gpsdatacomm",commtext);
}

else if(cmntinsrtfor.equals("rdServiceable"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdServiceablecom",commtext);
}
else if(cmntinsrtfor.equals("rdReActivated"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdReActivatedcom",commtext);
}
else if(cmntinsrtfor.equals("rdReplaced"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdReplacedcom",commtext);
}
else if(cmntinsrtfor.equals("rdAllOthrObs"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdAllOthrObscom",commtext);
}
else if(cmntinsrtfor.equals("rdLicn"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdLicncom",commtext);
}
else if(cmntinsrtfor.equals("rdDocuments"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdDocumentscom",commtext);
}
else if(cmntinsrtfor.equals("rdhelpr"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdhelprcom",commtext);
}
else if(cmntinsrtfor.equals("rdSignal"))
{
	String traincomm=cmntinsrtfor;
	session.setAttribute("rdSignalcom",commtext);
}

}	catch(Exception e)
	{
		out.println("Exception----->" +e);	
	}
	finally
	{
	 	con1.close();
	}
%>
