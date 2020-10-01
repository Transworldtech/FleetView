<%@ include file="Connections/conn.jsp" %>
<%!
	Connection con1;
	String sql1="";
%>
<%
	String trpclass="",tripid="",trainerName="",passport="",rdlastTrDet="",rdTraining="",rdStatus="",rdMedicalChkup="";
	String Gpsdata="",rdServiceable="",rdReActivated="",rdReplaced="",rdOtherObs="",vehfamlarzsn="",rdDocuments="",rdlicen="";
	String rdtaxpermit="",rddriven="",rdhelper="",vehcheck="",rdsignldevice="",rdinstrmntpanels="",rdwidescreenmirror="";
	String rdtyrepress="",rdbreaks="",rdseatbelt="",rdrupd="",rdSUPD="",rdfire="",rdreflector="",rdfirstaid="",rdtoolbox="";	
	String rdcondveh="",rdrootfam="",rdearlierdriven="",rdstopsched="",rdmental="",rdgenapearance="",rdvisibleinjury="",rdrepetstrech="";
String 	rddrug="",rdmentalprob="",rdadequetsleep="",rdotherobser="",rdjrmbrief="",rdriskunder="",drvresp="",drvMobNo="",rdAllOthrObs="";
	String remark="",rdPermission="",person="",percGPS="",othperson="",perinsert="",mobno="",remarkcomm="";
	String startplace="",endplace="",enddate1="-",enddate="";
	String feedback="";
	String jrmInstalled="",routeUpload="",vehfit="",servicedue="",visibledamage="",overall="",driverfit="",visibleabnorm="",vehfitcom="";
	String transname="";
	int pos=0,pos1=0,pos2=0,pos3=0,pos4=0;
	String veh = request.getParameter("VehRegNo");
	//System.out.println("==="+veh);
	StringTokenizer stk = new StringTokenizer(veh,",");
	String vehicleRegNumber=stk.nextToken();
	//System.out.println("vehicleRegNumber==="+vehicleRegNumber);
	String vehiclePeripheral=stk.nextToken();
	//String vehicleRegNumber=request.getParameter("VehRegNo");
	String transporter=request.getParameter("transporter");
	String userid=session.getAttribute("user").toString();
	String tripid1=request.getParameter("tripid");
	String drivername="",driverid="";
	try
	{
		drivername=session.getAttribute("drivername").toString();
		driverid=session.getAttribute("driverid").toString();
	}
	catch(Exception e)
	{
		drivername="-";
		driverid="-";
	}
%>
<%
	try
	{ 
		java.util.Date tdydte = new java.util.Date();
		Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String brfdate=formatter.format(tdydte);
		Class.forName(MM_dbConn_DRIVER);
		con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		Statement stmt1=con1.createStatement();      
		Statement stquery=con1.createStatement();
		
		trpclass=request.getParameter("tripClass");
		startplace=request.getParameter("startplace");
		endplace=request.getParameter("endplace");
		feedback=request.getParameter("feedback");
		transname=session.getAttribute("tname").toString();
		String group=session.getValue("usertypevaluemain").toString();
		String reason=request.getParameter("reason");
		//System.out.println(reason);
		String commentForReason=request.getParameter("commentForReason");
		if(reason.equalsIgnoreCase("None"))
		{
		try
		{
			enddate=request.getParameter("data");
			
			enddate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(enddate));
		}
		catch(Exception e)
		{
		        out.print(e);		
		}
		out.print(enddate);
		//out.print(trpclass);
		if(null==trpclass||"null".equalsIgnoreCase("trpclass")||trpclass.equals("Castrol Trip"))
		{
			tripid=request.getParameter("tripid");
			pos=tripid.indexOf("'");
			if(pos>0)
			{
	        		tripid=tripid.replace("'","");
			}
		}
		else
		{
			tripid="NA";
		}
		trainerName=request.getParameter("trainerName");
		Gpsdata=request.getParameter("Gpsdata");
		if(Gpsdata.equals("Yes"))
		{
			percGPS=request.getParameter("percGPS");
			rdServiceable="NA";
			rdReActivated="NA";
			rdReplaced="NA";
			rdOtherObs="NA";
			try
			{
				session.setAttribute("rdServicecom","");
			}
			catch(Exception e)
			{
			}

			try
			{
				session.setAttribute("rdReActivatedcom","");
			}
			catch(Exception e)
			{
			}
			
			try
			{
				session.setAttribute("rdReplacedcomm","");
			}
			catch(Exception e)
			{
			}
			
			try
			{
				session.setAttribute("rdOtherObscom","");
			}
			catch(Exception e)
			{
			}
		}
		else
		{
			percGPS="NA";
			rdServiceable=request.getParameter("rdServiceable");
			rdReActivated=request.getParameter("rdReActivated");
			rdReplaced=request.getParameter("rdReplaced");
			rdOtherObs=request.getParameter("rdOtherObs");
		}
		
		vehfit=request.getParameter("vehfit");
		try
		{
			vehfitcom=session.getAttribute("vehfitcom").toString();
			vehfitcom=vehfitcom.substring(1,vehfitcom.length());
		}
		catch(Exception e)
		{
			vehfitcom="-";
		}

	/*	if(vehfit.equals("No"))
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
		}*/
		
		vehfamlarzsn=request.getParameter("vehfamlarzsn");
		rdDocuments=request.getParameter("rdDocuments");
		if(vehfamlarzsn.equals("Yes"))
		{
			rdlicen="NA";
			rdtaxpermit="NA";
			rddriven="NA";
			rdhelper="NA";
			try
			{
				session.setAttribute("rdlicencomm","");
			}
			catch(Exception e)
			{
				
			}
			try
			{
				session.setAttribute("rdtaxpermitcomm","");
			}
			catch(Exception e)
			{
			}	
			try
			{
				session.setAttribute("rdhelpercomm","");
			}
			catch(Exception e)
			{
			}
			try
			{
				session.setAttribute("rddrivencomm","");
			}
			catch(Exception e)
			{
			}
		}
		else
		{
			rdlicen=request.getParameter("rdlicen");
			rdtaxpermit=request.getParameter("rdtaxpermit");
			rddriven=request.getParameter("rddriven");
			rdhelper=request.getParameter("rdhelper");
		}
		vehcheck=request.getParameter("vehcheck");
		if(vehcheck.equals("No"))
		{
			rdsignldevice="NA";
			rdinstrmntpanels="NA";
			rdwidescreenmirror="NA";
			rdtyrepress="NA";
			rdbreaks="NA";
			rdseatbelt="NA";
			rdrupd="NA";
			rdSUPD="NA";
			rdfire="NA";
			rdfirstaid="NA";
			rdtoolbox="NA";
			rdcondveh="NA";
			rdreflector="NA";
			try
			{
				session.setAttribute("rdsignldevicecomm","");
			}	
			catch(Exception e)
			{
				session.setAttribute("rdinstrmntcomm","");
			}
			try
			{
				session.setAttribute("rdwidescrcomm","");
			}
			catch(Exception e)
			{
			}
			try
			{
				session.setAttribute("rdtyrecomm","");
			}
			catch(Exception e)
			{
			}
			try
			{
				session.setAttribute("rdbreakscomm","");
			}
			catch(Exception e)
			{
			}
			try
			{
				session.setAttribute("rdseatbeltcomm","");
			}
			catch(Exception e)
			{
			}
			try
			{
				session.setAttribute("rdrupdcomm","");
			}
			catch(Exception e)
			{
			}

			try
			{
				session.setAttribute("rdSUPDcomm","");
			}
			catch(Exception e)
			{
			}

			try
			{
				session.setAttribute("rdfirecomm","");
			}
			catch(Exception e)
			{
			}

			try
			{
				session.setAttribute("rdfirstaidcomm","");
			}
			catch(Exception e)
			{
			}
			try
			{
				session.setAttribute("rdtoolboxcomm","");
			}
			catch(Exception e)
			{
			}

			try
			{
				session.setAttribute("rdreflectorcomm","");
			}
			catch(Exception e)
			{
			}

		}
		else
		{
			rdsignldevice=request.getParameter("rdsignldevice");
			rdinstrmntpanels=request.getParameter("rdinstrmntpanels");
			rdwidescreenmirror=request.getParameter("rdwidescreenmirror");
			rdtyrepress=request.getParameter("rdtyrepress");
			rdbreaks=request.getParameter("rdbreaks");
			rdseatbelt=request.getParameter("rdseatbelt");		
			rdrupd=request.getParameter("rdrupd");
			rdSUPD=request.getParameter("rdSUPD");
			rdfire=request.getParameter("rdfire");
			rdreflector=request.getParameter("rdreflector");
			rdfirstaid=request.getParameter("rdfirstaid");
			rdtoolbox=request.getParameter("rdtoolbox");
			rdcondveh=request.getParameter("rdcondveh");
		}
		rdrootfam=request.getParameter("rdrootfam");
		if(rdrootfam.equals("Yes"))
		{
			rdearlierdriven="NA";
			rdstopsched="NA";
			try
			{	
				session.setAttribute("rdschedcomm","");
				
			}
			catch(Exception e)
			{
				
			}
			try
			{
				session.setAttribute("rdearldrvcomm","");
			}
			catch(Exception e)
			{
			}
				
		}
		else
		{
			rdearlierdriven=request.getParameter("rdearlierdriven");
			rdstopsched=request.getParameter("rdstopsched");
		}
		rdmental=request.getParameter("rdmental");
		if(rdmental.equals("Yes"))
		{
			rdgenapearance="NA";
			rdvisibleinjury="NA";		
			rdrepetstrech="NA";
			rddrug="NA";
			rdmentalprob="NA";
			rdadequetsleep="NA";
			rdotherobser="NA";
			try
			{
				session.setAttribute("rdgenappcomm","");
				
			}
			catch(Exception e)
			{
				
			}
			try
			{
				session.setAttribute("rdvisiblecomm","");
			}
			catch(Exception e)
			{
			}
			
			try
			{
				session.setAttribute("rdrepetstrechcomm","");
			}
			catch(Exception e)
			{
			}
			
			try
			{
				session.setAttribute("rddrugcomm","");
			}
			catch(Exception e)
			{
			}
			
			try
			{
				session.setAttribute("rdmentalprobcom","");
			}
			catch(Exception e)
			{
			}
			
			try
			{
				session.setAttribute("rdotherobscomm","");
			}
			catch(Exception e)
			{
			}
			try
			{
				session.setAttribute("rdadeqcomm","");
			}
			catch(Exception e)
			{
			}
		}
		else
		{
			rdgenapearance=request.getParameter("rdgenapearance");
			rdvisibleinjury=request.getParameter("rdvisibleinjury");
			rdrepetstrech=request.getParameter("rdrepetstrech");
			rddrug=request.getParameter("rddrug");
			rdmentalprob=request.getParameter("rdmentalprob");
			rdadequetsleep=request.getParameter("rdadequetsleep");
			rdotherobser=request.getParameter("rdotherobser");
		}
		rdjrmbrief=request.getParameter("rdjrmbrief");
		if(rdjrmbrief == null || rdjrmbrief.equals("null"))
		{
			rdjrmbrief = "No";
		}
		
		if(rdmental.equals("No"))
		{
			rdriskunder="NA";
			try
			{
				session.setAttribute("rdriskundercom","");
			}
			catch(Exception e)
			{
				
			}
			
		}
		else
		{
			rdriskunder=request.getParameter("rdriskunder");
		}
		///////////////////////////////////////////////////////////////
		
		if(rdmental.equals("No"))
		{
			jrmInstalled="NA";
			try
			{
				session.setAttribute("JRMinstalledcom","");
			}
			catch(Exception e)
			{
				
			}
			
		}
		else
		{
			jrmInstalled=request.getParameter("JRMinstalled");
		}
			
		
		if(rdmental.equals("No"))
		{
			routeUpload="NA";
			try
			{
				session.setAttribute("routeUploadcom","");
			}
			catch(Exception e)
			{
				
			}
			
		}
		else
		{
			routeUpload=request.getParameter("routeUpload");
		}
		///////////////////////////////////////////////////////////////

		
		drvresp=request.getParameter("drvresp");
		pos1=drvresp.indexOf("'");
		if(pos1>0)
		{
		        drvresp=drvresp.replace("'","");
		}
		//mobno=request.getParameter("mobno");
		
		//if(mobno.equals("Yes"))
		//{
			drvMobNo=request.getParameter("drvMobNo");
			pos2=drvMobNo.indexOf("'");
			if(pos2>0)
			{
		     	   drvMobNo=drvMobNo.replace("'","");
			}
		//}
		//else
		//{
			//drvMobNo="NA";
		//}
		rdAllOthrObs=request.getParameter("rdAllOthrObs");
		if(rdAllOthrObs.equals("No"))
		{
			try
			{
				session.setAttribute("rdAllOthrObscom","");
			}
			catch(Exception e)
			{
				
			}
		}
		remark=request.getParameter("Rem");
		
		if(remark.equals("No"))
		{
			try
			{
				session.setAttribute("remarkcom","");
			}
			catch(Exception e)
			{
				
			}
		}
		//remark=request.getParameter("Remark");
		String mode=request.getParameter("mode");
		String pimc=request.getParameter("pimc");
		
		rdPermission=request.getParameter("rdPermission");
		//person=request.getParameter("permission");
		othperson=request.getParameter("othperson");
		String sql6="insert into t_permissionby (Name) values ('"+othperson+"')";
		
		/*Query to insert query in db_gps.t_sqlquery table*/
		String abcd=sql6.replace("'","#");
		abcd=abcd.replace(",","$");
		stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
		/*****************************/
		
		stmt1.executeUpdate(sql6);
		
		

	String traincomm="",vehiclefamiliarize="";
	String rdDocumentscomm="",rdlicencomm="",rdpassportcomm="",rdlastTrDetcomm="";
	String rdTrainingcomm="",rdStatuscomm="",rdMedicalChkupcomm="",vehiclefamiliarizecomm="",rdtaxpermitcomm="",rddrivencomm="";
	String rdhelpercomm="",vehiclcomm="",rdsignldevicecomm="",rdinstrmntcomm="",rdwidescrcomm="",rdtyrecomm="",rdbreakscomm="";
	String rdseatbeltcomm="",rdrupdcomm="",rdSUPDcomm="",rdfirecomm="",rdreflectorcomm="",rdtoolboxcomm="";
	String rdcondvehcomm="",rdrootfamcom="",rdearldrvcomm="",rdschedcomm="",rdmentalcomm="",rdgenappcomm="",rdvisiblecomm="";
	String rdrepetstrechcomm="",rddrugcomm="",rdmentalprobcom="",rdadeqcomm="",rdotherobscomm="",rdjrmbriefcomm="",rdriskundercom="",jrmInstalledcom="",routeUploadcom="";
	String rdAllOthrObscom="",rdServicecom="",rdReActivatedcom="",rdReplacedcomm="",rdOtherObscom="",rdfirstaidcomm="";
	String pimccomm="";
	
	try
	{
		traincomm=session.getAttribute("traincomm").toString();
		traincomm=traincomm.substring(1,traincomm.length());
	}
	catch(Exception e)
	{
		traincomm="-";
	}
	try
	{
		pimccomm=session.getAttribute("PIMCcom").toString();
		pimccomm=pimccomm.substring(1,pimccomm.length());
	}
	catch(Exception e)
	{
		pimccomm="-";
	}
	
	try
	{
		vehiclefamiliarize=session.getAttribute("vehiclefamiliarize").toString();
		vehiclefamiliarize=vehiclefamiliarize.substring(1,vehiclefamiliarize.length());
	}
	catch(Exception e)
	{
		vehiclefamiliarize="-";
	}	
	try
	{
		rdDocumentscomm=session.getAttribute("rdDocumentscomm").toString();
		rdDocumentscomm=rdDocumentscomm.substring(1,rdDocumentscomm.length());
	}
	catch(Exception e)
	{
		rdDocumentscomm="-";
	}
	try
	{
		rdlicencomm=session.getAttribute("rdlicencomm").toString();
		rdlicencomm=rdlicencomm.substring(1,rdlicencomm.length());
	}
	catch(Exception e)
	{
		rdlicencomm="-";
	}
	
	try
	{
		rdpassportcomm=session.getAttribute("rdpassportcomm").toString();
		rdpassportcomm=rdpassportcomm.substring(1,rdpassportcomm.length());
	}
	catch(Exception e)
	{
		rdpassportcomm="-";
	}
	try
	{
		rdlastTrDetcomm=session.getAttribute("rdlastTrDetcomm").toString();
		rdlastTrDetcomm=rdlastTrDetcomm.substring(1,rdlastTrDetcomm.length());
	}
	catch(Exception e)
	{
		rdlastTrDetcomm="-";
	}
	try
	{
		rdTrainingcomm=session.getAttribute("rdTrainingcomm").toString();
		rdTrainingcomm=rdTrainingcomm.substring(1,rdTrainingcomm.length());
	}
	catch(Exception e)
	{
		rdTrainingcomm="-";
	}
	try
	{
		rdStatuscomm=session.getAttribute("rdStatuscomm").toString();
		rdStatuscomm=rdStatuscomm.substring(1,rdStatuscomm.length());
	}
	catch(Exception e)
	{
		rdStatuscomm="-";
	}
	try
	{
		rdMedicalChkupcomm=session.getAttribute("rdMedicalChkupcomm").toString();
		rdMedicalChkupcomm=rdMedicalChkupcomm.substring(1,rdMedicalChkupcomm.length());
	}
	catch(Exception e)
	{
		rdMedicalChkupcomm="-";
	}
	try
	{
		vehiclefamiliarizecomm=session.getAttribute("vehiclefamiliarizecomm").toString();
		vehiclefamiliarizecomm=vehiclefamiliarizecomm.substring(1,vehiclefamiliarizecomm.length());
	}
	catch(Exception e)
	{
		vehiclefamiliarizecomm="-";
	}
	try
	{
		rdtaxpermitcomm=session.getAttribute("rdtaxpermitcomm").toString();
		rdtaxpermitcomm=rdtaxpermitcomm.substring(1,rdtaxpermitcomm.length());
	}
	catch(Exception e)
	{
		rdtaxpermitcomm="-";
	}
	try
	{
		rddrivencomm=session.getAttribute("rddrivencomm").toString();
		rddrivencomm=rddrivencomm.substring(1,rddrivencomm.length());
	}
	catch(Exception e)
	{
		rddrivencomm="-";
	}
	try
	{
		rdhelpercomm=session.getAttribute("rdhelpercomm").toString();
		rdhelpercomm=rdhelpercomm.substring(1,rdhelpercomm.length());
	}
	catch(Exception e)
	{
		rdhelpercomm="-";
	}
	try
	{
		vehiclcomm=session.getAttribute("vehiclcomm").toString();
		vehiclcomm=vehiclcomm.substring(1,vehiclcomm.length());
	}
	catch(Exception e)
	{
		vehiclcomm="-";
	}
	try
	{
		rdsignldevicecomm=session.getAttribute("rdsignldevicecomm").toString();
		rdsignldevicecomm=rdsignldevicecomm.substring(1,rdsignldevicecomm.length());
	}
	catch(Exception e)
	{
		rdsignldevicecomm="-";
	}
	try
	{
		rdinstrmntcomm=session.getAttribute("rdinstrmntcomm").toString();
		rdinstrmntcomm=rdinstrmntcomm.substring(1,rdinstrmntcomm.length());
	}
	catch(Exception e)
	{
		rdinstrmntcomm="-";
	}
	try
	{
		rdwidescrcomm=session.getAttribute("rdwidescrcomm").toString();
		rdwidescrcomm=rdwidescrcomm.substring(1,rdwidescrcomm.length());
	}
	catch(Exception e)
	{
		rdwidescrcomm="-";
	}
	try
	{
		rdtyrecomm=session.getAttribute("rdtyrecomm").toString();
		rdtyrecomm=rdtyrecomm.substring(1,rdtyrecomm.length());
	}
	catch(Exception e)
	{
		rdtyrecomm="-";
	}
	try
	{
		rdbreakscomm=session.getAttribute("rdbreakscomm").toString();
		rdbreakscomm=rdbreakscomm.substring(1,rdbreakscomm.length());
	}
	catch(Exception e)
	{
		rdbreakscomm="-";
	}
	try
	{
		rdseatbeltcomm=session.getAttribute("rdseatbeltcomm").toString();
		rdseatbeltcomm=rdseatbeltcomm.substring(1,rdseatbeltcomm.length());
	}
	catch(Exception e)
	{
		rdseatbeltcomm="-";
	}
	try
	{
		rdrupdcomm=session.getAttribute("rdrupdcomm").toString();
		rdrupdcomm=rdrupdcomm.substring(1,rdrupdcomm.length());
	}
	catch(Exception e)
	{
		rdrupdcomm="-";
	}
	try
	{
		rdSUPDcomm=session.getAttribute("rdSUPDcomm").toString();
		rdSUPDcomm=rdSUPDcomm.substring(1,rdSUPDcomm.length());
	}
	catch(Exception e)
	{
		rdSUPDcomm="-";
	}
	try
	{
		rdfirecomm=session.getAttribute("rdfirecomm").toString();
		rdfirecomm=rdfirecomm.substring(1,rdfirecomm.length());

	}
	catch(Exception e)
	{
		rdfirecomm="-";
	}
	try
	{
		rdreflectorcomm=session.getAttribute("rdreflectorcomm").toString();
		rdreflectorcomm=rdreflectorcomm.substring(1,rdreflectorcomm.length());
	}
	catch(Exception e)
	{
		rdreflectorcomm="-";
	}
	
	try
	{
		rdtoolboxcomm=session.getAttribute("rdtoolboxcomm").toString();
		rdtoolboxcomm=rdtoolboxcomm.substring(1,rdtoolboxcomm.length());
	}
	catch(Exception e)
	{
		rdtoolboxcomm="-";
	}
	try
	{
		rdcondvehcomm=session.getAttribute("rdcondvehcomm").toString();
		rdcondvehcomm=rdcondvehcomm.substring(1,rdcondvehcomm.length());
	}
	catch(Exception e)
	{
		rdcondvehcomm="-";
	}
	try
	{
		rdrootfamcom=session.getAttribute("rdrootfamcom").toString();
		rdrootfamcom=rdrootfamcom.substring(1,rdrootfamcom.length());
	}
	catch(Exception e)
	{
		rdrootfamcom="-";
	}
	try
	{
		rdearldrvcomm=session.getAttribute("rdearldrvcomm").toString();
		rdearldrvcomm=rdearldrvcomm.substring(1,rdearldrvcomm.length());
	}
	catch(Exception e)
	{
		rdearldrvcomm="-";
	}
	try
	{
		rdschedcomm=session.getAttribute("rdschedcomm").toString();
		rdschedcomm=rdschedcomm.substring(1,rdschedcomm.length());
	}
	catch(Exception e)
	{
		rdschedcomm="-";
	}
	try
	{
		rdmentalcomm=session.getAttribute("rdmentalcomm").toString();
		rdmentalcomm=rdmentalcomm.substring(1,rdmentalcomm.length());
	}
	catch(Exception e)
	{
		rdmentalcomm="-";
	}
	try
	{
		rdgenappcomm=session.getAttribute("rdgenappcomm").toString();
		rdgenappcomm=rdgenappcomm.substring(1,rdgenappcomm.length());
	}
	catch(Exception e)
	{
		rdgenappcomm="-";
	}
	try
	{
		rdvisiblecomm=session.getAttribute("rdvisiblecomm").toString();
		rdvisiblecomm=rdvisiblecomm.substring(1,rdvisiblecomm.length());
	}
	catch(Exception e)
	{
		rdvisiblecomm="-";
	}
	try
	{
		rdrepetstrechcomm=session.getAttribute("rdrepetstrechcomm").toString();
		rdrepetstrechcomm=rdrepetstrechcomm.substring(1,rdrepetstrechcomm.length());
	}
	catch(Exception e)
	{
		rdrepetstrechcomm="-";
	}
	try
	{
		rddrugcomm=session.getAttribute("rddrugcomm").toString();
		rddrugcomm=rddrugcomm.substring(1,rddrugcomm.length());
	}
	catch(Exception e)
	{
		rddrugcomm="-";
	}
	try
	{
		rdmentalprobcom=session.getAttribute("rdmentalprobcom").toString();
		rdmentalprobcom=rdmentalprobcom.substring(1,rdmentalprobcom.length());
	}
	catch(Exception e)
	{
		rdmentalprobcom="-";
	}
	try
	{
		rdadeqcomm=session.getAttribute("rdadeqcomm").toString();
		rdadeqcomm=rdadeqcomm.substring(1,rdadeqcomm.length());
	}
	catch(Exception e)
	{
		rdadeqcomm="-";
	}
	try
	{
		rdotherobscomm=session.getAttribute("rdotherobscomm").toString();
		rdotherobscomm=rdotherobscomm.substring(1,rdotherobscomm.length());
	}
	catch(Exception e)
	{
		rdotherobscomm="-";
	}
	try
	{
		rdjrmbriefcomm=session.getAttribute("rdjrmbrief").toString();
		rdjrmbriefcomm=rdjrmbriefcomm.substring(1,rdjrmbriefcomm.length());
	}
	catch(Exception e)
	{
		rdjrmbriefcomm="-";
	}
	try
	{
		rdriskundercom=session.getAttribute("rdriskundercom").toString();
		rdriskundercom=rdriskundercom.substring(1,rdriskundercom.length());
	}
	catch(Exception e)
	{
		rdriskundercom="-";
	}
	/////////////////////////////////////////////////////
	try
	{
		jrmInstalledcom=session.getAttribute("JRMinstalledcom").toString();
		jrmInstalledcom=jrmInstalledcom.substring(1,jrmInstalledcom.length());
	}
	catch(Exception e)
	{
		jrmInstalledcom="-";
	}
	
	try
	{
		routeUploadcom=session.getAttribute("routeUploadcom").toString();
		routeUploadcom=routeUploadcom.substring(1,routeUploadcom.length());
	}
	catch(Exception e)
	{
		routeUploadcom="-";
	}
	///////////////////////////////////////////////////
	
	try
	{
		rdAllOthrObscom=session.getAttribute("rdAllOthrObscom").toString();
		rdAllOthrObscom=rdAllOthrObscom.substring(1,rdAllOthrObscom.length());
	}
	catch(Exception e)
	{
		rdAllOthrObscom="-";
	}
	try
	{
		rdServicecom=session.getAttribute("rdServicecom").toString();	
		rdServicecom=rdServicecom.substring(1,rdServicecom.length());
	}
	catch(Exception e)
	{
		rdServicecom="-";
	}
	try
	{
		rdReActivatedcom=session.getAttribute("rdReActivatedcom").toString();
		rdReActivatedcom=rdReActivatedcom.substring(1,rdReActivatedcom.length());
	}
	catch(Exception e)
	{
		rdReActivatedcom="-";
	}
	
	try
	{
		rdOtherObscom=session.getAttribute("rdOtherObscom").toString();
		rdOtherObscom=rdOtherObscom.substring(1,rdOtherObscom.length());
	}
	catch(Exception e)
	{
		rdOtherObscom="-";
	}
	
	try
	{
		rdReplacedcomm=session.getAttribute("rdReplacedcomm").toString();
		rdReplacedcomm=rdReplacedcomm.substring(1,rdReplacedcomm.length());
	}
	catch(Exception e)
	{
		rdReplacedcomm="-";
	}
	
	try
	{
		rdfirstaidcomm=session.getAttribute("rdfirstaidcomm").toString();
		rdfirstaidcomm=rdfirstaidcomm.substring(1,rdfirstaidcomm.length());
	}
	catch(Exception e)
	{
		rdfirstaidcomm="-";
	}
	try
	{
		remarkcomm=session.getAttribute("remarkcom").toString();
		remarkcomm=remarkcomm.substring(1,remarkcomm.length());
	}
	catch(Exception e)
	{
		remarkcomm="-";
	}
	int fdname=0;

	try{
		sql1="insert into t_briefing (Briefid,DriverName,Driverid,VehRegNo,brifdate,brifstatus,Debrifstatus,TrainerName,tripclass,tripid,gpsdata ,gpscaptured ,GpsService ,GpsServicecomm ,GpsReact ,GpsReactcomm ,gpsreplace ,gpsreplacecomm ,gpasobs ,gpasobscomm ,vehfami ,vehfamicomm ,vehdoc,vehdoccomm,vehdrivlicen ,vehdrivlicencomm ,vehdrivearlier ,vehdrivearliercomm ,vehhelp ,vehhelpcomm ,vehcheck ,vehcheckcomm ,vehchecklight ,vehchecklightcomm ,vehcheckInstru ,vehcheckinstrucomm ,vehcheckwide ,vehcheckwidecomm ,vehchecktyre ,vehchecktyrecomm ,vehcheckBreak ,vehcheckBreakcomm ,vehcheckSeatBelt ,vehcheckSeatcomm ,vehcheckRUPD ,vehcheckRUPDcomm ,vehcheckSUPD ,vehcheckSUPDcomm ,vehcheckfire ,vehcheckfirecomm ,vehcheckreflect ,vehcheckreflectcomm ,vehcheckFAK ,vehcheckFAKcomm ,vehchecktool ,vehchecktoolcomm ,vcheckovralcond ,vcheckoveralcondcomm ,RootFam ,RootFamcomm ,RFdrivearli ,RFdrivearlicomm ,RFSchestop ,RFSchestopcomm ,Mentalcond ,Mentalcomm ,mentgenapp ,mentgenappcomm ,Mentenjury ,Mentenjurycomm ,MentStrech ,MentStrechcomm ,Mentmedi ,Mentmedicomm ,Mentresp ,Mentrespcomm ,mentsleep ,mentsleepcomm ,mentothobs ,mentothobscomm ,JRM ,JRMComm ,JRMrisk ,JRMriskcomm ,JRMInstalled,JRMInstalledcom,routeUpload,routeUploadcom,Drivresp ,DrivMobNo ,OthObs ,OthObscomm ,Remark ,remarkcom,GrantPerm ,GrantPermByperson,startplace,endplace,pimc,pimccomm,vehFit,vehfitcom,mode,probenddate,Transporter,FeedBack,TicketStatus,GPNAME)values('"+fdname+"','"+drivername+"','"+driverid+"','"+vehicleRegNumber+"','"+brfdate+"','briefed','not debriefed','"+trainerName+"','"+trpclass+"','"+tripid+"','"+Gpsdata+"','"+percGPS+"','"+rdServiceable+"','"+rdServicecom+"','"+rdReActivated+"','"+rdReActivatedcom+"','"+rdReplaced+"','"+rdReplacedcomm+"','"+rdOtherObs+"','"+rdOtherObscom+"','"+vehfamlarzsn+"','"+vehiclefamiliarizecomm+"','"+rdDocuments+"','"+rdDocumentscomm+"','"+rdlicen+"','"+rdlicencomm+"','"+rddriven+"','"+rddrivencomm+"','"+rdhelper+"','"+rdhelpercomm+"','"+vehcheck+"','"+vehiclcomm+"','"+rdsignldevice+"','"+rdsignldevicecomm+"','"+rdinstrmntpanels+"','"+rdinstrmntcomm+"','"+rdwidescreenmirror+"','"+rdwidescrcomm+"','"+rdtyrepress+"','"+rdtyrecomm+"','"+rdbreaks+"','"+rdbreakscomm+"','"+rdseatbelt+"','"+rdseatbeltcomm+"','"+rdrupd+"','"+rdrupdcomm+"','"+rdSUPD+"','"+rdSUPDcomm+"','"+rdfire+"','"+rdfirecomm+"','"+rdreflector+"','"+rdreflectorcomm+"','"+rdfirstaid+"','"+rdfirstaidcomm+"','"+rdtoolbox+"','"+rdtoolboxcomm+"','"+rdcondveh+"','"+rdcondvehcomm+"','"+rdrootfam+"','"+rdrootfamcom+"','"+rdearlierdriven+"','"+rdearldrvcomm+"','"+rdstopsched+"','"+rdschedcomm+"','"+rdmental+"','"+rdmentalcomm+"','"+rdgenapearance+"','"+rdgenappcomm+"','"+rdvisibleinjury+"','"+rdvisiblecomm+"','"+rdrepetstrech+"','"+rdrepetstrechcomm+"','"+rddrug+"','"+rddrugcomm+"','"+rdmentalprob+"','"+rdmentalprobcom+"','"+rdadequetsleep+"','"+rdadeqcomm+"','"+rdotherobser+"','"+rdotherobscomm+"','"+rdjrmbrief+"','"+rdjrmbriefcomm+"','"+rdriskunder+"','"+rdriskundercom+"','"+jrmInstalled+"','"+jrmInstalledcom+"','"+routeUpload+"','"+routeUploadcom+"','"+drvresp+"','"+drvMobNo+"','"+rdAllOthrObs+"','"+rdAllOthrObscom+"','"+remark+"','"+remarkcomm+"','"+rdPermission+"','"+othperson+"','"+startplace+"','"+endplace+"','"+pimc+"','"+pimccomm+"','"+vehfit+"','"+vehfitcom+"','"+mode+"','"+enddate1+"','"+transname+"','"+feedback+"','Open','"+group+"')";
		/*Query to insert query in db_gps.t_sqlquery table*/
		String abcd1=sql1.replace("'","#");
		abcd1=abcd1.replace(",","$");
		stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
	int ins=0;	/*****************************/
ins=stmt1.executeUpdate(sql1);
	if(ins>=1){
		String sql2="select Briefid as fdname from t_briefing where driverid='"+driverid+"' order by brifdate desc limit 1 ";
//		System.out.println(sql2);
		ResultSet rs2=stmt1.executeQuery(sql2);
		if(rs2.next()){
			fdname=rs2.getInt("fdname");
		}
		
		
		session.setAttribute("rdfirstaidcomm","");
		session.setAttribute("rdReplacedcomm","");
		session.setAttribute("rdOtherObscom","");
		session.setAttribute("rdReActivatedcom","");
		session.setAttribute("rdServicecom","");
		session.setAttribute("rdAllOthrObscom","");
		session.setAttribute("rdriskundercom","");
		session.setAttribute("rdjrmbriefcomm","");
		session.setAttribute("rdotherobscomm","");
		session.setAttribute("rdReActivatedcom","");
		session.setAttribute("rdadeqcomm","");
		session.setAttribute("rdmentalprobcom","");
		session.setAttribute("rddrugcomm","");
		session.setAttribute("rdrepetstrechcomm","");
		session.setAttribute("rdvisiblecomm","");
		session.setAttribute("rdgenappcomm","");
		session.setAttribute("rdmentalcomm","");
		session.setAttribute("rdschedcomm","");
		session.setAttribute("rdearldrvcomm","");
		session.setAttribute("rdrootfamcom","");
		session.setAttribute("rdcondvehcomm","");
		session.setAttribute("rdtoolboxcomm","");
		session.setAttribute("rdreflectorcomm","");
		session.setAttribute("rdfirecomm","");
		session.setAttribute("rdSUPDcomm","");
		session.setAttribute("rdrupdcomm","");
		session.setAttribute("rdseatbeltcomm","");
		session.setAttribute("rdbreakscomm","");
		session.setAttribute("rdtyrecomm","");
		session.setAttribute("rdwidescrcomm","");
		session.setAttribute("rdinstrmntcomm","");
		session.setAttribute("rdsignldevicecomm","");
		session.setAttribute("vehiclcomm","");
		session.setAttribute("rdhelpercomm","");
		session.setAttribute("rddrivencomm","");
		session.setAttribute("rdtaxpermitcomm","");
		session.setAttribute("vehiclefamiliarizecomm","");
		session.setAttribute("rdMedicalChkupcomm","");
		session.setAttribute("rdStatuscomm","");
		session.setAttribute("rdTrainingcomm","");
		session.setAttribute("rdlastTrDetcomm","");
		session.setAttribute("rdpassportcomm","");
		session.setAttribute("rdlicencomm","");
		session.setAttribute("rdDocumentscomm","");
		session.setAttribute("vehiclefamiliarize","");
		session.setAttribute("remarkcom","");

		//session.setAttribute("rdMedicalChkupcomm","");
		//session.setAttribute("rdStatuscomm","");

		response.sendRedirect("driver_briefing.jsp?inserted=successfull&drivername="+drivername+"&briefId="+fdname+"");
	//	System.out.println("*****inserted--");
		}
	else
		response.sendRedirect("alert.jsp?fromPage=Brief");
	}
	catch(Exception e){
		response.sendRedirect("alert.jsp?fromPage=Brief");
		e.printStackTrace();
	}
		//out.print(trpclass);

return;
		}else{
			String sqlForReason="insert into t_reasonOfRejectionForDriver (DriverId,ReasoneForRejection,CommentForRejection,status,transporter,TripID,DriverName,RejectedBy) values ('"+driverid+"','"+reason+"','"+commentForReason+"','yes','"+transporter+"','"+tripid1+"','"+drivername+"','"+userid+"')";
			stmt1.executeUpdate(sqlForReason);	
			//System.out.println("sqlForReason"+sqlForReason);
			response.sendRedirect("driver_briefing.jsp");
		}
	}
	catch(Exception e)
	{
		out.println("Exception----->" +e);	
	}
finally
{
 	con1.close();
}
%>