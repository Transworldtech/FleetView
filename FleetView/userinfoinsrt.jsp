<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ include file="Connections/helpconn.jsp" %>

<%
try
{
       
	
	ResultSet rs2=null;
        String sql1="", sql2="";

	String fname="", lname="", mobno="", email="", desig="", loc="", usertyp="", typval="";
        String username=session.getValue("user").toString();
	fname=request.getParameter("fname");
	if(fname==null)
	{
		fname="NA";
	}
     lname=request.getParameter("lname");
     if(lname==null)
     {
    	 lname="NA";
     }
	mobno=request.getParameter("mobno");
	if(mobno==null)
	{
		mobno="NA";
	}
	email=request.getParameter("email");
	if(email==null)
	{
		email="NA";
	}
	desig=request.getParameter("desig");
	if(desig==null)
	{
		desig="NA";
	}
	loc=request.getParameter("loc");
	if(loc==null)
	{
		loc="NA";
	}
	System.out.println("in userinfoinsrt page value of fname"+fname+"lname"+lname+"mobno"+mobno+"email"+email+"desig"+desig+"loc"+loc);
	System.out.println("value of fname"+fname);
	System.out.println("value of lname"+lname);
	System.out.println("value of mobno "+mobno);
	System.out.println("value of email "+email);
	System.out.println("value of desig "+desig);
	System.out.println("value of loc"+loc);
 	//out.print(trans);

        sql2="select * from t_security where Username='"+username+"' ";	
	out.print(sql2);
	rs2=getStatement.executeQuery(sql2);
  	if(rs2.next())
	{
		usertyp=rs2.getString("TypeofUser");
		typval=rs2.getString("TypeValue");
	}

 	sql1="insert into t_userdetails (UserName, Transporter, UserType, FirstName, LastName, MobNo, Email, Designation, Location) values ('"+username+"', '"+typval+"', '"+usertyp+"', '"+fname+"', '"+lname+"','"+mobno+"','"+email+"','"+desig+"','"+loc+"')";
        
 	/*Query to insert query in db_gps.t_sqlquery table*/
	String abcd=sql1.replace("'","#");
	abcd=abcd.replace(",","$");
	getStatement.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	/*****************************/
 	getStatement.executeUpdate(sql1);
	System.out.println("insertion queryy"+sql1);
	session.setAttribute("phno",mobno);
	session.setAttribute("email",email);
	session.setAttribute("fname",fname);
	session.setAttribute("lname",lname);
	session.setAttribute("desig",desig);
	session.setAttribute("loc",loc);
	session.setAttribute("rfname",fname);
	session.setAttribute("rlname",lname);
        response.sendRedirect("sessionvalidate.jsp");
        return; 

} catch(Exception e)
  {
      out.print(e);
  }
finally
{
	getStatement.close();
	getDattabase.close();
}
%>
