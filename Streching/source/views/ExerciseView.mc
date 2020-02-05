using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Graphics;

class ExerciseView extends WatchUi.View {
 	
	function initialize(){
 		View.initialize();
 	}
 	
 	function onUpdate(dc){
 	    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
    	dc.clear();
    	
    	var counter = $.s.get(S.TIMER).getCounter(TimerSrvc.REP_TIME);
        if(counter==null){
        	counter = 0;
        }
    	
    	dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_BLACK);    	
    	dc.setPenWidth(dc.getWidth()/20);
    	dc.drawArc(dc.getWidth()/2, dc.getHeight()/2, dc.getWidth()/2, Graphics.ARC_COUNTER_CLOCKWISE, 90, 90 + 360*counter/REP_PERIOD);
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    	 
		var posX = dc.getWidth() / 2;
		
		var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
		var time = Lang.format("$1$:$2$", [today.hour,today.min.format("%02d")]);
        var timePosY = dc.getFontHeight(Graphics.FONT_MEDIUM)/2;        
        dc.drawText(posX, timePosY, Graphics.FONT_MEDIUM, time, Graphics.TEXT_JUSTIFY_CENTER);
        

        var minutes = counter/60.toNumber();
        var seconds = counter % 60;  
        var myTime = Lang.format("$1$:$2$", [minutes, seconds.format("%02d")]);   
		var counterPosY = dc.getHeight() / 2 - dc.getFontHeight(Graphics.FONT_NUMBER_THAI_HOT)/2;
		dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_BLACK);   
        dc.drawText(posX, counterPosY, Graphics.FONT_NUMBER_THAI_HOT, myTime, Graphics.TEXT_JUSTIFY_CENTER);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK); 
        
        var heartRate = Sensor.getInfo().heartRate;
        var hrPosY = dc.getHeight() - dc.getFontHeight(Graphics.FONT_MEDIUM) - dc.getFontHeight(Graphics.FONT_MEDIUM)/2;        
        dc.drawText(posX, hrPosY, Graphics.FONT_MEDIUM, heartRate, Graphics.TEXT_JUSTIFY_CENTER);
 	}
}