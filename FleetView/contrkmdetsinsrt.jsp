<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="header.jsp" %>
<%@ include file="headercallcenter.jsp" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import=" java.util.*"  import="java.util.Date" errorPage="" %>
<%! 
Connection con1,conn;
Statement stmt1,stquery;
%>
<%
try
{   
       //  System.out.println("insert page star");
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING5,MM_dbConn_USERNAME5,MM_dbConn_PASSWORD5);
	conn = DriverManager.getConnection(MM_dbConn_STRING6,MM_dbConn_USERNAME5,MM_dbConn_PASSWORD5);
	stmt1=con1.createStatement();
	stquery=conn.createStatement();
	
        String sql1="",sql2="" ,sql3="";
        ResultSet rs1=null,rs2 = null;
	String cabno="", opkm="", closkm="", dte="", noofemp="";
	int opkmint=0, closkmint=0, diff=0;	
        int hidnofveh = Integer.parseInt(request.getParameter("hidnofveh"));
        
        
         ArrayList alopenkm = new ArrayList();
       ArrayList alclosekm = new ArrayList();
       ArrayList alnofempkm = new ArrayList();

        for(int i = 1; i<hidnofveh; i++){
        
        cabno=request.getParameter("cablist"+i); 
	opkm=request.getParameter("openkm"+i); 
	closkm=request.getParameter("closekm"+i); 
	dte=request.getParameter("calender");
	noofemp=request.getParameter("noofemp"+i);
        
        
        
alopenkm.add(i-1, request.getParameter("openkm"));
alclosekm.add(i-1, request.getParameter("closekm"));
alnofempkm.add(i-1, request.getParameter("noofemp"));
        
        
        
      //   System.out.println(i+"::opkm****::"+opkm+"::****closkm::"+closkm+"::cabno::"+cabno+"::no of emp::"+noofemp+"::date::"+dte);
        
        
       /* 
	cabno=request.getParameter("cablist"); 
	opkm=request.getParameter("openkm"); 
	closkm=request.getParameter("closekm"); 
	dte=request.getParameter("calender");
	noofemp=request.getParameter("noofemp");
        
        */
        
        
      //  System.out.println(opkm+"val load from ses"+dte);
	
	opkmint=Integer.parseInt(opkm); 
	closkmint=Integer.parseInt(closkm);
	diff=closkmint-opkmint; 
     //   System.out.println("converttion");
        /*
        Code inserted by yogesh on 30 jan 09,Friday to show the instance data inserted by current user
        Purpoose of showing this data is to notice thye user what ever values he inserted in current session.
        *Code starts here 
        */
        GregorianCalendar gc = new GregorianCalendar();
       
        java.sql.Time curTime = new Time(gc.getTime().getHours(),gc.getTime().getMinutes(),gc.getTime().getSeconds());
        
       session.setAttribute("loginTime",curTime);
   //    System.out.println(session.getAttribute("loginTime")+"cur time::"+curTime);
       
       
        // Code by yogesh ends here.


	
	//sql1="select * from t_kmdetails where  ondate='"+dte+"' and CabRegNo='"+cabno+"' ";
        sql1="select * from t_vendorKmDetails where  TheDate='"+dte+"' and VehNo='"+cabno+"' ";
     //   System.out.println("sql1::"+sql1);
	rs1=stmt1.executeQuery(sql1);
      //  System.out.println("sql1::"+sql1);
	if(rs1.next())	
	{
		sql2="update t_vendorKmDetails set openingkm='"+opkm+"', closingkm='"+closkm+"', NoofEmp='"+noofemp+"' ,TheTime='"+curTime+"'  where VehNo='"+cabno+"' and TheDate='"+dte+"'";
		out.print(sql2);
		
		/*Query to insert query in db_gps.t_sqlquery table*/
		String abcd=sql2.replace("'","#");
		abcd=abcd.replace(",","$");
		stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_callcenter','"+abcd+"')");
		
	 /*****************************/
		
		stmt1.executeUpdate(sql2);
	}
	else
	{
		//sql2="insert into t_kmdetails (CabRegNo, ondate, openingkm, closingkm, Total1, Noofempvend) values ('"+cabno+"', '"+dte+"', '"+opkm+"', '"+closkm+"', '"+diff+"', '"+noofemp+"') ";
		sql2="insert into t_vendorKmDetails (TheTime,VehNo, TheDate, openingkm, closingkm, NoofEmp) values ('"+curTime+"','"+cabno+"', '"+dte+"', '"+opkm+"', '"+closkm+"', '"+noofemp+"') ";
              //  System.out.println("sql2::"+sql2);
                
        /*Query to insert query in db_gps.t_sqlquery table*/
       	String abcd1=sql2.replace("'","#");
       	abcd1=abcd1.replace(",","$");
       	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_callcenter','"+abcd1+"')");
        /*****************************/      
                stmt1.executeUpdate(sql2);
                
	}	
	}
session.setAttribute("alopenkm",alopenkm );
session.setAttribute("alclosekm",alclosekm );
session.setAttribute("alnofempkm",alnofempkm );
con1.close();
        response.sendRedirect("contrkmdets1.jsp?inserted=yes");//    &cablist= <%="+cabno+">&openkm= <%="+opkm+">&closekm= <%="+closkm+">&calender= <%="+dte+">&noofemp= <%="+noofemp+">");
	return;
}catch(Exception e)
{
	out.print("Exception -->"+e);

}
finally
{
   // System.out.println("garb.coll invok");
   	System.gc();
   	con1.close();
   	conn.close();
        
}
%>
