<HTML>
<HEAD>
<link href="css/css.css" rel="StyleSheet" type="text/css">
<Script Language="JavaScript">
 function winclose()
    {
      window.close()
    }
</script>
<SCRIPT LANGUAGE=JavaScript TYPE=text/javascript>
function calcCharLeft() {
	clipped = false
	lenUSig = 0
	maxLength = 500
        if (document.emailarticle.msg.value.length > maxLength) { 
	        document.emailarticle.msg.value = document.emailarticle.msg.value.substring(0,maxLength)
		charleft = 0
		clipped = true
        } else {
		charleft = maxLength - document.emailarticle.msg.value.length
	}
        document.emailarticle.msgCL.value = charleft
        return clipped
}
function textKey() {
	supportsKeys = true
	calcCharLeft()
}
function validate()
{
	if(document.emailarticle.to.value == "")
	{
		alert("The \"To\" fiels cannot be blank");
		return false;
	}
	else if(document.emailarticle.sender.value == "")
	{
		alert("Your Email address cannot be left blank");
		return false;
	}
	
	else
	{
		document.emailarticle.submit();
	}
}
</script>

<TITLE>Email this Article</TITLE>

</HEAD>
<body leftmargin="15" topmargin="15" link="#0066CC" bgcolor="#ffffff"  LINK=#0066FF ALINK=#003399 VLINK=#666EB3>
<FORM NAME=emailarticle METHOD=GET ACTION="/cgi-bin/utilities/sendarticle.cgi">
<TABLE BORDER=0 WIDTH=100%>
<TR>
<TD COLSPAN=2>
<HR NOSHADE SIZE=1>
</TD>
</TR>
<TR>
<TD COLSPAN=2>
<TABLE WIDTH=400 CELLSPACING=0 CELLPADDING=0 BORDER=0>
<TR>
<TD COLSPAN=3 HEIGHT=25><FONT CLASS=sb1>Seperate multiple addresses with commas(,) <FONT COLOR=red>*</FONT> Required</FONT></TD>
</TR>
<TR>
<TD WIDTH=60 HEIGHT=30><FONT CLASS=sb1>To:</FONT></TD>
<TD WIDTH=180><INPUT TYPE=text NAME=to VALUE="" SIZE=25>
<INPUT TYPE=hidden NAME=docpath VALUE="<%=GetRequest($package_name)%>"></TD>
<INPUT TYPE=hidden NAME=url VALUE="http://www.rediff.com/cricket/2008/aug/24sld1.htm" SIZE=25></TD>
<TD WIDTH=160><FONT CLASS=sb1 COLOR=red>*</FONT></TD>
</TR>
<TR>
<TD WIDTH=60 HEIGHT=30><FONT CLASS=sb1>Bcc:</FONT></TD>

<TD WIDTH=340 COLSPAN=2><INPUT TYPE=text NAME=bcc VALUE="" SIZE=25></TD>
<TD WIDTH=60 HEIGHT=30><FONT CLASS=sb1>Your Email:</FONT></TD>
<TD WIDTH=180><INPUT TYPE=text NAME=sender VALUE="" SIZE=25></TD>
<TD WIDTH=160><FONT CLASS=sb1 COLOR=red>*</FONT></TD>
</TR>
<TR>
<TD COLSPAN=3 HEIGHT=5></TD>
</TR>
</TABLE>


</TR>
</TD>

<TR>
<TD>
<input type=button value="Email this Article" OnClick="validate()">
</TD>

<TD ALIGN=right>
<INPUT TYPE=button NAME="OK" VALUE="Cancel" Onclick=self.close()>

</TD>
</TR>

<TR>
<TD COLSPAN=2>


<HR NOSHADE="noshade" size="1">

<FONT CLASS=sb1>This information entered on this page will not be used to send unsolicited email,<BR>
and will not be sold to a 3rd party.</FONT><BR>

<HR NOSHADE="noshade" size="1">




<CENTER>Copyright &copy; 2008 by Transworld 
                          Compressor Technologies Ltd. All Rights Reserved.</CENTER>
</TD>
</TR>


</TABLE>
</FORM>
</BODY>
</HTML>	

