<%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
%>
<%
String fwUser = (String) session.getAttribute("user");
     System.out.println("--user---->>"+fwUser);
	String location=request.getParameter("loc");
	System.out.println("--user---->>"+location);
	String location1=request.getParameter("loc1");
	System.out.println("--user---->>"+location1);
	//String oldlocation=request.getParameter("oldloc");//warehouse
	//String oldlocation1=request.getParameter("oldloc1");//warehouse code
	String wtype=request.getParameter("wtype");
	System.out.println("--user---->>"+wtype);
	//String oldwtype=request.getParameter("oldwtype");
	String page1=request.getParameter("page");
	
	String tmpwareHouseCode="-",tmpwareHouse="-",tmpowner="-",tmpwtype="-",tmpTransporter="-",tmplocation=null,tmpentby="-",tmptodaydate="-";
	double tmplat=0.00,tmpSLatitude=0.00,tmpELatitude=0.00,tmpSLongitude=0.00,tmpELongitude=0.00,tmplon=0.00;
	String today;
	//System.out.println("---on update page---");
    int i=1;
	String warehousecode="",warehouse="";
	String sql1="", sql2="",sql4="";
	String userval=session.getAttribute("usertypevalue").toString();
	System.out.println("userval---->"+userval);
	String loginuser=session.getValue("user").toString();
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
				response.sendRedirect("geoDeleteForm.jsp?flag1="+flag1+"&loc="+location+"&loc1="+location1+"&wtype="+wtype);
		}	
		else{
			flag1 = true;
			System.out.println("flag value"+flag1);
			//secleting values b4 updating for inserting in history
			sql4="Select * from t_warehousedata where WareHouseCode='"+location1+"' and WareHouse= '"+location+"' and WType='"+wtype+"' and Owner like '"+userval+"'";
			System.out.println("sql4---->"+sql4); 
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
			//sql2="insert into db_gps.t_warehousedatahistory(WareHouseCode,WareHouse,Owner,Transporter,Latitude,SLatitude,ELatitude,Longitude,SLongitude,ELongitude,WType,EntBy,UpdatedDate) values('"+tmpwareHouseCode+"','"+tmpwareHouse+"','"+tmpowner+"','"+tmpTransporter+"','"+tmplat+"','"+tmpSLatitude+"','"+tmpELatitude+"','"+tmplon+"','"+tmpSLongitude+"','"+tmpELongitude+"','"+tmpwtype+"','"+tmpentby+"','"+tmptodaydate+"')";
			sql2="insert into db_gps.t_warehousedatahistory(WareHouseCode,WareHouse,Owner,Transporter,Latitude,SLatitude,ELatitude,Longitude,SLongitude,ELongitude,location,WType,EntBy,UpdatedDate,activestatus) values('"+tmpwareHouseCode+"','"+tmpwareHouse+"','"+tmpowner+"','"+tmpTransporter+"','"+tmplat+"','"+tmpSLatitude+"','"+tmpELatitude+"','"+tmplon+"','"+tmpSLongitude+"','"+tmpELongitude+"','-','"+tmpwtype+"','"+tmpentby+"','"+tmptodaydate+"','No')";
			
			
			System.out.println("sql2---->"+sql2);
			/*Query to insert query in db_gps.t_sqlquery table*/
			String abcd=sql2.replace("'","#");
			abcd=abcd.replace(",","$");
			
			
			stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
			System.out.println(""+stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')"));
			System.out.println("enter---->");
			stmt1.executeUpdate(sql2);
			System.out.println("outer---->");
			
		System.out.println("userval---->"+userval);
		System.out.println("location---->"+location);
		System.out.println("location1---->"+location1);
		
		sql1="delete from db_gps.t_warehousedata where Owner like '"+userval+"' and  WareHouse='"+location+"' and WareHouseCode='"+location1+"' limit 1";
		
		System.out.println("sql1---->"+sql1);
		
		/*Query to insert query in db_gps.t_sqlquery table*/
			String abcd1=sql1.replace("'","#");
			abcd1=abcd1.replace(",","$");
			stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
		/*****************************/
		
		response.sendRedirect("geoDeleteForm.jsp?flag1="+flag1);
		stmt1.executeUpdate(sql1);
		
		
		}
	
	} catch(Exception e) {out.println(e);}
	
	finally
	{
		try{
			con1.close();
		}
		catch(Exception e)
		{
			
		}
	
	}
	
%>

