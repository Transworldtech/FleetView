<%@ include file="Connections/conn.jsp" %>
<%@ page import="java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="java.io.*" %>
   <%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*"%>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page import="java.sql.*" %>

  	<%@ page import = "java.io.FileNotFoundException"%>
  	<%@ page import = "java.io.FileOutputStream"%>
  	<%@ page import = "java.io.IOException"%>
  	<%@ page import="javax.activation.*" %>
  	<%@page import="java.io.BufferedReader" import="java.io.InputStreamReader" import="java.net.URL" %>
  	<%@page import="java.net.URLEncoder" import="java.net.URLConnection"%>
  	
  	 <%@ page import="java.io.*,java.util.*, javax.servlet.*" %>

<%!
Connection con1;
Statement st,st1,st2,st3,st4,st5,st15,st16,st12,st10;


String xyz1="";
%>


<% 
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
st=con1.createStatement();
st1=con1.createStatement();
st15=con1.createStatement();
st16=con1.createStatement();
st12=con1.createStatement();
st10=con1.createStatement();
ResultSet rst2=null,rst3=null,rst4=null;
String VehId=request.getParameter("VehId");
System.out.println("VehIDDDDDDDD on dynamic insert page "+VehId);
String VehRegNo=request.getParameter("VehRegNo");
System.out.println("VehRegNo    on dynamic insert page "+VehRegNo);

String user=session.getAttribute("mainuser").toString();
String transporter=session.getAttribute("usertypevalue").toString();
%>
<%
   int no = Integer.parseInt(request.getParameter("dy1"));
   System.out.println("\n"+no);
   
   if(no==0)
   {
	   
	   out.println("<script type='text/javascript'>alert('First Add Custom Field');");
	   out.println("location='DHydrolic.jsp?VehId="+VehId+"&VehRegNo="+VehRegNo+"'");
	  	out.println("</script>");
	   
   }
   else
   {
StringBuilder sb=new StringBuilder();
String[] colname=new String[500];
String[] fieldname=new String[500];
// String VehId=request.getParameter("VehId");
// System.out.println("VehIDDDDDDDD on dynamic insert page "+VehId);
// String VehRegNo=request.getParameter("VehRegNo");
// System.out.println("VehRegNo    on dynamic insert page "+VehRegNo);




%>
<%
// String abc="select field from db_gps.t_parent where field='"+expence+"' ";
// rst2=st3.executeQuery(abc);

String abc2="select field from db_gps.t_hydrolicsystemforcustomfieldmaster where Owner='"+transporter+"'";
rst3=st12.executeQuery(abc2);
while(rst3.next())
{
	xyz1=rst3.getString("field");
	//out.println("Field:->"+xyz1);
	sb.append(xyz1).append(" ");
	
}
System.out.println("String:->"+abc2);



int j=0;
int i=1;
String abc="select * from db_gps.t_hydrolicsystemforcustomfielddata where Field='"+xyz1+"' and Owner='"+transporter+"' ";
rst2=st16.executeQuery(abc);
System.out.println("String:->"+abc);
int count=0;
String finalfielsname="",finalcolname="";
 String a[]  = new String[no+1]; 
String abc1="";
if(rst2.next())
{
	out.println("<script type='text/javascript'>alert('NOT Inserted');");
	 out.println("location='EditDHydrolic.jsp?VehId="+VehId+"&VehRegNo="+VehRegNo+"'");
 	out.println("</script>");
}
else{
 	count++;

fieldname=sb.toString().split(" ");
//out.println("fieldname--------"+fieldname[0]);

 for(int q=0;q<no;q++)
    {
	colname[q]=request.getParameter("name_"+q); 
    finalfielsname+=fieldname[q]+",";
    finalcolname+="'"+colname[q]+"'"+",";
    } 
 
 finalfielsname=finalfielsname.substring(0, finalfielsname.length()-1);
 finalcolname=finalcolname.substring(0, finalcolname.length()-1);
 
 //out.println("finalfielsname--------"+finalfielsname);
 //out.println("finalcolname--------"+finalcolname);

 String insertString="insert into  db_gps.t_hydrolicsystemforcustomfielddata(VehRegNo,VehId,Owner,EntryBy,"+finalfielsname+") values('"+VehRegNo+"','"+VehId+"','"+transporter+"','"+user+"',"+finalcolname+") ";
 //out.println("insertString--------"+insertString);
st15.executeUpdate(insertString);



String insertString1="insert into  db_gps.t_hydrolicsystemforcustomfieldhistory(VehRegNo,VehId,Owner,EntryBy,"+finalfielsname+") values('"+VehRegNo+"','"+VehId+"','"+transporter+"','"+user+"',"+finalcolname+") ";
//out.println("insertString--------"+insertString);
st10.executeUpdate(insertString1);
 
 
 out.println("<script type='text/javascript'>alert('Record Inserted Succesfully');");
 out.println("location='EditDHydrolic.jsp?VehId="+VehId+"&VehRegNo="+VehRegNo+"'");
	out.println("</script>");
 
}
   }
%>






