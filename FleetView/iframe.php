<html>
<body>

<?php 

$url = fsockopen("www.google.com", 80, &$errno, &$errstr, 30); 
if(!$url) { 
//site is down 
echo "<b>Google is <font color=\"red\">down!!</font></b>\n"; } 
//site is up 
else 
{ 
echo("<a href=\"http://www.google.com\">Google</a>"); 
} 

?>

<iframe id="myframe"
src ="http://192.168.1.11:8080/AVL/onlinedata.jsp"
width="99%" height="99%" scrolling="auto">
</iframe>
</body>
</html>
