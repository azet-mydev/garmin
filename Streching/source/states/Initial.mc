using Toybox.WatchUi;
using Toybox.Sensor;

module Initial {
	
	class InitialDelegate extends Common.Delegate {
	
		function initialize() {
	        Delegate.initialize();
	    }
	    
	    function onSelect() {
	    	LOG("InitialDelegate","Invoking onSelect()");
	        
	        S_ACTIVITY.start();
	        S_NOTIFY.signal(NOTIFY.START);
	        S_SM.transition(SM.EXERCISE);
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
			counter.setText(S_UTILITY.formatCounter(S_DATA.cfg.get(CFG.REPETITION_INTERVAL).get(:value)));
			
			var hr = View.findDrawableById("hr");
			var info = Sensor.getInfo();
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
}