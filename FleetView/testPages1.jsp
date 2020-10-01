
     <%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*" %>
   <%@page import="java.util.*" %>
     <%@page import="org.json.JSONObject" %>
  <%  
  
Connection con=null;
  Class.forName("com.mysql.jdbc.Driver").newInstance();
  con =      DriverManager.getConnection("jdbc:mysql://202.65.131.44/db_gps","fleetview","1@flv");

  Statement st=con.createStatement();
  Statement st1=con.createStatement();
  
 try {
	 
	 //System.out.print("jsbgcjbsxchujbscuhvbsdfchyuvsdycfgvsjhvuhjsvcuhvsdcyuvdcyugvd chvdytvdc");
  
       ResultSet rs = null;
       List empdetails = new LinkedList();
        JSONObject responseObj = new JSONObject();
        String start = request.getParameter("startDate");
        String end = request.getParameter("endDate");
        String vehcode1 = request.getParameter("veHcode");
        System.out.println(start+" "+end);

        String query = "SELECT thefielddatadatetime as date,sen1 as temp FROM db_gps.t_veh"+vehcode1+" WHERE thefielddatadatetime BETWEEN '"+start+"' AND '"+end+"' and replace(sen1,'$','-') and sen1<>' ' and sen1<>'-'";
        PreparedStatement pstm= con.prepareStatement(query);
        System.out.print(query);
           rs = pstm.executeQuery();
           JSONObject empObj = null;
        while (rs.next()) {
        	//System.out.println("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
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