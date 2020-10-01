
<%@ include file="Connections/conn.jsp" %>
<%!
Connection conn=null;
Statement stnew=null,stnew1=null,st=null,st3=null,st4=null;
String routename="";
String type="";
double lat=0.0,lon=0.0;
double latst=0.0,lonst=0.0;
String startlocn="",endloc="";
String routest="";
double latst1=0.0,lonst1=0.0;
String routest1="",end="",lptype="";
%>
<%
try{	
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
//Class.forName("org.gjt.mm.mysql.Driver");
			//conn= DriverManager.getConnection("jdbc:mysql://203.199.134.130/db_gps","ujjain","u@1jn");
			//conn= DriverManager.getConnection("jdbc:mysql://localhost/db_gps","ujjain","u@1jn");
	        stnew=conn.createStatement();
	        stnew1=conn.createStatement();
	        st=conn.createStatement();
	        st3=conn.createStatement();
	        st4=conn.createStatement();
	        String routename=request.getParameter("routee");
	        String bar="";
			String markerlist="",markerlist1="";
	        System.out.println("In Ajax");
	       System.out.println(routename);
	        int cntmarkerlist=0,cntmarkerlist1=0;
			double apdist=0.0;
			String dist="";
			double latcenter=0.0,loncenter=0.0;
			int zoom=0;
			String kmlloc="";

	    
	    		try{
	    		 		
	    				
	    				String waypt="",phno="",start="";
	    				String name="",TypeName="",phname="";
	    				int TheId=0;
	    				String sqlnew="";
        				String route=routename;
        				
	    				 int count=route.length();
	    				 System.out.println(count);
	    				 
	    				 start = "sdgnbs";
	    				 end = "hsgdnms";
	    				 
	    				 System.out.println("Start--->"+start);
	    				 System.out.println("End--->"+end);
	    				

		    				String sqlc="SELECT * FROM  t_jrmroutemaster  where routename like '"+routename+"' limit 1";
		    				ResultSet rsc=st4.executeQuery(sqlc);
		    		//		System.out.println("sql34n--->"+sqlc);
		    				
		    				
		    				if(rsc.next())
		    				{
		    			//		System.out.println("in if");
		    					routest=rsc.getString("routename");
		    					latcenter=rsc.getDouble("Centerlat");
		    					loncenter=rsc.getDouble("centerlon");
		    					dist=rsc.getString("TotalZoneDist");
		    					zoom=rsc.getInt("zoommap");
		    					//kmlloc=rsc.getString("kmlloc");
		    				}
	    				
	    				String sql34n="SELECT * FROM `jrmallroute` where rname like '"+routename+"' order by trackid Asc limit 1";
	    				ResultSet rsnew=stnew.executeQuery(sql34n);
	    		//		System.out.println("sql34n--->"+sql34n);
	    				int p=1;
	    				if(rsnew.next())
	    				{
	    					routest=rsnew.getString("rname");
	    					latst=rsnew.getDouble("latvalue");
	    					lonst=rsnew.getDouble("lonvalue");
	    					
	    					 int count2=routest.length();
	    			//		 System.out.println(count2);
	    					 
	    					// int b2=routest.indexOf('T');
	    			//		 System.out.println("b"+b2);
	    					 
	    					// startlocn=routest.substring(0,b2);
	    					startlocn = "djfhmjn";
	    					 
	    					 /* Code for show distance*/
	    					 
	    					 
	    					 
	    					
	    			
	    		
	    						
	    				bar ="<table border='0' width='100%'><tr bgcolor=lightgreen width='100%'><th width='35%'><font name=arial size=2px>Route Details</font></th></tr></table> "+
	    				     "<table border='0' width='100%'><tr width='100%'><td colspan=2 width='100%'><font name=arial size=2px > "+start+" To "+end+"</font></td></tr>"+
	    				     "<tr width='100%'><td colspan=2 width='100%'><font size=2px >"+dist+"&nbsp Km</font></td></tr></table>"+
	    				     
	    				     "<table border='0' width='100%'><tr width='50%'><td width='10%'><img src='http://myfleetview.com/FleetView/images/green-dot.png'></img></td><td width='40%'><a href='javascript:myclick("+latst+","+lonst+")' class='bodyText'><font name=arial size=2px>"+start+"</a></font></td></tr></table>";
	    				
	    				}
	    				
    					/*sqlnew="select type,latvalue,lonvalue,waypt,phno from jrmallroute where rname like '%"+routename+"' and type not in('',' ','null') and waypt not in(' ','') ";
 	    				ResultSet rs=st.executeQuery(sqlnew);
 	    				cntmarkerlist1=0;
	    				System.out.println("Sql"+sqlne;
	    				int k=1;
	    				
	    				while(rs.next())
	    				{
	    					cntmarkerlist1++;	
	    					lat=rs.getDouble("latvalue");
	    					lon=rs.getDouble("lonvalue");
	    					waypt=rs.getString("waypt");
	    					//phno=rs.getString("phno");
	    					name=rs.getString("type");
	    					//System.out.println("phno"+phno+"t");
	    					
	    					
	    				//	phname="<img src='http://myfleetview.com/FleetView/images/"+phno+".JPG'></img>";
	    					System.out.println("While called");
	    					bar+="<tr><td><a href='javascript:myclick1("+k+","+lat+","+lon+")' class='bodyText'><font size=2 >"+waypt+"</font></a></td></tr>";
	    					markerlist1+=+lat+"*"+lon+"*"+name+"*"+waypt+"$";
	    		 			k++;
	    				}*/
	    				markerlist=apdist+"$";
	    				String sqlph="select phno,waypt,latvalue,lonvalue from jrmallroute where rname='"+routename+"' and phno not in('-','null')";
	    				ResultSet rstph=st3.executeQuery(sqlph);
	    			//	System.out.println("sqlph"+sqlph);
	    				cntmarkerlist=0;
	    				String waypt2="",phno2="";
	    				double lat2=0.0,lon2=0.0;
	    				while(rstph.next())
	    				{
	    					
	    					cntmarkerlist++;
	    					phno2=rstph.getString("phno");
	    					waypt2=rstph.getString("waypt");
	    					lat2=rstph.getDouble("latvalue");
	    					lon2=rstph.getDouble("lonvalue");
	    					phname="<img src='http://myfleetview.com/FleetView/images/"+phno2+".JPG'></img>";
	    					markerlist+=+lat2+"*"+lon2+"*"+phname+"*"+waypt2+"$";
	    				}
	    				
	    		    }
	    			catch(Exception e)
	    			{
	    				System.out.println("exce"+e);
	    			
	    			}
	    			
	    			
	    			String sql34n1="SELECT * FROM `jrmallroute` where rname like '"+routename+"'order by trackid desc limit 1";
	    			ResultSet rsnew1=stnew1.executeQuery(sql34n1);
	    			
	    			if(rsnew1.next())
	    			{
	    			
	    				routest1=rsnew1.getString("rname");
	    				latst1=rsnew1.getDouble("latvalue");
	    				lonst1=rsnew1.getDouble("lonvalue");
	    			
	    				
	    					
	    			 
	    			   	
	    				 int count=routest1.length();
	    				 				 
	    				 int b=routest1.indexOf('T');
	    				// System.out.println("b"+b);
	    				 
	    			//	 String start=routest1.substring(0,b);
	    			//	b=b+2;
	    				// endloc=routest1.substring(b,count);
	    			String	start = "xmcbhnx";
	    			endloc = "kjds";
	    			bar+="<table border = '0' width='100%'><tr width='50%'><td width='10%'><img src='http://myfleetview.com/FleetView/images/red-dot.png'></img></td><td width='40%'><a href='javascript:myclick("+latst1+","+lonst1+")' class='bodyText'><font name=arial size=2px >"+end+"</font></a></td></tr></table><table border = '0' width='100%'><tr><td width='50%' valign='top'><table border= '0'><tr><td><font name=arial size=2px ><input type='checkbox' name='layer1'  value='ALL' onclick='selectAll();'></td><td> ALL</input></font></td></tr>";
	    			}
	    			
	    			
	    			
	    			String sqlnew="SELECT distinct(type),latvalue,lonvalue FROM `jrmallroute` where rname like '"+routename+"' and type not in(' ','null','-') group by type order by type Asc";
	    	       	   
	       	     ResultSet layerlp=st3.executeQuery(sqlnew);
	       	     System.out.println("new---------->"+sqlnew); 
	       	     int i=1;
	       	     String bgcolor="lightgreen";
	       	   // bar="<a href='javascript:onclick=routedetails();><font size=3 >Route Details</font><a href='javascript:onclick=layer();'> <font size=3 >&nbsp Layers</a></font><table border=0>";
	       	    
	       	     while(layerlp.next())
	       	     {
	       	    	 
	       	    	 lptype=layerlp.getString("type");
	       	    	 lat=layerlp.getDouble("latvalue");
	       	    	 lon=layerlp.getDouble("lonvalue");
	       	    	 
	       	    	  	    	
	       	    	 
	       	    	 
	       	    	//bar+="<tr><td bgcolor='"+bgcolor+"'>"+i+"&nbsp;&nbsp;<a href='javascript:myclick("+i+","+lat+","+lon+")'>"+lptype+"</a></td></tr>";
	       	    	bar+="<tr width='100%'><td width='10%'><font name=arial size=2px ><input type='checkbox' name='layer' id='layer' value='"+lptype+"' 'onclick='layersend();'></td><td width='30%'> "+lptype+"</input></font></tr>";
	       	    	
	       	    	
	       	    		    	// System.out.println("type "+lptype);
	       	    		    	 i++;
	       	    		    	
	       	    		    	 
	       	     }
	    			
	    			bar+="</table></td><td width='50%' valign='top'><table border='0'><tr><td name='abc' id='abc'></td></tr></table></td></tr></table>";
	    			//newbar=side_bar_html;
	    			
	    			
	    			
	    			
	    			
		    		out.print(cntmarkerlist1+"#"+markerlist1+"#"+cntmarkerlist+"#"+markerlist+"#"+bar+"</table>#"+latst+"#"+lonst+"#"+startlocn+"#"+latst1+"#"+lonst1+"#"+endloc+"#"+latcenter+"#"+loncenter+"#"+zoom+"#"+kmlloc);
	    		%>
		        <%     
	        
	   

    	    
}
catch(Exception e)
{
	
	System.out.println("Exec"+e);
	
}

    	   %>  
    	  	
    	 
