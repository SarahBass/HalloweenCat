import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Weather;
import Toybox.Activity;
import Toybox.ActivityMonitor;
import Toybox.Time.Gregorian;

class VirtualPetNothingView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }


    function onLayout(dc as Dc) as Void {
        //setLayout(Rez.Layouts.WatchFace(dc));
    }

 
    function onShow() as Void {
    }

    
    function onUpdate(dc as Dc) as Void {
        var mySettings = System.getDeviceSettings();
       var myStats = System.getSystemStats();
       var info = ActivityMonitor.getInfo();
       var timeFormat = "$1$:$2$";
       var clockTime = System.getClockTime();
       var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
              var hours = clockTime.hour;
               if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else {   
                timeFormat = "$1$:$2$";
                hours = hours.format("%02d");  
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);
        var weekdayArray = ["Day", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"] as Array<String>;
        var monthArray = ["Month", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"] as Array<String>;
        var monthArraySQ = ["Month", "Jan", "Feb", "March", "April", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"] as Array<String>;
 var userBattery = "-";
   if (myStats.battery != null){userBattery = Lang.format("$1$",[((myStats.battery.toNumber())).format("%2d")]);}else{userBattery="-";} 

   var userSTEPS = 0;
   if (info.steps != null){userSTEPS = info.steps.toNumber();}else{userSTEPS=0;} 

  var userNotify = "-";
   if (mySettings.notificationCount != null){userNotify = Lang.format("$1$",[((mySettings.notificationCount.toNumber())).format("%2d")]);}else{userNotify="-";} 

var userAlarm = "-";
   if (mySettings.alarmCount != null){userAlarm = Lang.format("$1$",[((mySettings.alarmCount.toNumber())).format("%2d")]);}else{userAlarm="-";} 

     var userCAL = 0;
   if (info.calories != null){userCAL = info.calories.toNumber();}else{userCAL=0;}  
   

    var timeStamp= new Time.Moment(Time.today().value());
   var getCC = Toybox.Weather.getCurrentConditions();
    var TEMP = "--";
    var FC = "-";
     if(getCC != null && getCC.temperature!=null){     
        if (System.getDeviceSettings().temperatureUnits == 0){  
    FC = "C";
    TEMP = getCC.temperature.format("%d");
    }else{
    TEMP = (((getCC.temperature*9)/5)+32).format("%d"); 
    FC = "F";   
    }}
     else {TEMP = "--";}
    
    var cond;
    if (getCC != null){ cond = getCC.condition.toNumber();}
    else{cond = 0;}//sun
    
var positions;
        if (Toybox.Weather.getCurrentConditions().observationLocationPosition == null){
        positions=new Position.Location( 
    {
        :latitude => 33.684566,
        :longitude => -117.826508,
        :format => :degrees
    }
    );
    }else{
      positions= Toybox.Weather.getCurrentConditions().observationLocationPosition;
    }
    
  

  var sunrise = Time.Gregorian.info(Toybox.Weather.getSunrise(positions, timeStamp), Time.FORMAT_MEDIUM);
        
	var sunriseHour;
  if (Toybox.Weather.getSunrise(positions, timeStamp) == null){sunriseHour = 6;}
    else {sunriseHour= sunrise.hour;}
         if (!System.getDeviceSettings().is24Hour) {
            if (sunriseHour > 12) {
                sunriseHour = (sunriseHour - 12).abs();
            }
        } else {
           
                timeFormat = "$1$:$2$";
                sunriseHour = sunriseHour.format("%02d");
        }
        
    var sunset;
    var sunsetHour;
    sunset = Time.Gregorian.info(Toybox.Weather.getSunset(positions, timeStamp), Time.FORMAT_MEDIUM);
    if (Toybox.Weather.getSunset(positions, timeStamp) == null){sunsetHour = 6;}
    else {sunsetHour= sunset.hour ;}
        
	
         if (!System.getDeviceSettings().is24Hour) {
            if (sunsetHour > 12) {
                sunsetHour = (sunsetHour - 12).abs();
            }
        } else {
            
                timeFormat = "$1$:$2$";
                sunsetHour = sunsetHour.format("%02d");
        }


   //Get and show Heart Rate Amount

var userHEART = "--";
if (getHeartRate() == null){userHEART = "--";}
else if(getHeartRate() == 255){userHEART = "--";}
else{userHEART = getHeartRate().toString();}

       var centerX = (dc.getWidth()) / 2;
       var centerY = (dc.getHeight()) / 2;


       var ghost1 = dogPhase3(today.sec, today.min); 
       var ghost2 = dogPhase4(today.sec, today.min); 
       var stars1 = dogPhase5(today.sec); 
       var stars2 = dogPhase6(today.sec); 
       var frog = dogPhase7(today.sec); 
          var owl = dogPhase8(today.sec); 
             var bat = dogPhase9(today.sec); 
             var candy = dogPhase10(today.sec); 
             var apple = dogPhase11(today.sec); 
       var dog = dogPhase(today.sec, today.min);
       var object = dogPhase2(today.sec, today.min);
       var smallFont =  WatchUi.loadResource( Rez.Fonts.WeatherFont );
       var wordFont =  WatchUi.loadResource( Rez.Fonts.smallFont );
       var LargeFont =  WatchUi.loadResource( Rez.Fonts.WeatherFont );
       var small =  WatchUi.loadResource( Rez.Fonts.smallFont );
       var xsmall =  WatchUi.loadResource( Rez.Fonts.xsmallFont );
       var flash = centerY*1.8;
       var water = centerY*1.25;
      View.onUpdate(dc);
   
   
   //Sky
   dc.setColor(0xC508C4, Graphics.COLOR_TRANSPARENT);
   if (mySettings.screenShape == 1){
   dc.fillCircle(centerX, centerX, centerX);}
   else{dc.fillRectangle(0, 0, centerX*2,centerY*2) ;}
   
   //moon
   dc.setColor(0xDF0BBA, Graphics.COLOR_TRANSPARENT);
   dc.fillEllipse(centerX*0.9, centerY*0.6, centerX*0.7, centerX*0.6);
   dc.setColor(0xEE748B, Graphics.COLOR_TRANSPARENT);
   dc.fillCircle(centerX*0.9, centerY*0.6, centerX*0.5);
   dc.setColor(0xF49B7B, Graphics.COLOR_TRANSPARENT);
   dc.fillCircle(centerX*0.9, centerY*0.6, centerX*0.4);


dc.setColor(0xE7A8FF, Graphics.COLOR_TRANSPARENT);
   //right clouds
   dc.fillEllipse((centerX*1.9)-((today.sec%3)), (centerY*0.75)-((today.sec%3)),  (centerX/3), (centerY/4)); 
   dc.fillEllipse((centerX*1.6)-((today.sec%3)), (centerY*0.8)-((today.sec%3)),  (centerX/4), (centerY/6)); 

//left clouds
   dc.fillEllipse((centerX*0.05)+((today.sec%2)), (centerY*0.8)-((today.sec%3)),  (centerX/6), (centerY/6)); 
   dc.fillEllipse((centerX*0.25)+((today.sec%2)), (centerY*0.9)-((today.sec%3)),  (centerX/5), (centerY/5));
   dc.fillEllipse((centerX*-0.01)+((today.sec%2)), (centerY*0.9)-((today.sec%3)),  (centerX/3), (centerY/5));
   
   
   dc.setColor(0xF6E3FD, Graphics.COLOR_TRANSPARENT);
   //right clouds
   dc.fillEllipse((centerX*1.9)-((today.sec%3)), (centerY*0.75)-((today.sec%3)),  (centerX/4), (centerY/5)); 
   dc.fillEllipse((centerX*1.6)-((today.sec%3)), (centerY*0.8)-((today.sec%3)),  (centerX/5), (centerY/7)); 

   //left clouds
   dc.fillEllipse((centerX*0.05)+((today.sec%2)), (centerY*0.8)-((today.sec%3)),  (centerX/7), (centerY/7)); 
   dc.fillEllipse((centerX*0.25)+((today.sec%2)), (centerY*0.9)-((today.sec%3)),  (centerX/6), (centerY/6));
   dc.fillEllipse((centerX*-0.01)+((today.sec%2)), (centerY*0.9)-((today.sec%3)),  (centerX/4), (centerY/6));
   if (userSTEPS>=3000){}else{
 //right bubble
   dc.fillCircle((centerX*1.75)-(((today.sec%40)*4)^2), (centerY*0.25)+(today.sec%10),  (centerX/20));  
  //Left bubble
   dc.fillCircle((centerX*0.25)+((today.sec%30)*4), (centerY*0.5)-((today.sec%30)*4),  (centerX/30));  
   dc.fillCircle((centerX/4)+(((today.sec%60)*4)^2), (centerY*0.25)+(today.sec%60),  (centerX/15));  
   }
   //BG Water
   dc.setColor(0x7C03B1, Graphics.COLOR_TRANSPARENT);
   dc.fillEllipse(centerX/7, (water)+((today.sec%4)*4), (centerX*3)/4, (centerY/3));
   dc.fillEllipse((centerX*1.5)-((today.sec%4)*4), (water*1.2)-((today.sec%4)*4),  (centerX), (centerY/2)); 
   dc.fillEllipse((centerX*0.7)+((today.sec%4)*4), (water*1.2)-((today.sec%4)*4),  (centerX), (centerY/2)); 
   dc.fillEllipse((centerX*2), ((water*15)/16)+((today.sec%4)*4), (centerX*3)/4, (centerY/3)); 

//BG water line
   dc.setColor(0x43025C, Graphics.COLOR_TRANSPARENT);
   dc.fillEllipse(centerX/7, (water*1.05)+((today.sec%4)*4), (centerX*3)/4, (centerY/3));
   dc.fillEllipse((centerX*1.5)-((today.sec%4)*4), (water*1.25)-((today.sec%4)*4),  (centerX), (centerY/2)); 
   dc.fillEllipse((centerX*0.7)+((today.sec%4)*4), (water*1.25)-((today.sec%4)*4),  (centerX), (centerY/2)); 
   dc.fillEllipse((centerX*1.8), (water*1.05)+((today.sec%4)*4), (centerX*3)/4, (centerY/3)); 

   //Foreground Water
   dc.setColor(0x270135, Graphics.COLOR_TRANSPARENT);
   dc.fillEllipse(centerX/4, ((water*5)/4)+((today.sec%3)*2), (centerX*5)/4, (centerY/2)); 
   dc.fillEllipse((centerX*6)/4, ((water*5)/4)+(today.sec%3), (centerX*6)/4, (centerY/2)); 
   dc.fillEllipse(centerX, water*2, (centerX*6)/4, (centerY/2)); 


if (userSTEPS>=3000){}else{
//bubbles
   dc.setColor(0xE7A8FF, Graphics.COLOR_TRANSPARENT);
   dc.fillCircle((centerX*0.25)+((today.sec%4)*4), (centerY*1.5)-((today.sec%40)*4),  (centerY/30));  
   dc.fillCircle((centerX*1.7)+(((today.sec%4)*4)^2), (centerY*1.7)-(today.sec%40)*4,   (centerY/15)); 
   dc.fillCircle((centerX*1.5)+((today.sec%4)*4), (centerY*2)-((today.sec%40)*4), (centerY/10)-((today.sec%10)*4));  
   dc.fillCircle((centerX*0.3)-(today.sec%4), (centerY*1.5)-(((today.sec%40)*4)^2), (centerY/40));  
   dc.fillCircle((centerX*0.1)+((today.sec%4)*4), (centerY*1.2)-((today.sec%30)*4), (centerY/15)-((today.sec%5)*4));  
}
  if (System.getDeviceSettings().screenHeight < 301){
    wordFont =  WatchUi.loadResource( Rez.Fonts.xsmallFont );
    dc.setColor(0xA0DF6A, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX,centerY*1.45,xsmall,(weekdayArray[today.day_of_week]+" , "+ monthArray[today.month]+" "+ today.day +" " +today.year), Graphics.TEXT_JUSTIFY_CENTER );
        dc.setColor(0xFFFFFF, Graphics.COLOR_TRANSPARENT);
       dc.drawText(centerX,  centerY*0.87,LargeFont, timeString,  Graphics.TEXT_JUSTIFY_CENTER  );
       dc.setColor(0x2AFA3F, Graphics.COLOR_TRANSPARENT);
if (today.sec%20==0 || today.sec%20==1 || today.sec%20==2 ){ 
  dc.setColor(0x2AFA3F, Graphics.COLOR_TRANSPARENT);
dc.drawText( centerX,  centerY*1.7, small,  (" ! "), Graphics.TEXT_JUSTIFY_RIGHT );
dc.drawText( centerX, centerY*1.7, wordFont,  (""+userBattery), Graphics.TEXT_JUSTIFY_LEFT );}

else if (today.sec%20==3 || today.sec%20==4 || today.sec%20==5 ){
  dc.setColor(0xF49B7B, Graphics.COLOR_TRANSPARENT);
dc.drawText( centerX,  centerY*1.7, small,  (" ^ "), Graphics.TEXT_JUSTIFY_RIGHT );
dc.drawText( centerX, centerY*1.7, wordFont,  (""+userCAL), Graphics.TEXT_JUSTIFY_LEFT );}
else if (today.sec%20==6 ||today.sec%20==7 || today.sec%20==8  ){  
  dc.setColor(0xE7A8FF, Graphics.COLOR_TRANSPARENT);
dc.drawText(centerX, centerY*1.7, small, " % ",Graphics.TEXT_JUSTIFY_RIGHT);      
dc.drawText(centerX, centerY*1.7, wordFont, userHEART, Graphics.TEXT_JUSTIFY_LEFT ); }
else if (today.sec%20==9 ||today.sec%20==10 || today.sec%20==11 || today.sec%20==12 || today.sec%20==13  ){  
dc.setColor(0xFFFF35, Graphics.COLOR_TRANSPARENT);   
dc.drawText(centerX, centerY*1.7, small, " a ",Graphics.TEXT_JUSTIFY_LEFT); 
dc.drawText(centerX, centerY*1.65, xsmall, "          "+userAlarm+"          ", Graphics.TEXT_JUSTIFY_LEFT );     
dc.setColor(0xFFB200, Graphics.COLOR_TRANSPARENT);  
dc.drawText(centerX, centerY*1.7, small, " a ",Graphics.TEXT_JUSTIFY_RIGHT); 
dc.drawText(centerX, centerY*1.65, xsmall, "          "+userNotify+"          ", Graphics.TEXT_JUSTIFY_RIGHT );  }
else{
  dc.setColor(0xEE748B, Graphics.COLOR_TRANSPARENT);
dc.drawText(centerX, centerY*1.7, small, (" a "), Graphics.TEXT_JUSTIFY_RIGHT );
  dc.drawText(centerX, centerY*1.7, wordFont, (""+userSTEPS), Graphics.TEXT_JUSTIFY_LEFT );}

  }else{
      if (userSTEPS>=3000){dc.setColor(0xFDF6FD, Graphics.COLOR_TRANSPARENT);}else{dc.setColor(0xFF6E3FD, Graphics.COLOR_TRANSPARENT);}
       dc.drawText(centerX,  centerY*1.35,LargeFont, timeString,  Graphics.TEXT_JUSTIFY_CENTER  );
       dc.setColor(0xFFE900, Graphics.COLOR_TRANSPARENT);
       if ( (System.getDeviceSettings().screenHeight <= 360) && (today.month == 9 || today.month == 11|| today.month == 12) ){dc.drawText(centerX,centerY*1.3,wordFont,(weekdayArray[today.day_of_week]+" , "+ monthArraySQ[today.month]+" "+ today.day +" " +today.year), Graphics.TEXT_JUSTIFY_CENTER );}else{dc.drawText(centerX,centerY*1.3,wordFont,(weekdayArray[today.day_of_week]+" , "+ monthArray[today.month]+" "+ today.day +" " +today.year), Graphics.TEXT_JUSTIFY_CENTER );} 
       

if (today.sec%20==0 ||today.sec%20==1){
dc.setColor(0xFFB200, Graphics.COLOR_TRANSPARENT);
dc.drawText(centerX*0.9, centerY*1.75, smallFont, "b",Graphics.TEXT_JUSTIFY_RIGHT);
dc.drawText(centerX*0.9, flash, wordFont, (sunriseHour + ":" + sunrise.min.format("%02u")+"AM"), Graphics.TEXT_JUSTIFY_LEFT );     

}else if (today.sec%20==2 ||today.sec%20==3){
dc.setColor(0xFFB200, Graphics.COLOR_TRANSPARENT);
dc.drawText(centerX*0.9, centerY*1.75, smallFont, "b",Graphics.TEXT_JUSTIFY_RIGHT);
dc.drawText(centerX*0.9, flash, wordFont, (sunsetHour + ":" + sunset.min.format("%02u")+"PM"), Graphics.TEXT_JUSTIFY_LEFT); 
}
else if (today.sec%20==4 || today.sec%20==5|| today.sec%20==6){  
  dc.setColor(0xFF6CFC, Graphics.COLOR_TRANSPARENT);
dc.drawText(centerX*0.95, centerY*1.75, smallFont, weather(cond),Graphics.TEXT_JUSTIFY_RIGHT);      
dc.drawText(centerX, flash, wordFont, " "+TEMP+" "+FC, Graphics.TEXT_JUSTIFY_LEFT );}  
else if (today.sec%20==7 ||today.sec%20==8 || today.sec%20==9){ 
dc.setColor(0xFFB200, Graphics.COLOR_TRANSPARENT);   
dc.drawText(centerX, flash, small, " a ",Graphics.TEXT_JUSTIFY_LEFT); 
dc.drawText(centerX, centerY*1.75, xsmall, "          "+userAlarm+"          ", Graphics.TEXT_JUSTIFY_LEFT );     
dc.setColor(0xFFFF35, Graphics.COLOR_TRANSPARENT);  
dc.drawText(centerX, flash, small, " a ",Graphics.TEXT_JUSTIFY_RIGHT); 
dc.drawText(centerX, centerY*1.75, xsmall, "          "+userNotify+"          ", Graphics.TEXT_JUSTIFY_RIGHT );}  
else{
  
  if (today.sec%8 == 0||today.sec%8 == 1){
  dc.setColor(0xF49B7B, Graphics.COLOR_TRANSPARENT);
dc.drawText( centerX, flash, wordFont,  (" ^ "+userCAL), Graphics.TEXT_JUSTIFY_CENTER );
  }else if (today.sec%8 == 2 ||today.sec%8 == 3){
  dc.setColor(0xE7A8FF, Graphics.COLOR_TRANSPARENT);
dc.drawText( centerX, flash, wordFont,  (" ! "+userBattery), Graphics.TEXT_JUSTIFY_CENTER );}
else if (today.sec%8 == 4 || today.sec%8 == 5){ 
dc.setColor(0xDF0BBA, Graphics.COLOR_TRANSPARENT);     
dc.drawText(centerX, flash, wordFont, " % "+userHEART, Graphics.TEXT_JUSTIFY_CENTER ); 
}else{
  dc.setColor(0xEE748B, Graphics.COLOR_TRANSPARENT);
  dc.drawText(centerX, flash, wordFont, (" a "+userSTEPS), Graphics.TEXT_JUSTIFY_CENTER );}
}


}
//use userSTEPS >= 0 for testing, userSTEPS >= 3000
       if (userSTEPS >= 3000){ 
        object.draw(dc); 
      
if (System.getDeviceSettings().screenHeight < 301){}else{      
        stars1.draw(dc);
        stars2.draw(dc);}


if (today.min%30 == 0|| (today.min%30 == 1)|| (today.min%30 == 2)|| (today.min%30 == 3)){
frog.draw(dc);}
 
if (today.min%30 == 10|| (today.min%30 == 11)|| (today.min%30 == 12)|| (today.min%30 == 13)){
owl.draw(dc);}

if (today.min%30 == 20|| (today.min%30 == 21)|| (today.min%30 == 22)|| (today.min%30 == 23)){
candy.draw(dc);}

if (today.min%30 == 26|| (today.min%30 == 27)|| (today.min%30 == 28)|| (today.min%30 == 29)){
apple.draw(dc);}

}else{
dog.draw(dc);
if (System.getDeviceSettings().screenHeight < 301){

if ((today.min%20 == 0)|| (today.min%20 == 1)|| (today.min%20 == 2)|| (today.min%20 == 3)|| (today.min%20 == 4)|| (today.min%20 == 5)){
bat.draw(dc);}

}else{   
if ((today.min%20 == 0)|| (today.min%20 == 1)|| (today.min%20 == 2)|| (today.min%20 == 3)|| (today.min%20 == 4)|| (today.min%20 == 5)){
ghost1.draw(dc);
ghost2.draw(dc);}
}

}     
        
    }


    function onHide() as Void { }

    
    function onExitSleep() as Void {}

    
    function onEnterSleep() as Void {}

function weather(cond) {
  if (cond == 0 || cond == 40){return "b";}//sun
  else if (cond == 50 || cond == 49 ||cond == 47||cond == 45||cond == 44||cond == 42||cond == 31||cond == 27||cond == 26||cond == 25||cond == 24||cond == 21||cond == 18||cond == 15||cond == 14||cond == 13||cond == 11||cond == 3){return "a";}//rain
  else if (cond == 52||cond == 20||cond == 2||cond == 1){return "e";}//cloud
  else if (cond == 5 || cond == 8|| cond == 9|| cond == 29|| cond == 30|| cond == 33|| cond == 35|| cond == 37|| cond == 38|| cond == 39){return "g";}//wind
  else if (cond == 51 || cond == 48|| cond == 46|| cond == 43|| cond == 10|| cond == 4){return "i";}//snow
  else if (cond == 32 || cond == 37|| cond == 41|| cond == 42){return "f";}//whirlwind 
  else {return "c";}//suncloudrain 
}


private function getHeartRate() {
  // initialize it to null
  var heartRate = null;

  // Get the activity info if possible
  var info = Activity.getActivityInfo();
  if (info != null) {
    heartRate = info.currentHeartRate;
  } else {
    // Fallback to `getHeartRateHistory`
    var latestHeartRateSample = ActivityMonitor.getHeartRateHistory(1, true).next();
    if (latestHeartRateSample != null) {
      heartRate = latestHeartRateSample.heartRate;
    }
  }

  // Could still be null if the device doesn't support it
  return heartRate;
}







function dogPhase(seconds, minutes){
  var mySettings = System.getDeviceSettings();
 var growX = 1; //0.75 for grow large 1.25 for shrink small 1 for normal or square
var growY = 1;
var size = 0;
//var speed =1;     
      if (System.getDeviceSettings().screenHeight == 218){
        size =1;
        growX=1.2;
        //speed = 0.6;
        growY=1.1;
      } else if (System.getDeviceSettings().screenHeight == 260){
        size =1;
        growX=1.4;
        //speed = 0.6;
        growY=1.5;
      }else if (System.getDeviceSettings().screenHeight > 360 && System.getDeviceSettings().screenHeight < 415){
        size=2;
        growX=0.7;
        //speed = 1.25;
        growY=0.1;
      }else if (System.getDeviceSettings().screenHeight == 416){
        size=2;
        growX=0.8;
        //speed = 1.25;
        growY=0.6;
      }else if (System.getDeviceSettings().screenHeight == 454){
          size=2;
        growX=0.8;
        //speed = 1.25;
        growY=0.6;
      }else if (mySettings.screenShape != 1){
        size=0;
        growX=0.5;
        //speed = 0.9;
        growY=0.5;
      }else{
        size=0;
        growX=0.8;
        //speed =1;
        growY=0.7;
      }
  var venus2X = mySettings.screenWidth *0.17*growX;
 //if (seconds>=35){venus2X=mySettings.screenHeight *0.17*growX;}else {if(seconds>=25){venus2X=(mySettings.screenWidth*2.5)-((seconds%35)*25*speed);}else{venus2X=(mySettings.screenWidth)-((seconds%35)*25*speed);}}
  var venus2Y =  mySettings.screenHeight *0.1*growY ;
  var dogARRAY;
if (size == 1){
 dogARRAY = [
(new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.SMALLDog0,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.SMALLDog1,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.SMALLDog2,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.SMALLDog3,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.SMALLDog4,
            :locX=> venus2X,
            :locY=>venus2Y
        }))
 ];
}
else if (size == 2){     
   dogARRAY = [
(new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.BIGDog0,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.BIGDog1,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.BIGDog2,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.BIGDog3,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.BIGDog4,
            :locX=> venus2X,
            :locY=>venus2Y
        }))
 ];      
}
else {
   dogARRAY = [
(new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.Dog0,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.Dog1,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.Dog2,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.Dog3,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.Dog4,
            :locX=> venus2X,
            :locY=>venus2Y
        }))
 ]; 
}
return dogARRAY[seconds%2+minutes%4];
}


function dogPhase2(seconds, minutes){
  var mySettings = System.getDeviceSettings();
 var growX = 1; //0.75 for grow large 1.25 for shrink small 1 for normal or square
var growY = 1;
var size = 0;
//var speed =1;     
      if (System.getDeviceSettings().screenHeight == 218){
        size =1;
        growX=1.2;
        //speed = 0.6;
        growY=1.1;
      } else if (System.getDeviceSettings().screenHeight == 260){
        size =1;
        growX=1.4;
        //speed = 0.6;
        growY=1.5;
      }else if (System.getDeviceSettings().screenHeight > 360 && System.getDeviceSettings().screenHeight < 415){
        size=2;
        growX=0.7;
        //speed = 1.25;
        growY=0.1;
      }else if (System.getDeviceSettings().screenHeight == 416){
        size=2;
        growX=0.8;
        //speed = 1.25;
        growY=0.5;
      }else if (System.getDeviceSettings().screenHeight == 454){
        size=2;
        growX=0.8;
        //speed = 1.25;
        growY=0.6;
      }else if (mySettings.screenShape != 1){
        size=0;
        growX=0.5;
        //speed = 0.9;
        growY=0.5;
      }else{
        size=0;
        growX=0.8;
        //speed =1;
        growY=0.7;
      }
  var venus2X = mySettings.screenWidth *0.17*growX;
 //if (seconds>=35){venus2X=mySettings.screenHeight *0.17*growX;}else {if(seconds>=25){venus2X=(mySettings.screenWidth*2.5)-((seconds%35)*25*speed);}else{venus2X=(mySettings.screenWidth)-((seconds%35)*25*speed);}}
  var venus2Y =  mySettings.screenHeight *0.1 *growY ;
  var dogARRAY;
if (size == 1){
 dogARRAY = [
(new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.sunsmall,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.monsmall,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.tuessmall,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.wedsmall,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.monsmall,
            :locX=> venus2X,
            :locY=>venus2Y
        }))
 ];
}
else if (size == 2){     
   dogARRAY = [
(new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.sunbig,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.monbig,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.tuesbig,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.wedbig,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.sunbig,
            :locX=> venus2X,
            :locY=>venus2Y
        }))
 ];      
}
else {
   dogARRAY = [
(new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.sun,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.mon,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.tues,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.wed,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.sun,
            :locX=> venus2X,
            :locY=>venus2Y
        }))
 ]; 
}
return dogARRAY[seconds%2+minutes%4];
}

function dogPhase3(seconds, minutes){
  var mySettings = System.getDeviceSettings();
 var growX = 1; //0.75 for grow large 1.25 for shrink small 1 for normal or square
var growY = 1;
//var size = 0;
var speed =1;     
      if (System.getDeviceSettings().screenHeight < 301){
        //size =1;
        growX=1.2;
        speed = 0.6;
        growY=1.2;
      }else if (System.getDeviceSettings().screenHeight >= 390){
        //size=2;
        growX=0.7;
        speed = 1.25;
        growY=1.7;
      }else if (mySettings.screenShape != 1){
        //size=0;
        growX=0.5;
        speed = 0.9;
        growY=0.5;
      }else{
        //size=0;
        growX=0.8;
        speed =1;
        growY=1.2;
      }
  var venus2Y;
  var venus2X=mySettings.screenWidth *0.03*growX;
if (seconds>=35){venus2Y=mySettings.screenHeight *0.17*growY;}else {if(seconds>=25){venus2Y=(mySettings.screenHeight*2.5)-((seconds%35)*25*speed);}else{venus2Y=(mySettings.screenHeight)-((seconds%35)*25*speed);}}
  
  var dogARRAY;

 dogARRAY = [
(new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.ghost0,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.ghost0A,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.ghost1,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.ghost1A,
            :locX=> venus2X,
            :locY=>venus2Y
        }))
 ];


return dogARRAY[seconds%2+minutes%3];
}

function dogPhase4(seconds, minutes){
  var mySettings = System.getDeviceSettings();
 var growX = 1; //0.75 for grow large 1.25 for shrink small 1 for normal or square
var growY = 1;
//var size = 0;
var speed =1;     
      if (System.getDeviceSettings().screenHeight < 301){
       // size =1;
        growX=1.2;
        speed = 0.6;
        growY=1.2;
      }else if (System.getDeviceSettings().screenHeight >= 390){
       // size=2;
        growX=0.9;
        speed = 1.25;
        growY=1.7;
      }else if (mySettings.screenShape != 1){
       // size=0;
        growX=0.8;
        speed = 0.9;
        growY=0.5;
      }else{
       // size=0;
        growX=0.8;
        speed =1;
        growY=1.2;
      }
var venus2Y;
  var venus2X=mySettings.screenWidth *0.85*growX;
if (seconds>=35){venus2Y=mySettings.screenHeight *0.17*growY;}else {if(seconds>=25){venus2Y=(mySettings.screenHeight*2.5)-((seconds%35)*25*speed);}else{venus2Y=(mySettings.screenHeight)-((seconds%35)*25*speed);}}
  var dogARRAY;

 dogARRAY = [
(new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.ghost2,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.ghost2A,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.ghost3,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.ghost3A,
            :locX=> venus2X,
            :locY=>venus2Y
        }))
 ];


return dogARRAY[seconds%2+minutes%3];
}


function dogPhase5(seconds){
  var mySettings = System.getDeviceSettings();
 var growX = 1; //0.75 for grow large 1.25 for shrink small 1 for normal or square
var growY = 1;
//var size = 0;
//var speed =1;     
      if (System.getDeviceSettings().screenHeight < 301){
        //size =1;
        growX=0.5;
        //speed = 0.6;
        growY=0.4;
      }else if (System.getDeviceSettings().screenHeight >= 390){
        growX=0.7;
        //speed = 1.25;
        growY=1.2;
      }else if (mySettings.screenShape != 1){
        //size=0;
        growX=0.5;
        //speed = 0.9;
        growY=0.5;
      }else{
        //size=0;
        growX=0.8;
        //speed =1;
        growY=1.2;
      }
var venus2Y=mySettings.screenHeight *0.2*growY;
  var venus2X=mySettings.screenWidth *0.07*growX;
  var dogARRAY;

 dogARRAY = [
(new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.stars0,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.stars1,
            :locX=> venus2X,
            :locY=>venus2Y
        }))
 ];


return dogARRAY[seconds%2];
}

function dogPhase6(seconds){
  var mySettings = System.getDeviceSettings();
 var growX = 1; //0.75 for grow large 1.25 for shrink small 1 for normal or square
var growY = 1;
//var size = 0;
//var speed =1;     
      if (System.getDeviceSettings().screenHeight < 301){
       // size =1;
        growX=0.7;
        //speed = 0.6;
        growY=0.3;
      }else if (System.getDeviceSettings().screenHeight >= 390){
        growX=0.9;
        //speed = 1.25;
        growY=1.2;
      }else if (mySettings.screenShape != 1){
       // size=0;
        growX=0.8;
        //speed = 0.9;
        growY=0.5;
      }else{
       // size=0;
        growX=0.8;
        //speed =1;
        growY=1.2;
      }
var venus2Y=mySettings.screenHeight *0.17*growY;
  var venus2X=mySettings.screenWidth *0.9*growX;
  var dogARRAY;

 dogARRAY = [
(new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.stars0,
            :locX=> venus2X,
            :locY=>venus2Y
        })),
        (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.stars1,
            :locX=> venus2X,
            :locY=>venus2Y
        }))
 ];


return dogARRAY[seconds%2];
}

function dogPhase7(seconds){
  var mySettings = System.getDeviceSettings();
 var growX = 1; //0.75 for grow large 1.25 for shrink small 1 for normal or square
var growY = 1;
//var size = 0;
var speed =1;     
      if (System.getDeviceSettings().screenHeight < 301){
       // size =1;
        growX=0.8;
        speed = 0.6;
        growY=1;
      }else if (System.getDeviceSettings().screenHeight >= 390){
        //size=2;
        growX=0.7;
        speed = 1.25;
        growY=growX*growX;
      }else if (mySettings.screenShape != 1){
        //size=0;
        growX=0.8;
        speed = 0.9;
        growY=0.5;
      }else{
        //size=0;
        growX=0.8;
        speed =1;
        growY=1.2;
      }
var venus2X;
 if (seconds>=35){venus2X = (mySettings.screenHeight *0.75*growX);}else {if(seconds>=25){venus2X=(mySettings.screenWidth*2.5)-((seconds%35)*25*speed);}else{venus2X=(mySettings.screenWidth)-((seconds%35)*25*speed);}}
  var venus2Y =  (mySettings.screenHeight *0.03*growY)+((seconds%2)*2) ;
  var dogARRAY =  (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.frog,
            :locX=> venus2X,
            :locY=>venus2Y
        }));



return dogARRAY;
}


function dogPhase8(seconds){
  var mySettings = System.getDeviceSettings();
 var growX = 1; //0.75 for grow large 1.25 for shrink small 1 for normal or square
var growY = 1;
//var size = 0;
var speed =1;     
      if (System.getDeviceSettings().screenHeight < 301){
       // size =1;
        growX=0.8;
        speed = 0.6;
        growY=1;
      }else if (System.getDeviceSettings().screenHeight >= 390){
        //size=2;
        growX=0.7;
        speed = 1.25;
        growY=growX*growX;
      }else if (mySettings.screenShape != 1){
        //size=0;
        growX=0.8;
        speed = 0.9;
        growY=0.5;
      }else{
        //size=0;
        growX=0.8;
        speed =1;
        growY=1.2;
      }
var venus2X;
 if (seconds>=35){venus2X = (mySettings.screenHeight *0.75*growX);}else {if(seconds>=25){venus2X=(mySettings.screenWidth*2.5)-((seconds%35)*25*speed);}else{venus2X=(mySettings.screenWidth)-((seconds%35)*25*speed);}}
  var venus2Y =  (mySettings.screenHeight *0.03*growY)+((seconds%2)*2) ;
  var dogARRAY =  (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.owl,
            :locX=> venus2X,
            :locY=>venus2Y
        }));



return dogARRAY;
}


function dogPhase9(seconds){
  var mySettings = System.getDeviceSettings();
 var growX = 1; //0.75 for grow large 1.25 for shrink small 1 for normal or square
var growY = 1;
//var size = 0;
var speed =1;     
      if (System.getDeviceSettings().screenHeight < 301){
       // size =1;
        growX=0.8;
        speed = 0.6;
        growY=1;
      }else if (System.getDeviceSettings().screenHeight >= 390){
        //size=2;
        growX=0.7;
        speed = 1.25;
        growY=growX*growX;
      }else if (mySettings.screenShape != 1){
        //size=0;
        growX=0.8;
        speed = 0.9;
        growY=0.5;
      }else{
        //size=0;
        growX=0.8;
        speed =1;
        growY=1.2;
      }
var venus2X;
 if (seconds>=35){venus2X = (mySettings.screenHeight *0.75*growX);}else {if(seconds>=25){venus2X=(mySettings.screenWidth*2.5)-((seconds%35)*25*speed);}else{venus2X=(mySettings.screenWidth)-((seconds%35)*25*speed);}}
  var venus2Y =  (mySettings.screenHeight *0.03*growY)+((seconds%2)*2) ;
  var dogARRAY =  (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.bat,
            :locX=> venus2X,
            :locY=>venus2Y
        }));

return dogARRAY;
}


function dogPhase10(seconds){
  var mySettings = System.getDeviceSettings();
 var growX = 1; //0.75 for grow large 1.25 for shrink small 1 for normal or square
var growY = 1;
//var size = 0;
var speed =1;     
      if (System.getDeviceSettings().screenHeight < 301){
       // size =1;
        growX=0.8;
        speed = 0.6;
        growY=1;
      }else if (System.getDeviceSettings().screenHeight >= 390){
        //size=2;
        growX=0.7;
        speed = 1.25;
        growY=growX*growX;
      }else if (mySettings.screenShape != 1){
        //size=0;
        growX=0.8;
        speed = 0.9;
        growY=0.5;
      }else{
        //size=0;
        growX=0.8;
        speed =1;
        growY=1.2;
      }
var venus2X;
 if (seconds>=35){venus2X = (mySettings.screenHeight *0.75*growX);}else {if(seconds>=25){venus2X=(mySettings.screenWidth*2.5)-((seconds%35)*25*speed);}else{venus2X=(mySettings.screenWidth)-((seconds%35)*25*speed);}}
  var venus2Y =  (mySettings.screenHeight *0.03*growY)+((seconds%2)*2) ;
  var dogARRAY =  (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.candy,
            :locX=> venus2X,
            :locY=>venus2Y
        }));



return dogARRAY;
}


function dogPhase11(seconds){
  var mySettings = System.getDeviceSettings();
 var growX = 1; //0.75 for grow large 1.25 for shrink small 1 for normal or square
var growY = 1;
//var size = 0;
var speed =1;     
      if (System.getDeviceSettings().screenHeight < 301){
       // size =1;
        growX=0.8;
        speed = 0.6;
        growY=1;
      }else if (System.getDeviceSettings().screenHeight >= 390){
        //size=2;
        growX=0.7;
        speed = 1.25;
        growY=growX*growX;
      }else if (mySettings.screenShape != 1){
        //size=0;
        growX=0.8;
        speed = 0.9;
        growY=0.5;
      }else{
        //size=0;
        growX=0.8;
        speed =1;
        growY=1.2;
      }
var venus2X;
 if (seconds>=35){venus2X = (mySettings.screenHeight *0.75*growX);}else {if(seconds>=25){venus2X=(mySettings.screenWidth*2.5)-((seconds%35)*25*speed);}else{venus2X=(mySettings.screenWidth)-((seconds%35)*25*speed);}}
  var venus2Y =  (mySettings.screenHeight *0.03*growY)+((seconds%2)*2) ;
  var dogARRAY =  (new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.apple,
            :locX=> venus2X,
            :locY=>venus2Y
        }));



return dogARRAY;
}

}
