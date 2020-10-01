<%@ include file="Connections/conn.jsp" %>

<%!
Connection con=null;
Statement st,st1;
%>
     <%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*" %>
   <%@page import="java.util.*" %>
     <%@page import="org.json.JSONObject" %>
  <%  
  

  Class.forName(MM_dbConn_DRIVER);
  con = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
  st=con.createStatement();
  st1=con.createStatement();

  
 try {
	 
	 //System.out.print("jsbgcjbsxchujbscuhvbsdfchyuvsdycfgvsjhvuhjsvcuhvsdcyuvdcyugvd chvdytvdc");
  
       ResultSet rs = null;
       ResultSet rs2 = null;
       ResultSet rs1 = null;
       List  empdetails = new LinkedList();
        JSONObject responseObj = new JSONObject();
        String start = request.getParameter("startDate");
        String end = request.getParameter("endDate");
        String vehcode1 = request.getParameter("veHcode");
        System.out.println(start+" "+end);

        String query = "SELECT thefielddatadatetime as date,sen1 as temp FROM db_gps.t_veh"+vehcode1+" WHERE thefielddatadatetime BETWEEN '"+start+"' AND '"+end+"' and replace(sen1,'$','-') and sen1<>' ' and sen1<>'-' and (sen1<>'085.000' and sen2<>'085.000' and sen3<>'085.000' and sen4<>'085.000') and  SUBSTRING(sen1, 1, 1)='0' ";	
        System.out.println(" Printed query "+query);
        PreparedStatement pstm= con.prepareStatement(query);
        System.out.print(query);
           rs = pstm.executeQuery();
           JSONObject empObj = null;
        while (rs.next()) 
        {
        	double temp = Double.parseDouble(rs.getString("temp"));
            String date = rs.getString("date");
            date=date.replace(".0","");
            String date1=new SimpleDateFormat("HH:mm MMMM dd, yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date));
           //System.out.println("lsxnfjkshdfkos"+date1);
           
          //System.out.println(date1+"ooooooooooooooooooooooooooooo");
                       
            empObj = new JSONObject();
            empObj.put("temp", temp);
            empObj.put("date", date1);
            empdetails.add(empObj);
            //System.out.println(temp);
        }
        String Min="", Max="";
        String date51="",date61="";
        String sql31="select CONVERT(sen1,SIGNED INTEGER) as Min,TheFieldDataDateTime from db_gps.t_veh"+vehcode1+" where  TheFieldDataDateTime between '"+start+"' and '"+end+"' and TheFiledTextFileName='SI' and (sen1<>'085.000' and sen2<>'085.000' and sen3<>'085.000' and sen4<>'085.000') and  SUBSTRING(sen1, 1, 1)=0 order by CONVERT(sen1,SIGNED INTEGER) asc limit 1";
		System.out.println(" 2 query "+sql31);
        rs1 = st.executeQuery(sql31);
		if(rs1.next())
		{
			Min=rs1.getString("Min");
			date51=rs1.getString("TheFieldDataDateTime");
			date51=new SimpleDateFormat("dd-MMM-yyyy HH:mm ").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date51));
			System.out.println(Min);
		}
		
		String sql41="select CONVERT(sen1,SIGNED INTEGER) as Max,TheFieldDataDateTime from db_gps.t_veh"+vehcode1+" where  TheFieldDataDateTime between '"+start+"' and '"+end+"' and TheFiledTextFileName='SI' and (sen1<>'085.000' and sen2<>'085.000' and sen3<>'085.000' and sen4<>'085.000') and  SUBSTRING(sen1, 1, 1)='0' order by CONVERT(sen1,SIGNED INTEGER) desc limit 1";
		System.out.println(" 3 query "+sql41);
		rs2 = st.executeQuery(sql41);
		if(rs2.next())
		{
			Max=rs2.getString("Max");
			date61=rs2.getString("TheFieldDataDateTime");
			date61=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date61));
			System.out.println(Max);
		}
		empObj.put("Min",Min);
		empObj.put("Max",Max);
		empObj.put("date51",date51);
		empObj.put("date61",date61);
		empdetails.add(empObj);
        responseObj.put("empdetails", empdetails);
    out.print(responseObj.toString());
    }
    catch(Exception e){
        e.printStackTrace();
    }finally{
        if(con != null){
            try{
            con.close();
            }catch(Exception e){
                e.printStackTrace();
            }
        }
    }
 %>