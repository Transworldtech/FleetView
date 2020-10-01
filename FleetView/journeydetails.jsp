<%@ include file="header.jsp" %>


<%!
Connection conn, conn1;
Statement st,st1;
String fidDate1, vehcode,startlocation,endlocation,startdate,starttime,hours,minutes,seconds,sql,stoptime,hours1,minutes1,seconds1,stopdate;
int journeycode;
%>
<%

try{
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);

st=conn.createStatement();
st1=conn.createStatement();
Statement stquery=conn.createStatement();


if(request.getQueryString()!=null)
{
	vehcode=request.getParameter("vehno");
	startlocation=request.getParameter("startlocation");
	endlocation=request.getParameter("endlocation");
	startdate=request.getParameter("calender");
	stopdate=request.getParameter("calender1");
	hours=request.getParameter("hours");
	minutes=request.getParameter("minutes");
	seconds=request.getParameter("seconds");
	starttime=hours+":"+minutes+":"+seconds;
	hours1=request.getParameter("hours1");
	minutes1=request.getParameter("minutes1");
	seconds1=request.getParameter("seconds1");
	stoptime=hours1+":"+minutes1+":"+seconds1;
String sql3="select max(JourneyCode) as JourneyCode from t_veh"+vehcode+"journey";
ResultSet rst3=st.executeQuery(sql3);
if(rst3.next())
{
	journeycode=rst3.getInt("JourneyCode")+1;
}
else
{
	journeycode=1;
}

String sql4="insert into t_veh"+vehcode+"journey (JourneyCode,StartPlace,StartDate,EndPlace,EndDate) values('"+journeycode+"','"+startlocation+"','"+startdate+starttime+"','"+endlocation+"','"+stopdate+stoptime+"')";

/*Query to insert query in db_gps.t_sqlquery table*/
String abcd=sql4.replace("'","#");
abcd=abcd.replace(",","$");
stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
/*****************************/

int numrows=st.executeUpdate(sql4);
if(numrows>0)
{
	JOptionPane.showMessageDialog(null,"Journey Record Inserted !!!");
}
}


%>
<table border="1" width="100%" align="center" bgcolor="white">
<tr><td>
<form name="journeyform" method="get" action="">
<table border="0" width="100%">
<tr>
<td class="bodyText" >Vehicle Reg. No</td>
<td colspan="4">

<select name="vehno" id="vehno" class="formElement">

<%
java.util.Date defoultdate = new java.util.Date();
Format formatter = new SimpleDateFormat("yyyy-MM-dd");
fidDate1 = formatter.format(defoultdate);
String sql1="select TypeofUser from t_security where TypeValue='"+session.getAttribute("usertypevalue").toString()+"'";
ResultSet rst11=st.executeQuery(sql1);
if(rst11.next())
{
	if(rst11.getString("TypeofUser").equals("GROUP"))
	{
	 sql="select * from t_group where GPname='"+session.getAttribute("usertypevalue").toString()+"'";
	}
	else
	{
	sql="select * from t_vehicledetails where GPname='"+session.getAttribute("usertypevalue").toString()+"'";
	}
}

ResultSet rst=st.executeQuery(sql);
while(rst.next())
{
	%>
	<option value='<%=rst.getString("VehCode")%>'><%=rst.getString("transporter")%></option>
	<%
}

%>
</select>
</td>
</tr>
<tr>
<td class="bodyText">Start Location</td>
<td>
<%
String sql3="select * from t_warehousedata where Owner='"+session.getAttribute("usertypevalue").toString()+"'";
ResultSet rst3=st1.executeQuery(sql3);
%>
<select name="startlocation" class="formElement" id="startlocation">
<%
while(rst3.next())
{
	%>
	<option value='<%=rst3.getString("WareHouse") %>'><%=rst3.getString("WareHouse") %></option>
	<%

}
%>
</select>


</td>
<td class="bodyText">Start Location</td>
<td>
<%
String sql2="select * from t_warehousedata where Owner='"+session.getAttribute("usertypevalue").toString()+"'";
ResultSet rst1=st1.executeQuery(sql2);
%>
<select name="endlocation" class="formElement" id="endlocation">
<%
while(rst1.next())
{
	%>
	<option value='<%=rst1.getString("WareHouse") %>'><%=rst1.getString("WareHouse") %></option>
	<%

}
%>
</select>
</td>
</tr>
<tr>
<td class="bodyText">Start Date</td>
<td><input type="text" id="calender" name="calender" size="10" class="formElement" value="<%=fidDate1%>" readonly/>
<input type="button" name="trigger" id="trigger" value="Start Date" class="formElement">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "calender",         // ID of the input field
      ifFormat    : "%Y-%m-%d",     // the date format
      button      : "trigger"       // ID of the button
    }
  );
</script>
</td>
<td class="bodyText">Stop Date</td>
<td><input type="text" id="calender1" name="calender1" size="10" class="formElement" value="<%=fidDate1%>" readonly/>
<input type="button" name="trigger1" id="trigger1" value="Stop Date" class="formElement">
<script type="text/javascript">
  Calendar.setup(
    {
      inputField  : "calender1",         // ID of the input field
      ifFormat    : "%Y-%m-%d",     // the date format
      button      : "trigger1"       // ID of the button
    }
  );
</script>
</td>
</tr>
<tr>
<td class="bodyText">Start Time :</td>
<td class="bodyText">
<select name="hours" id="hours" class="formElement">
<option value="00">00</option><option value="01">01</option><option value="02">02</option>
<option value="03">03</option><option value="04">04</option><option value="05">05</option>
<option value="06">06</option><option value="07">07</option><option value="08">08</option>
<option value="09">09</option><option value="10">10</option><option value="11">11</option>
<option value="12">12</option><option value="13">13</option><option value="14">14</option>
<option value="15">15</option><option value="16">16</option><option value="17">17</option>
<option value="18">18</option><option value="19">19</option><option value="20">20</option>
<option value="21">21</option><option value="22">22</option><option value="23">23</option>
</select>:
<select name="minutes" id="minutes" class="formElement">
<option value="00">00</option><option value="01">01</option><option value="02">02</option>
<option value="03">03</option><option value="04">04</option><option value="05">05</option>
<option value="06">06</option><option value="07">07</option><option value="08">08</option>
<option value="09">09</option><option value="10">10</option><option value="11">11</option>
<option value="12">12</option><option value="13">13</option><option value="14">14</option>
<option value="15">15</option><option value="16">16</option><option value="17">17</option>
<option value="18">18</option><option value="19">19</option><option value="20">20</option>
<option value="21">21</option><option value="22">22</option><option value="23">23</option>
<option value="24">24</option><option value="25">25</option><option value="26">26</option>
<option value="27">27</option><option value="28">28</option><option value="29">29</option>
<option value="30">30</option><option value="31">31</option><option value="32">32</option>
<option value="33">33</option><option value="34">34</option><option value="35">35</option>
<option value="36">36</option><option value="37">37</option><option value="38">38</option>
<option value="39">39</option><option value="40">40</option><option value="41">41</option>
<option value="42">42</option><option value="43">43</option><option value="44">44</option>
<option value="45">45</option><option value="46">46</option><option value="47">47</option>
<option value="48">48</option><option value="49">49</option><option value="50">50</option>
<option value="51">51</option><option value="52">52</option><option value="53">53</option>
<option value="54">54</option><option value="55">55</option><option value="56">56</option>
<option value="57">57</option><option value="58">58</option><option value="59">59</option>
</select>:
<select name="seconds" id="seconds" class="formElement">
<option value="00">00</option><option value="01">01</option><option value="02">02</option>
<option value="03">03</option><option value="04">04</option><option value="05">05</option>
<option value="06">06</option><option value="07">07</option><option value="08">08</option>
<option value="09">09</option><option value="10">10</option><option value="11">11</option>
<option value="12">12</option><option value="13">13</option><option value="14">14</option>
<option value="15">15</option><option value="16">16</option><option value="17">17</option>
<option value="18">18</option><option value="19">19</option><option value="20">20</option>
<option value="21">21</option><option value="22">22</option><option value="23">23</option>
<option value="24">24</option><option value="25">25</option><option value="26">26</option>
<option value="27">27</option><option value="28">28</option><option value="29">29</option>
<option value="30">30</option><option value="31">31</option><option value="32">32</option>
<option value="33">33</option><option value="34">34</option><option value="35">35</option>
<option value="36">36</option><option value="37">37</option><option value="38">38</option>
<option value="39">39</option><option value="40">40</option><option value="41">41</option>
<option value="42">42</option><option value="43">43</option><option value="44">44</option>
<option value="45">45</option><option value="46">46</option><option value="47">47</option>
<option value="48">48</option><option value="49">49</option><option value="50">50</option>
<option value="51">51</option><option value="52">52</option><option value="53">53</option>
<option value="54">54</option><option value="55">55</option><option value="56">56</option>
<option value="57">57</option><option value="58">58</option><option value="59">59</option>
</select>&nbsp; hrs:min:sec
</td>


<td class="bodyText">Stop Time :</td>
<td class="bodyText">
<select name="hours1" id="hours1" class="formElement">
<option value="00">00</option><option value="01">01</option><option value="02">02</option>
<option value="03">03</option><option value="04">04</option><option value="05">05</option>
<option value="06">06</option><option value="07">07</option><option value="08">08</option>
<option value="09">09</option><option value="10">10</option><option value="11">11</option>
<option value="12">12</option><option value="13">13</option><option value="14">14</option>
<option value="15">15</option><option value="16">16</option><option value="17">17</option>
<option value="18">18</option><option value="19">19</option><option value="20">20</option>
<option value="21">21</option><option value="22">22</option><option value="23">23</option>
</select>:
<select name="minutes1" id="minutes1" class="formElement">
<option value="00">00</option><option value="01">01</option><option value="02">02</option>
<option value="03">03</option><option value="04">04</option><option value="05">05</option>
<option value="06">06</option><option value="07">07</option><option value="08">08</option>
<option value="09">09</option><option value="10">10</option><option value="11">11</option>
<option value="12">12</option><option value="13">13</option><option value="14">14</option>
<option value="15">15</option><option value="16">16</option><option value="17">17</option>
<option value="18">18</option><option value="19">19</option><option value="20">20</option>
<option value="21">21</option><option value="22">22</option><option value="23">23</option>
<option value="24">24</option><option value="25">25</option><option value="26">26</option>
<option value="27">27</option><option value="28">28</option><option value="29">29</option>
<option value="30">30</option><option value="31">31</option><option value="32">32</option>
<option value="33">33</option><option value="34">34</option><option value="35">35</option>
<option value="36">36</option><option value="37">37</option><option value="38">38</option>
<option value="39">39</option><option value="40">40</option><option value="41">41</option>
<option value="42">42</option><option value="43">43</option><option value="44">44</option>
<option value="45">45</option><option value="46">46</option><option value="47">47</option>
<option value="48">48</option><option value="49">49</option><option value="50">50</option>
<option value="51">51</option><option value="52">52</option><option value="53">53</option>
<option value="54">54</option><option value="55">55</option><option value="56">56</option>
<option value="57">57</option><option value="58">58</option><option value="59">59</option>
</select>:
<select name="seconds1" id="seconds1" class="formElement">
<option value="00">00</option><option value="01">01</option><option value="02">02</option>
<option value="03">03</option><option value="04">04</option><option value="05">05</option>
<option value="06">06</option><option value="07">07</option><option value="08">08</option>
<option value="09">09</option><option value="10">10</option><option value="11">11</option>
<option value="12">12</option><option value="13">13</option><option value="14">14</option>
<option value="15">15</option><option value="16">16</option><option value="17">17</option>
<option value="18">18</option><option value="19">19</option><option value="20">20</option>
<option value="21">21</option><option value="22">22</option><option value="23">23</option>
<option value="24">24</option><option value="25">25</option><option value="26">26</option>
<option value="27">27</option><option value="28">28</option><option value="29">29</option>
<option value="30">30</option><option value="31">31</option><option value="32">32</option>
<option value="33">33</option><option value="34">34</option><option value="35">35</option>
<option value="36">36</option><option value="37">37</option><option value="38">38</option>
<option value="39">39</option><option value="40">40</option><option value="41">41</option>
<option value="42">42</option><option value="43">43</option><option value="44">44</option>
<option value="45">45</option><option value="46">46</option><option value="47">47</option>
<option value="48">48</option><option value="49">49</option><option value="50">50</option>
<option value="51">51</option><option value="52">52</option><option value="53">53</option>
<option value="54">54</option><option value="55">55</option><option value="56">56</option>
<option value="57">57</option><option value="58">58</option><option value="59">59</option>
</select>&nbsp; hrs:min:sec
</td>

</tr>
<tr>
<td colspan="4" align="center"><input type="Submit" name="Submit" value="Submit" class="formElement"></td>
</tr>
</table>
</form>
<%
}catch(Exception e)
{
	out.print("Exception "+e);
}
finally
{
	conn.close();
}
%>


</td></tr>
</table>

<!-- footer start here -->
<table border="1" width="100%">
<tr ><td bgcolor="white" class="copyright" width="100%">
<center>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</center>
</td></tr>
</table>
<P></P>
</body>
</html>
