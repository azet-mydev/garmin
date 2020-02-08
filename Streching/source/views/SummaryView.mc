//using Toybox.WatchUi;
// 
//class SummaryView extends WatchUi.View {
// 	
//	function initialize(){
//		View.initialize();
//	}
// 	
//	function onShow(){
//		if(S_SM.getHistory(-1) != SM.SUMMENU){
//			S_TIMER.schedule(TIMER.SUMMENU_APPEAR, {
//				:period => SUMMENU_APPEAR_PERIOD,
//				:callback => method(:summaryMenu_callback),
//				:repeat => false});
//		}
//	}
// 	
//	function onUpdate(dc){
//		dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
//		dc.clear(); 
//		var x = dc.getWidth() / 2;
//		var y = dc.getHeight() / 2 - dc.getFontHeight(Graphics.FONT_MEDIUM);
//		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
//		dc.drawText(x, y, Graphics.FONT_MEDIUM, "SummaryView", Graphics.TEXT_JUSTIFY_CENTER);
//				
//		var heartRate = Sensor.getInfo().heartRate;
//		y += dc.getFontHeight(Graphics.FONT_MEDIUM);        
//		dc.drawText(x, y, Graphics.FONT_MEDIUM, heartRate, Graphics.TEXT_JUSTIFY_CENTER);
//	}
// 	
//	function summaryMenu_callback(){
//		S_SM.transition(SM.SUMMENU);
//	}
//}