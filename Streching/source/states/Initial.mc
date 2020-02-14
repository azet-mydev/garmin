using Toybox.WatchUi;

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
	}
	
	class InitialView extends WatchUi.View {
	 	
		function initialize(){
	 		View.initialize();
	 	}
	 	
	 	function onLayout(dc){
	 		setLayout(Rez.Layouts.Initial(dc));
	 	}
	 	
	 	function onUpdate(dc){
			var time = View.findDrawableById("time");
			time.setText(S_UTILITY.formatTimeNow());
			
			var counter = View.findDrawableById("counter");
			counter.setText(S_UTILITY.formatCounter(REP_PERIOD));
			
			var hr = View.findDrawableById("hr");
			hr.setText(S_UTILITY.formatData(Sensor.getInfo().heartRate));

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