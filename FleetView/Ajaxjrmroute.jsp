
<%@ include file="Connections/conn.jsp" %>
<%!
Connection conn=null;
Statement stlp=null,st=null;
%>

<%
try{	
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
//Class.forName("org.gjt.mm.mysql.Driver");
			//conn= DriverManager.getConnection("jdbc:mysql://203.199.134.130/db_gps","ujjain","u@1jn");
	//		conn= DriverManager.getConnection("jdbc:mysql://localhost/db_gps","ujjain","u@1jn");
			//conn= DriverManager.getConnection("jdbc:mysql://203.199.134.130/db_gps","ujjain","u@1jn");
	        stlp=conn.createStatement();
	        st=conn.createStatement();
	
int p=1;
String bar="<form name='f1'><table width='100%'><tr bgcolor=lightgreen><td width=50><a href='javascript:onclick=routedata()';><font name=arial size=2 >Route Details</font></a></td><td width=50><font name=arial size=2 ><b>Layers</b></td></tr></table><table><tr><td><font name=arial size=2px ><input type='checkbox' name='layer1'  value='ALL' onclick='selectAll();'> ALL</input></font></td></tr>";;
String lptype="",markerlist="#";
double lat=0.0,lon=0.0;
String ivalue="";
String routename=request.getParameter("routee");
//System.out.println("Routename in ajax"+routename);
double latcenter=0.0,loncenter=0.0;
int zoom=0;
String sqlc="SELECT * FROM `jrmroutemaster` where routename like '%"+routename+"' limit 1";
ResultSet rsc=st.executeQuery(sqlc);
//System.out.println("sql34n--->"+sqlc);

if(rsc.next())
{
	//System.out.println("in if");
	
	latcenter=rsc.getDouble("centerlat");
	loncenter=rsc.getDouble("centerlon");
	zoom=rsc.getInt("zoommap");
}


    	  String sqlnew="SELECT type,latvalue,lonvalue FROM `jrmallroute` where rname like '%"+routename+"' and type not in(' ','null') group by type order by type Asc";
    	       	   
    	     ResultSet layerlp=stlp.executeQuery(sqlnew);
    	    // System.out.println("new---------->"+sqlnew); 
    	     int i=1;
    	     String bgcolor="lightgreen";
    	   // bar="<a href='javascript:onclick=routedetails();><font size=3 >Route Details</font><a href='javascript:onclick=layer();'> <font size=3 >&nbsp Layers</a></font><table border=0>";
    	    
    	     while(layerlp.next())
    	     {
    	    	 
    	    	 lptype=layerlp.getString("type");
    	    	 lat=layerlp.getDouble("latvalue");
    	    	 lon=layerlp.getDouble("lonvalue");
    	    	 
    	    	  	    	
    	    	 
    	    	 
    	    	//bar+="<tr><td bgcolor='"+bgcolor+"'>"+i+"&nbsp;&nbsp;<a href='javascript:myclick("+i+","+lat+","+lon+")'>"+lptype+"</a></td></tr>";
    	    	bar+="<tr><td><font name=arial size=2px ><input type='checkbox' name='layer' id='layer' value='"+lptype+"' 'onclick='layersend();'> "+lptype+"</input></font><td></tr>";
    	    	
    	    	
    	    		    	// System.out.println("type "+lptype);
    	    		    	 i++;
    	    		    	
    	    		    	 
    	     }
    	     ivalue="<input type='hidden' name='hide' value='"+i+"'>";
    	    
    	 //   System.out.println("Value of count----->"+ivalue);
    	    out.print(lat+"#"+lon+"#"+bar+"</table></form>"+markerlist+"#"+ivalue+"#"+latcenter+"#"+loncenter+"#"+zoom);
    	    
    	 //   System.out.println("markerlist"+markerlist);
    	    //System.out.println("bar"+bar);
    	 //   System.out.println("bar"+bar);
    	    
}
catch(Exception e)
{
	
	//System.out.println("Exec"+e);
	e.printStackTrace();
}

    	   %>  
    	  	
    	 
