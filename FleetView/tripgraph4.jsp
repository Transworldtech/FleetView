 <%@ include file="Connections/conn.jsp" %>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/graph.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/wz_jsgraphics.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript1.2" SRC="js/line.js"></SCRIPT>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<%!
	Connection conn;
	Statement st,st1;
	String driverid, cnt,jcode,discription;
	String sql,sql1;
	int oscount,racount,rdcount,distance;
	double rating;
	String date1,date2;
	java.util.Date enddate=new java.util.Date();
	String vehRegNo = "",  tripId = "", ownerName = "", startPlace = "", endPlace = "";
	String formattedDate = "";
	java.util.Date fromDate=new java.util.Date();
	%>
<table border="0" width="100%" align="center">
<tr>
	
		<%
      jcode="('000000',";
		driverid =request.getParameter("driverid");
		cnt=request.getParameter("cnt");
		try {
		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
		st=conn.createStatement();
		st1=conn.createStatement();
		
		NumberFormat nf = DecimalFormat.getNumberInstance();
		nf.setMaximumFractionDigits(2);
		nf.setMinimumFractionDigits(2);	
		nf.setGroupingUsed(false);
		String ratingfrmtd="", ncastratingfrmtd="";
      String sDate = "", eDate = "", stTime = ""  , endTime = "" , vehid = "";
		discription="Last Trip";
		distance=0;
		sql="select * from t_completedjourney where DriverId='"+driverid+"' and JDCode <>'-' order by StartDate desc limit 1";
      ResultSet rst=st.executeQuery(sql);
		if(rst.next())
		{
			jcode=rst.getString("TripId");
			enddate=rst.getDate("Enddate");
         		vehRegNo = rst.getString("VehRegNo");
         		tripId = rst.getString("TripID");
         		ownerName = rst.getString("OwnerName");
         		startPlace = rst.getString("StartPlace");
         		endPlace = rst.getString("EndPlace");
         		vehid= rst.getString("Vehid");
         		sDate = rst.getString("StartDate");
         		eDate = rst.getString("EndDate");
         		distance=rst.getInt("KmTravelled");
         		rating=rst.getDouble("TripRating");
			ratingfrmtd=nf.format(rating);
         		if(sDate.length() > 11){
         		stTime =  sDate.substring(11,19) ;
         	}
        	else
		{
	        	stTime = "00:00:00" ;
        	}
        	if(eDate.length() > 11)
		{
	        	endTime = eDate.substring(11,19) ;
	        }
		else
		{
        		endTime = "23:59:59";
        	}
        }
 		oscount=0;
		racount=0;
		rdcount=0;
		rating=0.0;
 		sql1="select count(*) as OS from t_trip_overspeed where Jcode='"+jcode+"'";
 		ResultSet rstos=st1.executeQuery(sql1);
 		if(rstos.next())
 		{
 			oscount=rstos.getInt("OS");
 		}
 		sql1="select count(*) as RA from t_trip_ra where Jcode='"+jcode+"'";
 		ResultSet rstra=st1.executeQuery(sql1);
 		if(rstra.next())
 		{
 			racount=rstra.getInt("RA");
 		}
 		sql1="select count(*) as RD from t_trip_rd where Jcode='"+jcode+"'";
 		ResultSet rstrd=st1.executeQuery(sql1);
 		if(rstrd.next())
 		{
 			rdcount=rstrd.getInt("RD");
 		}
		if(true){
		%>                        
		
<td colspan="2">
<%
}
       
                       

	/******************* non castrol trips *******************/
	
	int ncastdistlasttrip=0, ncastOSlasttrip=0, ncastRDlasttrip=0, ncastRAlasttrip=0, ncastOSDuralasttrip=0;
	int ncastRAlasttripcalc=0, ncastRDlasttripcalc=0, ncastOSlasttripcalc=0;
         java.util.Date ncastendDate = new java.util.Date() ;
      
	double ncastratlasttrip=0.0;  
	String nontripid=""; 
	sql="select * from t_completednontripjourney where DriverId='"+driverid+"' and JDcode <> '-' order by StartDate desc limit 1";
	ResultSet rstnon=st1.executeQuery(sql);
	if(rstnon.next())
	{
		nontripid=rstnon.getString("JDcode");
		ncastdistlasttrip=rstnon.getInt("KmTravelled");
		ncastratlasttrip=rstnon.getDouble("TripRating");
		ncastratingfrmtd=nf.format(ncastratlasttrip);
      		ncastendDate =  rstnon.getDate("EndDate");
      		java.util.Date curDate = new java.util.Date();
                if(ncastendDate.compareTo(curDate) > 0  ){
                //System.out.println(ncastendDate+":::ncastendDate.... less than curr date::::"+curDate);
                }
                //d = new java.util.Date().compareTo(java.util.Date(rstnon.getDate(EndDate) ));
	}
		sql1="select count(*) as OS from t_nontrip_overspeed where Jcode='"+nontripid+"'";
 		ResultSet rstnonos=st1.executeQuery(sql1);
 		if(rstnonos.next())
 		{
 			ncastOSlasttrip=rstnonos.getInt("OS");
 		}
 		sql1="select count(*) as RA from t_nontrip_ra where Jcode='"+nontripid+"'";
 		ResultSet rstnonra=st1.executeQuery(sql1);
 		if(rstnonra.next())
 		{
 			ncastRAlasttrip=rstnonra.getInt("RA");
 		}
 		sql1="select count(*) as RD from t_nontrip_rd where Jcode='"+nontripid+"'";
 		ResultSet rstnonrd=st1.executeQuery(sql1);
 		if(rstnonrd.next())
 		{
 			ncastRDlasttrip=rstnonrd.getInt("RD");
 		}
	
	/******************* non castrol trips *******************/
%>
<table class="stats" width="100%" border="1">
<tr>
<td class="hed"><b>Violations</b></td>
<td class="hed"><b>Castrol Trips</b></td>
<!--  <td class="hed"><b>Non-Castrol Trips</b></td> -->
</tr>
<tr>
<td class="hed"><b>OS</b></td>
<td><%=oscount%></td>
<!--   <td>< %=ncastOSlasttrip%></td>  -->
</tr>

<tr>
<td class="hed"><b>RA</b></td>
<td><%=racount%></td>
<!-- <td>< %=ncastRAlasttrip%></td>   -->
</tr>

<tr>
<td class="hed"><b>RD</b></td>
<td><%=rdcount%></td>
<!-- <td>< %=ncastRDlasttrip%></td>  -->
</tr>

<tr>
<td class="hed"><b>Distance</b></td>
<td><%=distance%></td>
<!-- <td>< %=ncastdistlasttrip%></td>  -->
</tr>

<%
 ratingfrmtd=nf.format(rating); 
 ncastratingfrmtd=nf.format(ncastratlasttrip);
String preCa = "" ,postCa = "" ;
String preNCa ="", postNCa = "";
java.util.Date curDate = new java.util.Date();

        Format  formater = new SimpleDateFormat("yyyy-MM-ddHH:mm:ss");
        String toDate = formater.format(curDate);

        if(enddate.compareTo(curDate) < 0  ){
                //System.out.println(enddate+":::ncastendDate..hhh.. less than curr date::::"+curDate);
              preCa = ratingfrmtd;
              preNCa = "-";
                }else{
                preCa="-";
                }

                if(enddate.compareTo(curDate) > 0  ){
                //System.out.println(enddate+":::ncastendDate..hhh.. less than curr date::::"+curDate);
              postCa = "Trip is not ended yet.";
              postNCa = "-";
                }else{
                postCa="-";
                 //postNCa=ncastratingfrmtd;
               
             //   postNCa=tr.tripRating(eDate.toString().replace(" ",""),toDate,vehid);
                }



 //System.out.println(ratingfrmtd+"::: ratingfrmtd.......... ncastratingfrmtd ::::"+ncastratingfrmtd);
%>
<tr>
<td class="hed"><b>Pre-rating</b></td>
<td><%=preCa%></td>
<!--  <td> < %=preNCa % ></td> -->
</tr>
<tr>
<td class="hed"><b>Post-rating</b></td>
<td><%=postCa%></td>
<!--  <td>< %=postNCa%></td>  -->
</tr>

</table>
			
	<%
	}catch(Exception e)
	{
		System.out.println("Exception:: "+e);
	}
	finally
	{
		try
		{
			st.close();
		st1.close();
		conn.close();
		}
		catch(Exception e)
		{
			
		}
	}
	
	%>
</td>
</tr>
</table>
