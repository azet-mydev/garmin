using Toybox.WatchUi;
using Toybox.System;

module Initial {
	
	class InitialDelegate extends WatchUi.BehaviorDelegate{
	
		function initialize() {
	        BehaviorDelegate.initialize();
	    }
	    
	    function onSelect() {
	        S_ACTIVITY.start();
	        S_NOTIFY.signal(NOTIFY.START);
	        S_SM.transition(SM.EXERCISE);
	        return true;
	    }
	    
	    function onMenu() {
            var settingsMenu = new WatchUi.Menu2({:title=>Rez.Strings.settings});
            for( var i = 0; i < S_DATA.cfg.keys().size(); i += 1 ) {
            	var cfgKey = S_DATA.cfg.keys()[i];
            	var cfg = S_DATA.cfg.get(cfgKey);
            	settingsMenu.addItem(new ToggleMenuItem(cfg.get(:name), null, cfgKey, cfg.get(:value), {}));
            }
	        WatchUi.pushView(settingsMenu, new SettingsMenuDelegate(), SCREEN_TRANSITION);
	        return true;
	    }
	}
	
	class InitialView extends WatchUi.View {
	 	
		function initialize(){
	 		View.initialize();
	 	}
	 	
	 	function onLayout(dc){
	 		setLayout(Rez.Layouts.Initial(dc));
//	 		WatchUi.animate( View.findDrawableById("counter"), :locX, WatchUi.ANIM_TYPE_LINEAR, -100, dc.getWidth() + 50, 1, null );
	 	}
	 	
	 	function onUpdate(dc){
			var time = View.findDrawableById("time");
			time.setText(S_UTILITY.formatTimeNow());
			
			var counter = View.findDrawableById("counter");
			counter.setText(S_UTILITY.formatCounter(REP_PERIOD));
			
			var hr = View.findDrawableById("hr");
			hr.setText(S_UTILITY.formatNullableData(Sensor.getInfo().heartRate));

			View.onUpdate(dc);
	 	}
	 	
	 	function onShow(){
	 		Sensor.enableSensorEvents(method(:onSensor_callback));
	 	}
	 	
	 	function onHide(){
	 		Sensor.enableSensorEvents(null);
	 	}
	 	
	 	function onSensor_callback(info){
			WatchUi.requestUpdate();
		}
	}
	
	class SettingsMenuDelegate extends WatchUi.Menu2InputDelegate {
	
	    function initialize() {
	        Menu2InputDelegate.initialize();
	    }
	    
	    function onSelect(item) {
	    	S_DATA.cfg.get(item.getId()).put(:value, item.isEnabled());
		}
	}
}