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
    	
    	var timer = S_TIMER.getRemainingTime(TimerSrvc.REP_TIME);
    	
    	dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_BLACK);    	
    	dc.setPenWidth(dc.getWidth()/20);
    	dc.drawArc(dc.getWidth()/2, dc.getHeight()/2, dc.getWidth()/2, Graphics.ARC_COUNTER_CLOCKWISE, 90, 90 + 360*timer/REP_PERIOD);
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    	 
		var posX = dc.getWidth() / 2;
		
		var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
		var time = Lang.format("$1$:$2$", [today.hour,today.min.format("%02d")]);
        var timePosY = dc.getFontHeight(Graphics.FONT_MEDIUM)/2;        
        dc.drawText(posX, timePosY, Graphics.FONT_MEDIUM, time, Graphics.TEXT_JUSTIFY_CENTER);
        

        var minutes = timer/60.toNumber();
        var seconds = timer % 60;  
        var myTime = Lang.format("$1$:$2$", [minutes, seconds.format("%02d")]);   
		var counterPosY = dc.getHeight() / 2 - dc.getFontHeight(Graphics.FONT_NUMBER_THAI_HOT)/2;
		dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_BLACK);   
        dc.drawText(posX, counterPosY, Graphics.FONT_NUMBER_THAI_HOT, myTime, Graphics.TEXT_JUSTIFY_CENTER);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK); 
        
        var heartRate = Sensor.getInfo().heartRate;
        var hrPosY = dc.getHeight() - dc.getFontHeight(Graphics.FONT_MEDIUM) - dc.getFontHeight(Graphics.FONT_MEDIUM)/2;        
        dc.drawText(posX, hrPosY, Graphics.FONT_MEDIUM, heartRate, Graphics.TEXT_JUSTIFY_CENTER);
 	}
 	
 	function onShow(){
 	    S_TIMER.schedule(TimerSrvc.REFRESH_VIEW, {
        												:period=>REFRESH_PERIOD,
														:callback=>method(:refreshView_callback), 
														:repeat=>true
													 });
		if(!S_TIMER.resume(TimerSrvc.REP_TIME)){											 
	        S_TIMER.schedule(TimerSrvc.REP_TIME, {
	        											:period=>REP_PERIOD,
														:callback=>method(:repTime_callback), 
														:repeat=>false
													 });
		}
 	}
 	
 	function onHide(){
 		S_TIMER.remove(TimerSrvc.REFRESH_VIEW);
 	}
 	
 	function repTime_callback() {
		S_SM.transition(SmSrvc.EXERCISE_TIMEOUT);
		S_NOTIFY.signal(NotifySrvc.TIMEOUT);
	}
	
	function refreshView_callback() {
		WatchUi.requestUpdate();
	} 
}