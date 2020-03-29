using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

module Rest {
	
	class RestDelegate extends Common.Delegate {
	
		function initialize() {
	        Delegate.initialize();
	    }
	    
	    function onSelect() {
			S_ACTIVITY.pause();
			S_TIMER.pause(TIMER.REP_PAUSE_TIME);
			S_NOTIFY.signal(NOTIFY.STOP);
	        S_SM.transition(SM.SUMMARY);
	        return true;
	    }
	    
	    function onBack() {
			S_ACTIVITY.lap();
			S_TIMER.remove(TIMER.REP_PAUSE_TIME);
			S_NOTIFY.signal(NOTIFY.LAP);
			S_SM.transition(SM.EXERCISE);
			return true;
	    } 
	}
	
	class RestView extends WatchUi.View {
	
		function initialize(){
	 		View.initialize();
	 	}
	 	
	 	function onLayout(dc){
	 		setLayout(Rez.Layouts.Rest(dc));
	 	}
	 	
	 	function onUpdate(dc){
			var time = View.findDrawableById("time");
			time.setText(S_UTILITY.formatTimeNow());
						
			var counterVal = S_TIMER.getElapsedTime(TIMER.REP_PAUSE_TIME);
			var counter = View.findDrawableById("counter");
			counter.setText(S_UTILITY.formatCounter(counterVal));
			
			var hr = View.findDrawableById("hr");
			hr.setText(S_UTILITY.formatNullableData(Sensor.getInfo().heartRate));
			
			View.onUpdate(dc);
	 	}
	 	
	 	function onShow(){
	 		 if(S_TIMER.isNotRunning(TIMER.REFRESH_VIEW)){
		 	    S_TIMER.schedule(TIMER.REFRESH_VIEW, {
					:period=>REFRESH_PERIOD,
					:callback=>method(:refreshView_callback), 
					:repeat=>true});
			}
			
			if(S_TIMER.isNotRunning(TIMER.REP_PAUSE_TIME)){
				if(S_TIMER.isPaused(TIMER.REP_PAUSE_TIME)){
					S_TIMER.resume(TIMER.REP_PAUSE_TIME);
				} else {
					S_TIMER.schedule(TIMER.REP_PAUSE_TIME, {});
				}
			}
	 	}
	 	
	 	function onHide(){
	 		S_TIMER.remove(TIMER.REFRESH_VIEW);
	 	}
	 	
	 	function refreshView_callback() {
			WatchUi.requestUpdate();
		}
	}
}