using Toybox.WatchUi;
using Toybox.Sensor;
using Toybox.Lang;

module Initial{

	////////////////////////////////////////////////////
	////////////////////// SIGNALS /////////////////////
	////////////////////////////////////////////////////
	
	function signal_Initial_start(){
    	LOG("Initial","signal_Initial_start()");
    	
	        S_ACTIVITY.start();
	        S_NOTIFY.signal(NOTIFY.START);
	        
	        S_TIMER.schedule(TIMER.EXERCISE_TIME, {:callback=>new Lang.Method(Common, :reportExcercise)});
	        
	        S_SM.transition(SM.EXERCISE);	
	}

	////////////////////////////////////////////////////
	////////////////////// \SIGNALS ////////////////////
	////////////////////////////////////////////////////
	
	class InitialDelegate extends Common.Delegate{
	
		function initialize(){
	        Delegate.initialize();
	    }
	    
	    function onSelect(){
	    	LOG("Initial","InitialDelegate.onSelect()");
	        
	        signal_Initial_start();
	        return true;
	    }
	    
	    function onBack(){
	    	LOG("Initial","InitialDelegate.onBack()");
	    	System.exit();
	    }
	}
	
	class InitialView extends WatchUi.View{

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
			counter.setText(S_UTILITY.formatCounter(S_CONFIG.getRepetitionInterval()));
			
			var hr = View.findDrawableById("hr");
			var info = Sensor.getInfo();
			hr.setText(S_UTILITY.formatNullableData(Sensor.getInfo().heartRate));

			View.onUpdate(dc);
	 	}
	 	
	 	function onShow(){
	 		LOG("Initial","InitialView.onShow()");
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