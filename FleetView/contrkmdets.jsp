<%-- 
    Document   : contrkmdets1
    Created on : Feb 1, 2009, 12:40:21 PM
    Created by     : yogesh
    Modified By : Vikram I.Nalawade
    On date : 03-Feb-09
--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<table border="1" width="100%" align="Center" >
<tr><td>
<%@ include file="header.jsp" %>
<%@ include file="headercallcenter.jsp" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import=" java.text.*" import = "javax.servlet.http.*" import=" java.util.*"  import="java.util.Date" errorPage="" %>
<%! 
Connection con1;
Statement stmt1;
%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<title>EXL Service</title>
	<link rel="stylesheet" href="style.css" type="text/css" charset="utf-8" />
	<link rel="stylesheet" href="css/css.css" type="text/css" charset="utf-8" />
	<script src="sorttable.js" type="text/javascript"></script>
	<style type="text/css">@import url(jscalendar-1.0/calendar-win2k-1.css);</style>
	<script type="text/javascript" src="jscalendar-1.0/calendar.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/lang/calendar-en.js"></script>
	<script type="text/javascript" src="jscalendar-1.0/calendar-setup.js"></script>

	<script language="javascript">
		function validate()
		{
			var cab=document.contractorkm.cablist.value;
			var opkm=document.contractorkm.openkm.value;
			var clkm=document.contractorkm.closekm.value;
			var noemp=document.contractorkm.noofemp.value;
			var dte=document.contractorkm.calender.value;

			var opkmint=parseInt(opkm);
			var clkmint=parseInt(clkm);
						
			if(cab=="Select")
			{
				alert("Please select a Cab");
				return false;
			}

			if(opkm=="")
			{
				alert("Please enter opening kms");
				return false;
			}
			if(isNaN(opkm))
			{
				alert("Please enter proper integer for opening kms");
				return false;
			}

			if(clkm=="")
			{
				alert("Please enter closing kms");
				return false;
			}
			if(isNaN(clkm))
			{
				alert("Please enter proper integer for closing kms");
				return false;
			}

			if(opkmint > clkmint)	
			{
				alert("Closing kms cannot be less than Opening Kms");
				return false;
			}

			if(noemp=="")
			{
				alert("Please enter No. of Employees");
				return false;
			}
			if(isNaN(noemp))
			{
				alert("Please enter proper integer for No. of Employees");
				return false;
			}			

			return datevalidate();
		}

		function datevalidate()
		{
			var tdydate=document.contractorkm.tdydate.value;
			var dte=document.contractorkm.calender.value;

			var dm1,dd1,dy1,dm2,dd2,dy2;
			dy1=tdydate.substring(0,4);
			dy2=dte.substring(0,4);
			dm1=tdydate.substring(5,7);
			dm2=dte.substring(5,7);
			dd1=tdydate.substring(8,10);		
			dd2=dte.substring(8,10);
			var date=new Date();
			var month=date.getMonth()+1;
			var day=date.getDate();
			var year=date.getFullYear(); 
		
			if(dy2>year)
			{
				alert("Selected year cannot be greater than present year");
				
				return false;
			}

			if(dm2>month)
		          {
				alert("Selected month cannot be graeter than present month");
			 	
				return false;
	
			  }

			if(dm2==month)
			{
				if(dd2>day)
				{
					alert("Selected day cannot be greater than today");
					return false;
	
				}
			}	
			
			
	
		return true;
	}

	</script>


</head>
<body>
    
     
    
    
<form name="contractorkm" method="get" action="contrkmdetsinsrt.jsp" >

<!--- code start here ------>
<%
try
{
	Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING5,MM_dbConn_USERNAME5,MM_dbConn_PASSWORD5);
	stmt1=con1.createStatement();
	
        String sql1="", sql2="";
        ResultSet rs1=null, rs2=null;

	java.util.Date tdydate = new java.util.Date();
	Format formatter = new SimpleDateFormat("yyyy-MM-dd");
	String dte=formatter.format(tdydate); 
        
        
	
	sql1="select * from t_cabmaster order by CabRegNo asc";
	rs1=stmt1.executeQuery(sql1);
	
        /*
        Code inserted by yogesh on 30 jan 09,Friday to show the instance data inserted by current user
        Purpoose of showing this data is to notice thye user what ever values he inserted in current session.
        *Code starts here 
        */
       
         GregorianCalendar gc = new GregorianCalendar();
       
        java.sql.Time curTime = new Time(gc.getTime().getHours(),gc.getTime().getMinutes(),gc.getTime().getSeconds());
        
        String curTimeStr = curTime.toString();
        //Date curTime = gc.getTime();
        
      //  System.out.println(session.getAttribute("loginTime")+"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"+curTimeStr);
        if(session.getAttribute("loginTime") == null ){
        //    System.out.println("%%%%%%%%%%%%777777777777777777%%%%%%%%%%%%%%%%%%%%%%%");
            //String loginTime = (String)session.getAttribute("curTimeStr");;
            session.setAttribute("loginTime",curTimeStr);
        }
       
    //   System.out.println(session.getAttribute("loginTime")+"cur time::"+curTimeStr);
       
       
       
       
        // Code by yogesh ends here.
                
	String inserted=request.getParameter("inserted");
	if(inserted==null)
	{
	}
	else
	{ 
%>
	
		<table border="0" width="100%">
	  	<tr>
		<td> <div align="center" > <font color="maroon" size="1">
			<B> <U> Successfully Inserted </U> </B></font> </div> 
		</td>
	  	</tr>
		</table>
<%	}
%>

<input type="hidden" name="tdydate" value="<%=dte%>" />
		<table border="0" width="100%">
			
                <tr>
			<td align="right"> <B><font size="2"> Date   :</B> </div> &nbsp;&nbsp;&nbsp;&nbsp;
			
			<input type="text" id="calender" name="calender" size="13" value="<%=dte%>" class="formElement" readonly/> 
                        
             <input type="button" name="trigger" id="trigger" value="Date" class="formElement">
             <script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "calender",         // ID of the input field
                 ifFormat    : "%Y-%m-%d",     // the date format
                 button      : "trigger"       // ID of the button
             }
                           );
             </script> </td>
		  </tr>	
	</table>	
        </td></tr>
	<tr><td align="center">
        	<table border="4" width="80%" >
		<tr>
		<td align="center" colspan="5"> <font color="blue" size="3">
			<B>Vendor Km Entry Form </B> </font> 
		</td>
		</tr>
		<tr>
		<th align="center"><font size="2">Sr No.</font></th>
		<th align="center"><font size="2">Cab No.</font></th>
		<th align="center"><font size="2">Opening Km</font></th>
		<th align="center"><font size="2">Closing Km </font></th>
		<th align="center"><font size="2">No of Employees </font></th>
	</td></tr>
    <%
      ArrayList alopenkm = new ArrayList();
       ArrayList alclosekm = new ArrayList();
       ArrayList alnofempkm = new ArrayList();
     // System.out.println("b4 array-session start");
       /*
       if((ArrayList)session.getAttribute("alopenkm") == null ){
           
           alopenkm =  (ArrayList)session.getAttribute("alopenkm");
      alclosekm = (ArrayList)session.getAttribute("alclosekm");
      alnofempkm = (ArrayList)session.getAttribute("alnofempkm");
    }else{
          

    }
       */
    //   System.out.println("After array-session start");
    int i = 1;
    int j = 0;
    while(rs1.next()){
        
        /*String vv = request.getParameter("openkm");
        Cookie cookie = new Cookie("openkm",vv);
        response.addCookie(cookie);
        Cookie ck[20] = request.getCookies();
    for(int y = 0; y<20; y++){
    out.println("*************"+ck[y]);
 
    }
    */
        
    j = i++;
    
//if( ((request.getParameter("openkm") == null)) || request.getParameter("openkm").length() > 0 ){ 
  //if((ArrayList)session.getAttribute("alopenkm") == null  ){    

       %>
<tr>
<td align="center"><font size="2"><%=j%></font></td>
<td align="center"> <input type="text" readonly  value="<%=rs1.getString("CabRegNo")%>" name="cablist<%=j%>" class="formElement" /> </td>
<td align="center">
	<input type="text" value="" name="openkm<%=j%>"  class="formElement" />
</td>
<td align="center">
	<input type="text" value="" name="closekm<%=j%>" class="formElement" />
</td>
<td align="center">
	<input type="text" value="" name="noofemp<%=j%>" class="formElement" />
</td>
</tr>
<% 
//}else{
%>

<%
//}

    
  /*  System.out.println("::alopenkm::"+request.getParameter("openkm"));
System.out.println("::alclosekm::"+request.getParameter("closekm"));
System.out.println(":: alnofempkm ::"+request.getParameter("noofemp"));


alopenkm.add(j, request.getParameter("openkm"));
alclosekm.add(j, request.getParameter("closekm"));
alnofempkm.add(j, request.getParameter("noofemp"));
   

if((ArrayList)session.getAttribute("alopenkm") == null  ){    
System.out.println("::alopenkm::"+alopenkm.get(j));
System.out.println("::alclosekm::"+alopenkm.get(j));
System.out.println(":: alnofempkm ::"+alopenkm.get(j));
   } */
    }%>
 
<input type="hidden" name="hidnofveh" value="<%=j%>" />
<tr>
	<td align="center" colspan="5">
		<input type="submit" name="submit" value="Submit" class="formElement" />
	</td>
</tr> 

<%
      //  System.out.println(session.getAttribute("loginTime")+"...............");
        if(!(session.getAttribute("loginTime").equals("") )){
%>
<%
	}
}
catch(SQLException e)
{
	out.print("Exception -->"+e);
        System.out.print("Exception -->"+e);

}catch(Exception e)
{
	out.print("Exception -->"+e);
        System.out.print("Exception -->"+e);

}
finally
{
	con1.close();
}
%>

<tr><td align="center" id="copyright" colspan="5">
   		<b>Copyright © 2008 by Transworld Compressor Technologies Ltd. All Rights Reserved.
</td></tr>
</table>  	
</body>
</form>
</html>
		


















