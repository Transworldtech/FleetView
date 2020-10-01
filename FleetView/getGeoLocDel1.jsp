<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
%>
<%
//String fwUser = (String) session.getAttribute("user");
//System.out.println("--user---->>"+fwUser);
	String location=request.getParameter("loc");//warehouse
	String location1=request.getParameter("loc1");//warehouse code
	String oldlocation=request.getParameter("oldloc");//warehouse
	String oldlocation1=request.getParameter("oldloc1");//warehouse code
	String wtype=request.getParameter("wtype");
	String oldwtype=request.getParameter("oldwtype");
	String page1=request.getParameter("page");
	
	String tmpwareHouseCode="-",tmpwareHouse="-",tmpowner="-",tmpwtype="-",tmpTransporter="-",tmplocation=null,tmpentby="-",tmptodaydate="-";
	double tmplat=0.00,tmpSLatitude=0.00,tmpELatitude=0.00,tmpSLongitude=0.00,tmpELongitude=0.00,tmplon=0.00;
	String today;
	//System.out.println("---on update page---");
    int i=1;
	String warehousecode="",warehouse="";
	String sql1="", sql2="",sql4="";
	//String userval=session.getAttribute("usertypevalue").toString();
	//String loginuser=session.getValue("user").toString();
	boolean flag1=false;
	try 
	{
		today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		Class.forName(MM_dbConn_DRIVER);
		con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		Statement stmt1=con1.createStatement();
		Statement stmt2=con1.createStatement();
		Statement stmt4=con1.createStatement();
		Statement stquery=con1.createStatement();
		ResultSet rs1=null, rs2=null;

		if((location==null)||(location=="")||(location1==null)||(location1==""))
		{
			flag1 = false;
				response.sendRedirect("getallatlong2.jsp?flag1="+flag1);
		}	
		else{
			flag1 = true;
			
			//secleting values b4 updating for inserting in history
			sql4="Select * from t_warehousedata where WareHouseCode='"+location1+"' and WareHouse= '"+location+"' and WType='"+wtype+"' and Owner like 'Castrol'";
			//System.out.println("sql4---->"+sql4); 
			rs2 = stmt4.executeQuery(sql4);
			while(rs2.next())
			{
				tmpwareHouseCode=rs2.getString("WareHouseCode");
				tmpwareHouse=rs2.getString("WareHouse");
				tmpowner=rs2.getString("Owner");
				tmpwtype=rs2.getString("WType");
				tmpTransporter=rs2.getString("Transporter");
				tmplat=rs2.getDouble("Latitude");
				tmpSLatitude=rs2.getDouble("SLatitude");
				tmpELatitude=rs2.getDouble("ELatitude");
				tmpSLongitude=rs2.getDouble("SLongitude");
				tmpELongitude=rs2.getDouble("ELongitude");
				tmplon=rs2.getDouble("Longitude");
				tmplocation=rs2.getString("Location");
				tmpentby=rs2.getString("EntBy");
				tmptodaydate=rs2.getString("UpdatedDate");
			}
			sql2="insert into t_warehousedatahistory(WareHouseCode,WareHouse,Owner,Transporter,Latitude,SLatitude,ELatitude,Longitude,SLongitude,ELongitude,WType,Location,EntBy,UpdatedDate) values('"+tmpwareHouseCode+"','"+tmpwareHouse+"','"+tmpowner+"','"+tmpTransporter+"','"+tmplat+"','"+tmpSLatitude+"','"+tmpELatitude+"','"+tmplon+"','"+tmpSLongitude+"','"+tmpELongitude+"','"+tmpwtype+"',"+tmplocation+",'Castrol','"+today+"')";
			
			/*Query to insert query in db_gps.t_sqlquery table*/
			String abcd=sql2.replace("'","#");
			abcd=abcd.replace(",","$");
			stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
			/*****************************/
			
			stmt1.executeUpdate(sql2);
		sql1="delete from t_warehousedata where Owner like 'castrol' and  WareHouse='"+oldlocation+"' and WareHouseCode='"+oldlocation1+"' limit 1";
		
		/*Query to insert query in db_gps.t_sqlquery table*/
		String abcd1=sql1.replace("'","#");
		abcd1=abcd1.replace(",","$");
		stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
		/*****************************/
		
		stmt1.executeUpdate(sql1);
		response.sendRedirect("getallatlong2.jsp?flag1="+flag1);
		}
	
	} catch(Exception e) {out.println(e);}
	
	finally
	{
	con1.close();
	}
	
%>