<%@ page language="java" import="org.springframework.security.ui.AbstractProcessingFilter,org.springframework.security.ui.webapp.AuthenticationProcessingFilter,org.springframework.security.ui.savedrequest.SavedRequest,org.springframework.security.AuthenticationException,org.pentaho.platform.uifoundation.component.HtmlComponent,org.pentaho.platform.engine.core.system.PentahoSystem,org.pentaho.platform.util.messages.LocaleHelper,org.pentaho.platform.api.engine.IPentahoSession,org.pentaho.platform.web.http.WebTemplateHelper,org.pentaho.platform.api.engine.IUITemplater,org.pentaho.platform.web.jsp.messages.Messages,java.util.List,java.util.ArrayList,java.util.StringTokenizer,org.apache.commons.lang.StringEscapeUtils,org.pentaho.platform.web.http.PentahoHttpSessionHelper" %>
<%
            // If the User is already logged in redirect to PUC Home
            String remoteUser = request.getRemoteUser();
            if (remoteUser != null && remoteUser != "") {
                response.sendRedirect("/pentaho/Home");
            }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
    <head>
        <title>Login to BI Tool - FleetView User Console</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="gwt:property" content="locale=<%=request.getLocale()%>">
        <!-- Uncomment to put your own favicon
        <link rel="shortcut icon" href="/pentaho-style/favicon.ico" /> -->
        <style type="text/css" media="screen, projection">
            *{margin:0;padding:0;}
            html{font-size:100%;}
            body{background:#fff;color:#222;font-family:"Helvetica Neue", Arial, Helvetica, sans-serif;text-align:center;font-size:75%;}
            h2{font-size:2em;margin-bottom:0.75em;}
            .error{background:#FBE3E4;border:2px solid #FBC2C4;color:#8a1f11;margin-bottom:1em;text-align:center;width:332px;padding:6px;}
            #login-logo{padding:40px 0;}
            #login-form{background:#fff;border:1px solid #ccc;text-align:left;width:350px;-moz-border-radius:5px;-webkit-border-radius:5px;-moz-box-shadow:0 1px 3px #ddd;-webkit-box-shadow:0 1px 3px #ddd;margin:0 auto;padding:15px 15px 25px;}
            #login-form h2{text-align:center;padding:5px 0;}
            #login-form .field{width:335px;margin:15px 0;}
            #login-form .field label{color:#777;display:block;font-size:1em;font-weight:700;margin-bottom:5px;text-align:left;}
            #login-form .field input{border:1px solid #ccc;font-size:1.2em;width:100%;padding:5px;}
        </style>
        <script type="text/javascript">
            // If the Username and Password values are blank then alert();
            // This can be replaced with an AJAX solution
            function checkForm(form) {
                if(form.j_username.value == "" && form.j_password.value == "") {
                    alert('You can not have a blank Username and Password!')
                    return false;
                }
            }
        </script>
    </head>
    <body>
        <!-- Login Logo -->
        <div id="login-logo">
            <img src="/sw-style/active/sw_logo.png" alt="Trans Logo">
        </div>
        <!-- Login Form -->
        <table>
        <tr><td>
        <table>
        <tr><td bgcolor="#E6E6E0">
	<div id="login-logo1"><img src="/sw-style/active/logo2.jpg" alt="Trans Logo1">
</div>	
	</td></tr>
        <tr>
        <td>
        
        <div id="login-form">
            <!-- Header -->
            <h2>Login To Transworld BI Tool</h2>
            <!-- If the login_error URL parameter is set then show error box -->
            <% if (request.getParameter("login_error") != null) {%>
            <div class="error">Authentication failed! Please try again!</div>
            <% }%>
            <!-- Form -->
            <form id="sw-login" method="POST" action="/pentaho/j_spring_security_check">
                <!-- Username -->
                <div class="field">
                    <label for="username">Username</label>
                    <input id="username" name="j_username" type="text">
                </div>
                <!-- Password -->
                <div class="field">
                    <label for="password">Password</label>
                    <input id="password" name="j_password" type="password">
                </div>
                <!-- On click on the submit button run the checkFrom function -->
                <input type="submit" value="Login" onclick="return checkForm(form);">
            </form>
        </div>
        </td>
        </tr>
        <tr><td align="left"><font size="0.5" face="arial" color="darkred">	Helpline	</font></td>	</tr>
		<tr><td align="left"><font size="0.5" face="arial" color="#C94093"> Phone  :	+9120-41214444 </font></td></tr>
		<tr><td align="left"><font size="0.5" face="arial" color="#C94093"> Mobile :	+919321424980 </font></td></tr>
		<tr><td align="left"><font size="0.5" face="arial" color="#C94093"> Contact:	 Ajay Laddha </font></td></tr>
		<tr><td align="left"><font size="0.5" face="arial" color="#C94093"> Email  :	avlsupport@mobile-eye.in</a> </font></td></tr>
		<tr><td align="left"><font size="0.5" face="arial" color="#C94093"> Contact Time:	09:30 am to 06:30 pm </font></td></tr>
	
        </table>
        </td>
        <td>
        <table>
        	<tr><td>
        		<font size="2" face="arial" color="#053A7D">Embrace Life - watch this fantastic video</font>
      	<object width="873" height="525">
      	<param name="movie" value="http://www.youtube.com/v/zmGzStrFsOc&hl=en_US&fs=1&rel=0&color1=0x2b405b&color2=0x6b8ab6&border=1"></param>
      	<param name="allowFullScreen" value="true"></param>
      	<param name="allowscriptaccess" value="always"></param>
      	<embed src="http://www.youtube.com/v/zmGzStrFsOc&hl=en_US&fs=1&rel=0&color1=0x2b405b&color2=0x6b8ab6&border=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="510" height="410"></embed>
      	</object>
        	</td></tr>
        </table>
        </td>
        </tr>
        </table>
    </body>
</html>

