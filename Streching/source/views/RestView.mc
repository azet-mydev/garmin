//using Toybox.WatchUi;
//using Toybox.Time;
//using Toybox.Time.Gregorian;
// 
//class RestView extends WatchUi.View {
//
//	function initialize(){
// 		View.initialize();
// 	}
// 	
// 	function onUpdate(dc){
// 	    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
//    	dc.clear();
//    	dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
//    	 
//		var posX = dc.getWidth() / 2;
//		
//		var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
//		var time = Lang.format("$1$:$2$", [today.hour,today.min.format("%02d")]);
//        var timePosY = dc.getFontHeight(Graphics.FONT_MEDIUM)/2;        
//        dc.drawText(posX, timePosY, Graphics.FONT_MEDIUM, time, Graphics.TEXT_JUSTIFY_CENTER);
//        
//        var timer = S_TIMER.getElapsedTime(TIMER.REP_PAUSE_TIME);
//        var minutes = timer/60.toNumber();
//        var seconds = timer % 60;  
//        var myTime = Lang.format("$1$:$2$", [minutes, seconds.format("%02d")]);   
//		var counterPosY = dc.getHeight() / 2 - dc.getFontHeight(Graphics.FONT_NUMBER_THAI_HOT)/2;
//		dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_WHITE);   
//        dc.drawText(posX, counterPosY, Graphics.FONT_NUMBER_THAI_HOT, myTime, Graphics.TEXT_JUSTIFY_CENTER);  
//        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
//        
//        var heartRate = Sensor.getInfo().heartRate;
//        var hrPosY = dc.getHeight() - dc.getFontHeight(Graphics.FONT_MEDIUM) - dc.getFontHeight(Graphics.FONT_MEDIUM)/2;        
//        dc.drawText(posX, hrPosY, Graphics.FONT_MEDIUM, heartRate, Graphics.TEXT_JUSTIFY_CENTER);
// 	}
// 	
// 	function onShow(){
// 	    S_TIMER.schedule(TIMER.REFRESH_VIEW, {
//        												:period=>REFRESH_PERIOD,
//														:callback=>method(:refreshView_callback), 
//														:repeat=>true
//														});
//		if(!S_TIMER.resume(TIMER.REP_PAUSE_TIME)){											 
//			S_TIMER.schedule(TIMER.REP_PAUSE_TIME, {});
//		}								
// 	}
// 	
// 	function onHide(){
// 		S_TIMER.remove(TIMER.REFRESH_VIEW);
// 	}
// 	
// 	function refreshView_callback() {
//		WatchUi.requestUpdate();
//	}
//}