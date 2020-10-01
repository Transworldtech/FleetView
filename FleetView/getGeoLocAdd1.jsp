<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>
<%
	String fwUser = (String) session.getAttribute("user");
	String sql1="",sql2="";
	String userval=session.getAttribute("usertypevalue").toString();
	boolean flag2=false;
	String lati=request.getParameter("lati");//lat
	String langi=request.getParameter("langi");//long
	String warehouse=request.getParameter("warehouse");//whtype
	String warecode=request.getParameter("warehousecode");//whtype
	String WType=request.getParameter("WType");
	String page1=request.getParameter("page");//whtype
	String geotype=request.getParameter("geotype");
	String addgeo=request.getParameter("addgeo");
	//System.out.println("add"+addgeo);
	
	//System.out.println(geotype);
	//String polygonCoordinates=request.getParameter("polygonCoordinates");//polygonCoordinates
	//System.out.println("polygonCoordinates--->"+polygonCoordinates);
	
	String today;
	
    int i=1;
	try 
	{
		today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		String polygonCoordinate = request.getParameter("polygonCoordinates");
		//StringBuffer polygonSql = new StringBuffer("PolygonFromText(POLYGON((" );
		StringBuffer polygonSql = new StringBuffer("");

		if(polygonCoordinate !=null && !polygonCoordinate.equals(""))
		        {
		            StringTokenizer tokenizer = new StringTokenizer(polygonCoordinate,",");                        
		            int cntr=1;
		            int tokens = tokenizer.countTokens();
		            while (tokenizer.hasMoreElements()) 
		            {
		                String object = (String) tokenizer.nextElement();            
		                if(cntr%2 == 0)
		                {            
		                    polygonSql.append(object +" ");
		                    if(cntr != tokens)
		                        polygonSql.append(",");
		                }
		                else
		                    polygonSql.append(object +" ");
		                
		                cntr++;
		            }            
		          //  polygonSql.append("))')");

		           // System.out.println("polygonSql:::"+polygonSql);
		}

		String WhCode="-",WhHouse="-";
		Class.forName(MM_dbConn_DRIVER);
		con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		Statement stmt1=con1.createStatement();
		Statement stmt2=con1.createStatement();
		Statement stquery=con1.createStatement();
		ResultSet rs1=null, rs2=null;
		
		if((warecode==null)|| (warecode=="")||(warehouse==null)||(warehouse==""))
		{
			
				response.sendRedirect("getallatlong2.jsp?flag2="+flag2);
		}
		else{
			sql2="Select * from t_warehousedata where WareHouseCode='"+warecode+"' and WareHouse= '"+warehouse+"'";
			//System.out.println("sql2---->"+sql2); 
			rs1 = stmt2.executeQuery(sql2);
			if(rs1.next())
			{
				//System.out.println("In side while----"); 
				flag2 = false;
						response.sendRedirect("getallatlong2.jsp?flag2="+flag2);
			}
			else 
			{
				flag2 = true;
				
					sql1="insert into t_warehousedata(WareHouseCode,WareHouse,Owner,Latitude,Longitude,WType,EntBy,UpdatedDate,MarkerType) values ('"+warecode+"','"+warehouse+"','Castrol','"+lati+"','"+langi+"','"+WType+"','Castrol','"+today+"','Point')";
					
					/*Query to insert query in db_gps.t_sqlquery table*/
					String abcd=sql1.replace("'","#");
					abcd=abcd.replace(",","$");
					stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
					/*****************************/
					
					stmt1.executeUpdate(sql1);
					if(addgeo.equals("Yes"))
					{
					String sql4="insert into t_waypoints (Name,Discription,Lat,Lon,OwnerName) values ('"+warecode+"','"+warehouse+"','"+lati+"','"+langi+"','castrol')";
					
					/*Query to insert query in db_gps.t_sqlquery table*/
					String abcd1=sql4.replace("'","#");
					abcd1=abcd1.replace(",","$");
					stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd1+"')");
					/*****************************/
					
					stmt2.executeUpdate(sql4);
					}
					response.sendRedirect("getallatlong2.jsp?flag2="+flag2);
			}
		}
	} 
	catch(Exception e)
	{
		out.println(e);
	}
	finally
	{
		con1.close();
	}
%>
