//using Toybox.WatchUi;
//using Toybox.Timer;
//using Toybox.Attention;
//
//const REFRESH_PERIOD = 1000;
//
//var activityControl = new ActivityControl();
//var refreshTimer = new Timer.Timer();
//var timerCount = 0;
//
//    function onRefreshTimer() {
//        WatchUi.requestUpdate();
//        timerCount++;
//        if(timerCount == 5){
//        	refreshTimer.stop();
//        	    var toneProfile =
//				    [
//				        new Attention.ToneProfile( 2500, 250),
//				        new Attention.ToneProfile( 5000, 250),
//				        new Attention.ToneProfile(10000, 250),
//				        new Attention.ToneProfile( 5000, 250),
//				        new Attention.ToneProfile( 2500, 250),
//				    ];
//    		Attention.playTone(Attention.TONE_LOUD_BEEP);
//		    var vibeData =
//		    [
//		        new Attention.VibeProfile(50, 2000), // On for two seconds
//		        new Attention.VibeProfile(0, 2000),  // Off for two seconds
//		        new Attention.VibeProfile(50, 2000), // On for two seconds
//		        new Attention.VibeProfile(0, 2000),  // Off for two seconds
//		        new Attention.VibeProfile(50, 2000)  // on for two seconds
//		    ];
//			Attention.vibrate(vibeData);
//			Attention.backlight(true);
//        }
//    }
//
//class StrechingDelegate extends WatchUi.BehaviorDelegate {
//
//    function initialize() {
//        BehaviorDelegate.initialize();
//    }
//
//    function onSelect() {
////        WatchUi.pushView(new Rez.Menus.MainMenu(), new StrechingMenuDelegate(), WatchUi.SLIDE_UP);
//
//		if (!activityControl.isRecording()){
//			activityControl.start();
//			refreshTimer.start(method(:onRefreshTimer), REFRESH_PERIOD, true);
//		} else{
//			activityControl.stop();
//			refreshTimer.stop();
//		}
//		refreshView();
//        return true;
//    }
//    
//    function onBack() {
//    	if(activityControl.isRecording()){
//    		activityControl.lap();
//    		timerCount = 0;
//    		refreshTimer.start(method(:onRefreshTimer), REFRESH_PERIOD, true);
//    	} else{
//    		return false;
//    	}
//    	refreshView();
//    	return true;
//    }
//    
//    function refreshView(){
//    	WatchUi.requestUpdate();
//    }
//}
//
//class StrechingView extends WatchUi.View {
//
//	//Const 
//	const RECORDING = "Recording...";
//	const NOT_RECORDING = "Start recording";
//
//    function initialize() {
//        View.initialize();
//    }
//
//    // Load your resources here
//    function onLayout(dc) {
////        setLayout(Rez.Layouts.MainLayout(dc));
//    }
//
//    // Called when this View is brought to the foreground. Restore
//    // the state of this View and prepare it to be shown. This includes
//    // loading resources into memory.
//    function onShow() {
//    }
//
//    // Update the view
//    function onUpdate(dc) {
//    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
//    	dc.clear(); 
////    	dc.fillCircle(dc.getWidth()/2, dc.getHeight()/2, dc.getWidth()/2 - dc.getFontHeight(Graphics.FONT_MEDIUM))
//    
//		var x = dc.getWidth() / 2;
//		var y = dc.getHeight() / 2 - dc.getFontHeight(Graphics.FONT_MEDIUM);
//		
//        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
//        
//        var isRecordingText;
//        if(activityControl.isRecording()){
//        	isRecordingText = RECORDING;
//        } else{
//        	isRecordingText = NOT_RECORDING;
//        }
//        dc.drawText(x, y, Graphics.FONT_MEDIUM, isRecordingText, Graphics.TEXT_JUSTIFY_CENTER);
//        
//        var heartRate = Sensor.getInfo().heartRate;
//        y += dc.getFontHeight(Graphics.FONT_MEDIUM);        
//        dc.drawText(x, y, Graphics.FONT_MEDIUM, heartRate, Graphics.TEXT_JUSTIFY_CENTER);
//        
//        y += dc.getFontHeight(Graphics.FONT_MEDIUM);        
//        dc.drawText(x, y, Graphics.FONT_MEDIUM, timerCount, Graphics.TEXT_JUSTIFY_CENTER);
//    }
//
//    // Called when this View is removed from the screen. Save the
//    // state of this View here. This includes freeing resources from
//    // memory.
//    function onHide() {
//    	refreshTimer.stop();
//    }
//    
//}
