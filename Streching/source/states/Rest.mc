using Toybox.WatchUi;
using Toybox.Lang;

module Rest{

	////////////////////////////////////////////////////
	////////////////////// SIGNALS /////////////////////
	////////////////////////////////////////////////////
	
	function signal_Rest_pause(){
    	LOG("Rest","signal_Rest_pause()");
    	
		S_ACTIVITY.pause();
		S_TIMER.pause(TIMER.REP_PAUSE_TIME);
		S_NOTIFY.signal(NOTIFY.STOP);
		
		S_DATA.addRestTime(S_TIMER.remove(TIMER.REST_TIME));
		S_TIMER.schedule(TIMER.PAUSE_TIME, {});
		
        S_SM.transition(SM.SUMMARY);		
	}
	
	function signal_Rest_nextExercise(){
	    LOG("Rest","signal_Rest_nextExercise()");
    	
		S_ACTIVITY.lap();
		S_TIMER.remove(TIMER.REP_PAUSE_TIME);
		S_NOTIFY.signal(NOTIFY.LAP);
		
		S_DATA.addRestTime(S_TIMER.remove(TIMER.REST_TIME));
		S_TIMER.schedule(TIMER.EXERCISE_TIME, {:callback=>new Lang.Method(Common, :reportExcercise)});
		
		S_SM.transition(SM.EXERCISE);
	}

	////////////////////////////////////////////////////
	////////////////////// \SIGNALS ////////////////////
	////////////////////////////////////////////////////	
	
	class RestView extends WatchUi.View{
	
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
					:period=>S_CONFIG.getRefreshPeriod(),
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
	
	class RestDelegate extends Common.Delegate{
	
		function initialize(){
	        Delegate.initialize();
	    }
	    
	    function onSelect(){
	    	LOG("Rest","onSelect()");
			signal_Rest_pause();			
	        return true;
	    }
	    
	    function onBack(){
	    	LOG("Rest","onBack()");
			signal_Rest_nextExercise();
			return true;
	    } 
	}	
}