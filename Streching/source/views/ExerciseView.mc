 using Toybox.WatchUi;
 
 class ExerciseView extends WatchUi.View {
 	
 	function initialize(){
 		View.initialize();
 	}
 	
 	function onUpdate(dc){
 	    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
    	dc.clear(); 
		var x = dc.getWidth() / 2;
		var y = dc.getHeight() / 2 - dc.getFontHeight(Graphics.FONT_MEDIUM);\
		dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
		dc.drawText(x, y, Graphics.FONT_MEDIUM, "ExerciseView", Graphics.TEXT_JUSTIFY_CENTER);
 	}
 }