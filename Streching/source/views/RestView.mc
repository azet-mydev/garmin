using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;
 
class RestView extends WatchUi.View {
 	
	function initialize(){
 		View.initialize();
 	}
 	
// 	function onUpdate(dc){
// 	    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
//    	dc.clear(); 
//		var x = dc.getWidth() / 2;
//		var y = dc.getHeight() / 2 - dc.getFontHeight(Graphics.FONT_MEDIUM);\
//		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
//		dc.drawText(x, y, Graphics.FONT_MEDIUM, "RestView", Graphics.TEXT_JUSTIFY_CENTER);
//		
//		var heartRate = Sensor.getInfo().heartRate;
//        y += dc.getFontHeight(Graphics.FONT_MEDIUM);        
//        dc.drawText(x, y, Graphics.FONT_MEDIUM, heartRate, Graphics.TEXT_JUSTIFY_CENTER);
//        
//       	var timer = $.s.get(S.TIMER).getTimer(TimerSrvc.REP_PAUSE_TIME);
//        y += dc.getFontHeight(Graphics.FONT_MEDIUM);        
//        dc.drawText(x, y, Graphics.FONT_MEDIUM, timer, Graphics.TEXT_JUSTIFY_CENTER);
// 	}
 	
 	function onUpdate(dc){
 	    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
    	dc.clear();
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    	 
		var posX = dc.getWidth() / 2;
		
		var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
		var time = Lang.format("$1$:$2$", [today.hour,today.min.format("%02d")]);
        var timePosY = dc.getFontHeight(Graphics.FONT_MEDIUM)/2;        
        dc.drawText(posX, timePosY, Graphics.FONT_MEDIUM, time, Graphics.TEXT_JUSTIFY_CENTER);
        
        var counter = $.s.get(S.TIMER).getTimer(TimerSrvc.REP_PAUSE_TIME);
        if(counter==null){
        	counter = 0;
        }
        var minutes = counter/60.toNumber();
        var seconds = counter % 60;  
        var myTime = Lang.format("$1$:$2$", [minutes, seconds.format("%02d")]);   
		var counterPosY = dc.getHeight() / 2 - dc.getFontHeight(Graphics.FONT_NUMBER_THAI_HOT)/2;   
        dc.drawText(posX, counterPosY, Graphics.FONT_NUMBER_THAI_HOT, myTime, Graphics.TEXT_JUSTIFY_CENTER);  
        
        var heartRate = Sensor.getInfo().heartRate;
        var hrPosY = dc.getHeight() - dc.getFontHeight(Graphics.FONT_MEDIUM) - dc.getFontHeight(Graphics.FONT_MEDIUM)/2;        
        dc.drawText(posX, hrPosY, Graphics.FONT_MEDIUM, heartRate, Graphics.TEXT_JUSTIFY_CENTER);
 	}
}