<%@ include file="Connections/conn.jsp" %>
<%!
Connection con1;
%>
<%
	String fwUser = (String) session.getAttribute("user");
	String sql1="",sql2="",sql3="";
	String userval=session.getAttribute("usertypevalue").toString();
	boolean flag2=false;
	String Msg=null;
	String lati=request.getParameter("lati");//lat
	String langi=request.getParameter("langi");//long
	String warehouse=request.getParameter("warehouse");//whtype
	String warecode=request.getParameter("warehousecode");//whtype
	String WType=request.getParameter("WType");
	String page1=request.getParameter("fpage");//whtype
	//String geotype=request.getParameter("geotype");
	System.out.println("lati "+lati);
	System.out.println("langi "+langi);
	System.out.println("warehouse "+warehouse);
	System.out.println("warecode "+warecode);
    /*System.out.println("page1 "+page1);*/
	//System.out.println("geotype "+geotype);
	System.out.println("user "+fwUser);
	System.out.println("userval"+userval);
	
	//System.out.println(geotype);
	//String polygonCoordinates=request.getParameter("polygonCoordinates");//polygonCoordinates
	//System.out.println("polygonCoordinates--->"+polygonCoordinates);
	
	String today;
	
    int i=1;
	try 
	{
		//System.out.println("26 Hii");
		today=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	//	String polygonCoordinate = request.getParameter("polygonCoordinates");
		//StringBuffer polygonSql = new StringBuffer("PolygonFromText(POLYGON((" );
	//	StringBuffer polygonSql = new StringBuffer("");

		/*if(polygonCoordinate !=null && !polygonCoordinate.equals(""))
		        {
			       // System.out.println("34 Hii");
		            StringTokenizer tokenizer = new StringTokenizer(polygonCoordinate,",");                        
		            int cntr=1;
		            int tokens = tokenizer.countTokens();
		            while (tokenizer.hasMoreElements()) 
		            {
		            	//System.out.println("40 Hii");
		                String object = (String) tokenizer.nextElement();            
		                if(cntr%2 == 0)
		                {            
		                    polygonSql.append(object +" ");
		                    if(cntr != tokens)
		                        polygonSql.append(",");
		                }
		                else
		                {
		                	//System.out.println("50 Hii");
		                	polygonSql.append(object +" ");
		                }
		                cntr++;
		            }            
		          //  polygonSql.append("))')");

		          //  System.out.println("polygonSql:::"+polygonSql);
		}*/

		String WhCode="-",WhHouse="-";
		Class.forName(MM_dbConn_DRIVER);
		con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		Statement stmt1=con1.createStatement();
		Statement stmt2=con1.createStatement();
		Statement stmt3=con1.createStatement();
		Statement stquery=con1.createStatement();
		ResultSet rs1=null, rs2=null;
		
		if((warecode==null)|| (warecode=="")||(warehouse==null)||(warehouse==""))
		{
			
				response.sendRedirect("geoAddForm.jsp?flag2="+flag2+"&lati="+lati+"&langi="+langi+"&fpage1="+page1);
		}
		else{
			sql2="Select * from t_warehousedata where WareHouseCode='"+warecode+"' and WareHouse= '"+warehouse+"'";
			//System.out.println("83 sql2---->"+sql2); 
			rs1 = stmt2.executeQuery(sql2);
			if(rs1.next())
			{
				//System.out.println("In side while----"); 
				flag2 = false;
						response.sendRedirect("geoAddForm.jsp?flag2="+flag2+"&lati="+lati+"&langi="+langi+"&fpage1="+page1);
			}
			else 
			{
				sql3="Select * from t_warehousedata where WareHouseCode='"+warecode+"' and Owner= '"+fwUser+"'";
				ResultSet rs3=stmt3.executeQuery(sql3);
				if(rs3.next())
				{
					Msg="The code already exist!! Please enter different code.";
					response.sendRedirect("geoAddForm.jsp?Msg="+Msg+"&lati="+lati+"&langi="+langi+"&fpage1="+page1);
				}
				else
				{
				flag2 = true;
				
				/*if(geotype!=null && geotype.equalsIgnoreCase("Point"))
				{*/
					//System.out.println("96 Hii");
					//System.out.println("flag "+flag2);
					sql1="insert into t_warehousedata(WareHouseCode,WareHouse,Owner,Latitude,Longitude,WType,EntBy,UpdatedDate,MarkerType) values ('"+warecode+"','"+warehouse+"','"+userval+"','"+lati+"','"+langi+"','"+WType+"','"+fwUser+"','"+today+"','Point')";
					
					/*Query to insert query in db_gps.t_sqlquery table*/
					String abcd=sql1.replace("'","#");
					abcd=abcd.replace(",","$");
					stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
					/*****************************/
					
					
					stmt1.executeUpdate(sql1);
					response.sendRedirect("geoAddForm.jsp?flag2="+flag2+"&lati="+lati+"&langi="+langi+"&fpage1="+page1);
				/*}
				else if(geotype!=null && geotype.equalsIgnoreCase("Poly"))
					{*/
					//System.out.println("111 Hii");
					//System.out.println("flag "+flag2);
					//sql1="insert into t_warehousedata(WareHouseCode,WareHouse,Owner,Latitude,Longitude,WType,EntBy,UpdatedDate,PolygonCoordinates,MarkerType) values ('"+warecode+"','"+warehouse+"','"+userval+"','"+lati+"','"+langi+"','"+WType+"','"+fwUser+"','"+today+"','"+polygonCoordinate+"','Poly')";
				//	System.out.println("sql1---->"+sql1);
					
					/*Query to insert query in db_gps.t_sqlquery table*/
					/*String abcd=sql1.replace("'","#");
					abcd=abcd.replace(",","$");
					stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");*/
					/*****************************/
					
				/*	stmt1.executeUpdate(sql1);
					response.sendRedirect("getalllatlong1.jsp?flag2="+flag2);
					}	
					else
					{
						response.sendRedirect("getalllatlong1.jsp?flag2=false");
					}*/
				}
				
			}
		}
	} 
	catch(Exception e)
	{
		out.println(e);
		e.printStackTrace();
	}
	finally
	{
		try{
			con1.close();		
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}
%>
