<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
  <title>Driving Directions in Virtual Earth</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <script type="text/javascript" src="http://dev.virtualearth.net/mapcontrol/mapcontrol.ashx?v=6.1"></script>

<script>
    var map = null;
    var popuplat;
  var popuplon;
  var startpt = null;
  var endpt = null;
  var flag=true;
  var options = new VERouteOptions();
  options.RouteCallback = onGotRoute;
  function OnPageLoad()
  {
    map = new VEMap('myMap');
    map.LoadMap(new VELatLong(19.041348796589013, 72.861328125), 13, 'r', false);
    map.SetScaleBarDistanceUnit(VEDistanceUnit.Kilometers);
    map.AttachEvent("onclick", MouseHandler);

  }
function MouseHandler(e)
      {		
	if (e.rightMouseButton)
	{
        if(flag)
	{      
		if(confirm("This is your Start Point?"))
			{
				flag=false;
				startpt = map.PixelToLatLong(new VEPixel(e.mapX, e.mapY));
	        	       	var pin = new VEPushpin('Start', startpt, null, 'pin', 'Starting Point');
				map.AddPushpin(pin);		
			}
		
	}
	else
	{	
		if(confirm("This is your End Point?"))
			{
				endpt = map.PixelToLatLong(new VEPixel(e.mapX, e.mapY));
	        	       	var pin = new VEPushpin('end', endpt, null, 'pin', 'end');
				map.AddPushpin(pin);
			}
	}
	}
}
      
 
function GetDirections()
  {
    	var options = new VERouteOptions();
  	options.RouteCallback = onGotRoute;
	options.DistanceUnit=VERouteDistanceUnit.Kilometer;
	map.GetDirections([startpt, endpt], 
                               options);
  }
function drow()
{
	GetDirections();
}
function onGotRoute(route)
         {
           // Unroll route
           var legs     = route.RouteLegs;
           var turns    = "Total distance: " + route.Distance.toFixed(1) + " km\n";
           var numTurns = 0;
           var leg      = null;

           // Get intermediate legs
            for(var i = 0; i < legs.length; i++)
            {
               // Get this leg so we don't have to derefernce multiple times
               leg = legs[i];  // Leg is a VERouteLeg object
                  
               // Unroll each intermediate leg
               var turn = null;  // The itinerary leg
                  
               for(var j = 0; j < leg.Itinerary.Items.length; j ++)
               {
                  turn = leg.Itinerary.Items[j];  // turn is a VERouteItineraryItem object
                  numTurns++;
                  turns += numTurns + ".\t" + turn.Text + " (" + turn.Distance.toFixed(1) + " km)\n<br>";
               }
            }
		document.getElementById("discription").innerHTML=turns;
            //alert(turns);
         }
function clearmap()
{
	 map.DeleteRoute();
	map.DeletePushpin("end");
	map.DeletePushpin("Start");
	flag=true;
}
function printit()
{
window.print();
}
</script>
</head>
<body onload="OnPageLoad();">
<table border="1" width="100%">
<tr><td><table border="1" width="100%">
<tr><td><input type="button" name="Draw Route" value="Draw Route" onclick="drow();" class="formElement"></td><td><input type="button" name="Delete Route" Value="Delete Route" onclick="clearmap();" class="formElement"></td><td><input type="button" name="Print" Value="Print" onclick="printit();" class="formElement"></td></tr>
</table></td></tr>
<tr><td><div id="myMap" style="position:relative;width:950px;height:450px;"></div></td></tr>
<tr><td valing="top"><div id="discription"></div></td></tr>
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
