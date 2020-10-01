<%@ include file="airtelheader.jsp"%>

<jsp:useBean id="fleetview" class="com.fleetview.beans.classes" scope="page">
	
	
<script language="javascript">
 var showothothsertype="No";

 var preventive="No";
 var oil="No";
 var puc="No";
 var insurance="No";
 var fitness="No";
 var npermit="No";
 var tax="No";
 
function validate()
{  
	//alert("In Validate");
	 var v1=document.gensetmaster.siteid.value;
	 var v2=document.gensetmaster.gensetid.value;
	 var v3=document.gensetmaster.make.value;
	 var v4=document.gensetmaster.capacity.value;
	 var v5=document.gensetmaster.relevel.value;
	 var v6=document.gensetmaster.batvolt.value;
	 var v7=document.gensetmaster.temorange.value;
	 var v8=document.gensetmaster.btrmake.value;
	 var v9=document.gensetmaster.calender1.value;
	 var v10=document.gensetmaster.switchp.value;
	 var v11=document.gensetmaster.srtstp.value;
	 var v12=document.gensetmaster.oillevel.value;
	
	 var numericExpressionn = /^[.0-9]+$/;

		if(v1=="")
	    {
	       alert("Please Enter Site ID");
	       return false;   
	    }
		if(v3=="")
	    {
	       alert("Please Enter Make");
	       return false;   
	    }
	    if(v4=="")
	    {
		    alert("Please Enter Capacity");
		    return false;   
		}
		if(v5=="")
		{
			alert("Please Enter Relevel");
			return false;   
		}
		if(v6=="")
		{
			alert("Please Enter Battery Voltage");
			return false;   
		}
		if(v7=="")
		{
			alert("Please Enter Temprature range");
			return false;   
		}
		if(v8=="")
		{
			alert("Please Enter Battery Make");
			return false;   
		}
		if(v10=="Select")
	    {
	        alert("Please Select Switch Position");
	        return false;   
	    }
		if(v11=="Select")
	 	{
	 		alert("Please Select start/Stop");
	 		return false; 
	 	}
		if(v12=="")
		{
			alert("Please Enter Oil Level");
			return false;   
		}
		return true; 
   }

 </script>
<%
Connection con=null;
Statement stmt;
ResultSet rs;
%>

	<% 
try {
	Class.forName("org.gjt.mm.mysql.Driver"); 
	con=DriverManager.getConnection("jdbc:mysql://localhost/TestDemo","fleetview","1@flv");	
	
String sql2="", sql3="", sql4="", sql5="",sql33="";
String vehno="", prvdid="",lastdriverid="", lastdrivername="",make="",switchp1="",srtstp1="",btrmake="";
int gid=0,siteid=0,capacity=0,relevel=0,oillevel=0,temprange=0;
float batvolt;
//---------------------------------------------
	String s1=request.getParameter("siteid");
	siteid=Integer.parseInt(s1);
	
	make=request.getParameter("make");

	String s3=request.getParameter("capacity");
	capacity=Integer.parseInt(s3);
	
	String s4=request.getParameter("rlevel");
	relevel=Integer.parseInt(s4);
	
	String s7=request.getParameter("bvolt");
	batvolt=Float.parseFloat(s7);
	
	btrmake=request.getParameter("bmake");
	
	String s5=request.getParameter("olevel");
	oillevel=Integer.parseInt(s5);
	
	String s6=request.getParameter("trange");
	temprange=Integer.parseInt(s6);
	
/*	switchp1=request.getParameter("tpos");
	srtstp1=request.getParameter("strstp");*/
	
//	out.println("siteid"+siteid+",capacity"+capacity+",relevel"+relevel+",oillevel"+oillevel+",temprange"+temprange+",make"+make+",switchp1"+switchp1+",srtstp1"+srtstp1+",btrmake"+btrmake);

//----------------------------------------------
String gd=request.getParameter("gensetid1");
gid=Integer.parseInt(gd);
String user=session.getValue("usertypevalue").toString();

java.util.Date d=new java.util.Date();
//String dte= "" + (d.getYear()+1900) + "-" + (1+d.getMonth()) + "-" + d.getDate();
String nwfrmtdte=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());

String inserted=request.getParameter("inserted");
 
%>
	<table border="0" bgcolor="white">
		<tr>
			<td><a href="airtelcurrentposition.jsp" title="Home"><img src="images/home.jpg" border="0"></a></td>
			<td><a href="javascript:history.go(-1)"> <img src="images/back.jpg" border="0"></a></td>
			<td><a href="logout.jsp" title="Logout"><img src="images/logout.jpeg" border="0"></a></td>
		</tr></table>
			
		<table border="0" width="95%" bgcolor="white">  
		<tr align="center">
        <td>
        	<!-- <div align="left"><font size="3"><b>Report No:1.4</b></font></div>-->
        	<div align="center"><font size="3"><b>GenSet Entry Report<b></font></div>
		</td>
		</tr>
		</table>

			<%
		    if(inserted==null)
		    {
		    }
		    else
		    { %>
			<table border="0" width="100%" bgcolor="white">
				<tr>
					<td>
					<div align="center"><font color="maroon"> <b>Inserted
					Successfully </b> </font></div>
					</td>
				</tr>
			</table>

			<%}
		    %>
		</tr>

		<tr>
			<td colspan="2">
			<form name="gensetmaster" method="get"
				action="newGensetEditInsert.jsp" onSubmit="return validate();">

			<input type="hidden" name="genset_id" value="<%=gid%>">
			
			
			<table border="0" width="70%" align="center">
				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2">
					*SiteID:-&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
					<td><input type="text" name="siteid" id="siteid" value="<%=siteid%>"></input>  
					</td>
				</tr>
				
				<tr bgcolor="#CCCCCC">
					<td><font color="maroon" size="2"> GenSet ID
					:-&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
					<td><input type="text" name="gensetid" id="gensetid" readonly="readonly" value="<%=gid%>"></input>
					</td>

				</tr>

				<tr bgcolor="#CCCCCC" id="mntdte">
					<td><font color="maroon" size="2"> *Make: </font></td>
					<td><input type="text" id="make" name="make" value="<%=make%>"></input>
					</td>
				</tr>

				<tr bgcolor="#CCCCCC" id="mkm">
					<td><font color="maroon" size="2">*Capacity:</font></td>
					<td><input type="text" name="capacity" value="<%=capacity%>" id="capacity" />Ltr.
					&nbsp;</td>
				</tr>

				<tr bgcolor="#CCCCCC" id="nxtmntdte">
					<td><font color="maroon" size="2"> *Refuel Level
					: </font></td>
					<td><input type="text" id="relevel" name="relevel" value="<%=relevel%>"></td>
				    </tr>

				<tr bgcolor="#CCCCCC" id="nmaftrkm">
					<td><font color="maroon" size="2"> *Min. Batry Voltage
					:</font></td>
					<td><input type="text" name="batvolt" id="batvolt" value="<%=batvolt %>"/>Voltage
					&nbsp;</td>
				</tr>
				<tr bgcolor="#CCCCCC" id="abd">
					<td><font color="maroon" size="2"> *Temp. Range:</font></td>
					<td><input type="text" name="temprange" value="<%=temprange%>" id="temorange" />Degr. Cel.
					&nbsp;</td>
				</tr>
				<tr bgcolor="#CCCCCC" id="mail">
					<td><font color="maroon" size="2"> *Battery Make:</font></td>
					<td><input type="text" name="btrmake" value="<%=btrmake%>" id="btrmake" />
					 &nbsp;</td>
				</tr>
			     <tr bgcolor="#CCCCCC" id="mntdte">
					<td><font color="maroon" size="2">*Next Maintenance Date: </font></td>
					<td><input type="text" id="calender1" name="calender1"
						size="13" value="<%=nwfrmtdte%>" onblur="funprsentser();" readonly />

					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <!--  <img src="../images/calendar.png" id="trigger" border="0"> -->
					<!--              <input type="button" name="trigger" id="trigger" value="Date" class="formElement"> -->
					<script type="text/javascript">
             Calendar.setup(
             {
                 inputField  : "calender1",         // ID of the input field
                 ifFormat    : "%d-%b-%Y",     // the date format
                 button      : "calender1"       // ID of the button
             }
                           );
             </script></td>
				</tr>
			
				<tr bgcolor="#CCCCCC" id="sp">
					<td><font color="maroon" size="2"> *Transfer Switch Position:</font></td>
					<td><select name="switchp" id="switchp">
					    <option value="Select">Select</option>
						<option value="ON">ON</option>
						<option value="OFF">OFF</option>
					  </select>
					  </td>
				</tr>
				<tr bgcolor="#CCCCCC" id="sp">
					<td><font color="maroon" size="2">*Remote Start/Stop:</font></td>
					<td><select name="srtstp" id="srtstp">
					    <option value="Select">Select</option>
						<option value="Start">Start</option>
						<option value="Stop">Stop</option>
					  </select>
					  </td>
				</tr>
			   <tr bgcolor="#CCCCCC" id="nmaftrkm">
					<td><font color="maroon" size="2">*Oil Level
					:</font></td>
					<td><input type="text" name="oillevel" value="<%=oillevel%>" id="oollevel" />Ltr.
					&nbsp;</td>
				</tr>
			
			
				<!--*************-->




				<tr bgcolor="#CCCCCC">
					<td colspan="2" align="center">
					<div align="center"><input type="submit" name="submit"
						id="submit" value="submit"></div>
					</td>
				</tr>

			
			</table>
			
			</form>
			</td>
		</tr>
	</table>

	<% } catch(Exception e) { out.println("Exception----->" +e); }
finally
{
	try
	{
		con.close();
	}catch(Exception e)
	{}
}
%>
</jsp:useBean>
<%@ include file="footernew.jsp"%>


</body>
</html>
