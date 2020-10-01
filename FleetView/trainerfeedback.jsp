 <%@ include file="Connections/conn.jsp" %>

<%@ page buffer="16kb" %>
<html>
<head>
<title>Vehicle Tracking System</title>

<script src="searchhi.js" type="text/javascript"></script>
<script src="sorttable.js" type="text/javascript"></script>
<link href="css/css.css" rel="StyleSheet" type="text/css"></link>
<link href="css/erratic.css" rel="StyleSheet" type="text/css"></link>
<link rel="stylesheet" type="text/css" href="css/cpanel_002.css"> 
<link rel="stylesheet" type="text/css" href="css/cpanel_colors.css">
<script src="js/searchhi.js" type="text/javascript"></script>
<%!
Connection con1;
%>

<script language="javascript">
function validate()
{
	var cntr=document.feedback.cntr1.value;
	//cntr=cntr-1;

	var flag="False";

	for(var j=0;j<cntr;j++)
	{	
		if(document.getElementById("cb"+j).checked==true)
		{
			flag="True";
		}		
	}

	if(flag=="False")
	{
		alert("Please Select Check-Box To Reply");
		return false;	
	}		
	changeAction();
}


function changeAction()
{ //alert("hi");
	//var transporter=document.fullfleet.transporter.value;
	var cntr=document.feedback.cntr1.value;
	//var cntr1=document.feedback.cntr1.value;
	//var cb=document.getElementById("cb"+1).value;
	//alert("hi"+cb);
	
	//alert("cntr--->"+cntr);
	//alert(cntr1);
	var url="feedbackreply.jsp?";
      	var i=0;
   	for(var j=0;j<cntr;j++)
    	{	//alert("j loop"+j);
    		if(document.getElementById("cb"+j).checked==true)
    		{
            	 url=url+"&brifid"+i+"="+document.getElementById("bid"+j).value;
				 i++;
				 //alert("map"+url);
    		}		
    	}
    	        
        //write function to check no of check boxes get value
        
         

        document.feedback.action=url+"&cntr="+i;
      	//document.fullfleet.action="Changewarranty1.jsp";
        //alert(document.feedback.action);
        document.feedback.submit();
}

</script>
</head>

<body>
<form name="feedback" method="post" action="" onSubmit="" style="overflow:scroll" >
<% 
try {
Class.forName(MM_dbConn_DRIVER);
con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
ResultSet rs1=null,rs2=null,rs=null;
Statement stmt=con1.createStatement(),stmt1=con1.createStatement(), stmt2=con1.createStatement(),stmt3=con1.createStatement();
String sql1="";
String trans=session.getAttribute("usertypevalue").toString();

boolean flag=true, dispflag=false;
int i=1,j=0;
String date=new SimpleDateFormat("yyMMdd").format(new java.util.Date());
String VehRegNo="",tripid="",StartDate="",EndDate="",StartPlace="",EndPlace="",feedback="",status="",briefid="",briefdate="-",fdbackby="",fdbackrply="",fdbackrplyby="",fdbackrplydt="";


%>

<table width="100%" border="0" align="center" class="stats">
<tr><td align="center" colspan="3"><b><font size="3">DMC FEEDBACK</font></b>
<div align="right" ><input type="submit" name="Reply" value="Reply" class="formElement" onclick="return validate();"/></div></td>
</tr>
</table>
<div style="margin-center: 178px; height:500px; overflow: auto;">
		
		<table border="0" class="sortable" width="100%">
		
			<tr><th>SrNo.</th>
				<th>chk box</th>
				<th>FB Date</th>
				<th>Trip ID</th>
				<th>FB By</th>
				<th>Trainer FB</th>
				<th>FB ReplyDate</th>
				<th>FB Reply</th>
				<th>Reply By</th>
				<th>VehReg no</th>
				<th>StartPlace</th>
				<th>EndPlace</th>
				<th>StartDate</th>
				<th>EndDate</th>
				<th>Briefing</th>
				<th>Debriefing</th>
				<th>Transporter</th>
				<th>DriverName</th>
				<th>Driverid</th>
				<th>Status</th>
				
			</tr>
<%


String sql3="select * from t_briefing where Transporter ='"+trans+"' and (FeedBack not like 'NIL%' || FeedBack not like 'Nil%') order by brifdate Desc";
System.out.println("sql3---->"+sql3);
rs=stmt1.executeQuery(sql3);
while(rs.next())// && (reset==null || reset.equalsIgnoreCase("no")))
{
	
		feedback=rs.getString("FeedBack");
		if(feedback != null && feedback.trim().length()>0)
		{
			dispflag=true;
		}
		else
		{
			dispflag=false;
		}
	
		if(dispflag)
		{
		status=rs.getString("TicketStatus");
		briefid=rs.getString("Briefid");
		briefdate=new SimpleDateFormat("dd-MMM-yyyy").format( new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("brifdate")));
		fdbackby=rs.getString("GrantPermByperson");
		fdbackrply=rs.getString("ReplyFeedBack");
		fdbackrplyby=rs.getString("ReplyFrom");
		 tripid=rs.getString("tripid");
		//System.out.println("tripid"+tripid);
		String DriverName=rs.getString("DriverName");
		String Transporter=rs.getString("Transporter");
		String Driverid=rs.getString("Driverid");
		String brifstatus=rs.getString("brifstatus");
		String Debrifstatus=rs.getString("Debrifstatus");
		fdbackrplydt=rs.getString("RFDate");
		
		if(fdbackrplydt.equals("pending"))
		{
		
		}
		else
		{
		fdbackrplydt=new SimpleDateFormat("dd-MMM-yyyy").format( new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("RFDate")));
		}
		if(tripid==null||tripid.equals("0"))
		{
			VehRegNo="-";
			StartPlace="-";
			EndPlace="-";
			StartDate="-";
			EndDate="-";
			System.out.println("VehRegNo---->"+VehRegNo);
		}
		else
		{
		String sql4="select * from t_startedjourney where TripID='"+tripid+"'";
		//System.out.println("sql4---->"+sql4);
		ResultSet rst4=stmt.executeQuery(sql4);
		if(rst4.next())
		{
			VehRegNo=rst4.getString("VehRegNo");
			StartPlace=rst4.getString("StartPlace");
			EndPlace=rst4.getString("EndPlace");
			StartDate=rst4.getString("StartDate");
			String sql6="select EndDate from t_completedjourney where TripID='"+tripid+"'";
			//System.out.println("sql5---->"+sql6);
			ResultSet rst6=stmt3.executeQuery(sql6);
			if(rst6.next())
			{
				EndDate=rst6.getString("EndDate");
				//System.out.println("VehRegNo---->"+VehRegNo);
				
			}

		}
		else
		{
			String sql5="select * from t_completedjourney where TripID='"+tripid+"'";
			//System.out.println("sql5---->"+sql5);
			ResultSet rst5=stmt2.executeQuery(sql5);
			if(rst5.next())
			{
				VehRegNo=rst5.getString("VehRegNo");
				StartPlace=rst5.getString("StartPlace");
				EndPlace=rst5.getString("EndPlace");
				StartDate=rst5.getString("StartDate");
				EndDate=rst5.getString("EndDate");
				//System.out.println("VehRegNo---->"+VehRegNo);
				
			}
			else
			{
				VehRegNo="-";
				StartPlace="-";
				EndPlace="-";
				StartDate="-";
				EndDate="-";
			}
		}
		}
%>
		
			<tr>
				<td style="text-align: right"><%=i %></td>
				<td style="text-align: left"><%if(status.equals("Closed"))
											{
											%>
											&nbsp;
											<%
				
				}
				else
				{
				%>
				<div align="center"> <input type="checkbox" name="cb<%=j%>" id="cb<%=j%>"  value="cb<%=j%>"> 
				<input type="hidden" id="bid<%=j%>" name="bid<%=j%>" value="<%=briefid%>" /> </div> 
				<%
				j++;
				}
				%>
				</td>
				<td style="text-align: left"><%=briefdate%></td>
				<td style="text-align: left"><%=tripid%></td>
				<td style="text-align: left"><%=fdbackby%></td>
				<td style="text-align: left"><%=feedback%></td>
				<td style="text-align: left"><%=fdbackrplydt%></td>
				<td style="text-align: left"><%=fdbackrply%></td>
				<td style="text-align: left"><%=fdbackrplyby%></td>
				<td style="text-align: left"><%=VehRegNo%></td>
				<td style="text-align: left"><%=StartPlace%></td>
				<td style="text-align: left"><%=EndPlace%></td>
				<td style="text-align: left"><%=StartDate%></td>
				<td style="text-align: left"><%=EndDate%></td>
				<td style="text-align: left"><%=brifstatus%></td>
				<td style="text-align: left"><%=Debrifstatus%></td>
				<td style="text-align: left"><%=Transporter%></td>
				<td style="text-align: left"><%=DriverName%></td>
				<td style="text-align: left"><%=Driverid%></td>
				<td style="text-align: left"><%=status%></td>
				
				<%
					
				i++;
				
				%>
			</tr>	
<%
}
}
	%>
 <div align="center">
 <input type="hidden" name="cntr" value="<%=i %>" />
 <input type="hidden" name="cntr1" value="<%=j %>" /></div>
 <%	

}catch(Exception e) { out.println("Exception----->" +e); }

finally
{
con1.close();
} 
%>
	</table>

	</div>
	</form>

	</body>
	</html>