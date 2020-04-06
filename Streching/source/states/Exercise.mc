using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.Lang;

module Exercise {
	
	////////////////////////////////////////////////////
	////////////////////// SIGNALS /////////////////////
	////////////////////////////////////////////////////
	
	function signal_Exercise_pause(){
    	LOG("Exercise","signal_Exercise_pause()");
    	
		S_ACTIVITY.pause();
		S_TIMER.pause(TIMER.REP_TIME);
		S_NOTIFY.signal(NOTIFY.STOP);
		
		S_DATA.addExerciseTime(S_TIMER.remove(TIMER.EXERCISE_TIME));
		S_TIMER.schedule(TIMER.PAUSE_TIME, {:callback=>new Lang.Method(Common, :reportPause)});
		
        S_SM.transition(SM.SUMMARY);		
	}
	
	function signal_Exercise_reset(){
    	LOG("Exercise","signal_Exercise_reset()");
    
        S_TIMER.reset(TIMER.REP_TIME,{:period=>S_DATA.getRepetitionInterval()});
        
		S_NOTIFY.signal(NOTIFY.LAP);		
	}
	
	function signal_Exercise_goRest(){
    	LOG("Exercise","signal_Exercise_goRest()");
    	
 		showedExerciseNumber = false;
		S_NOTIFY.signal(NOTIFY.TIMEOUT);
		
		S_DATA.addExerciseTime(S_TIMER.remove(TIMER.EXERCISE_TIME));
		S_TIMER.schedule(TIMER.REST_TIME, {:callback=>new Lang.Method(Common, :reportRest)});
		
		S_SM.transition(SM.REST);	
	}

	////////////////////////////////////////////////////
	////////////////////// \SIGNALS ////////////////////
	////////////////////////////////////////////////////
	
	var exerciseNumberView;
	var exerciseNumberDelegate;
	
	var showedExerciseNumber = false;
	
	class ExerciseView extends WatchUi.View {
	
		function initialize(){
	 		View.initialize();
	 		exerciseNumberView = new ExerciseNumberView();
	 		exerciseNumberDelegate = new WatchUi.InputDelegate();
	 	}
	 	
	 	function onLayout(dc){
	 		setLayout(Rez.Layouts.Exercise(dc));
	 	}
	 	
	 	function onUpdate(dc){
			var time = View.findDrawableById("time");
			time.setText(S_UTILITY.formatTimeNow());
						
			var counterVal = S_TIMER.getRemainingTime(TIMER.REP_TIME);
			var counter = View.findDrawableById("counter");
			counter.setText(S_UTILITY.formatCounter(counterVal));
			
			var hr = View.findDrawableById("hr");
			hr.setText(S_UTILITY.formatNullableData(Sensor.getInfo().heartRate));
			
			View.onUpdate(dc);
			
			dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);    	
	    	dc.setPenWidth(10);
			dc.drawArc(dc.getWidth()/2, dc.getHeight()/2, dc.getWidth()/2, Graphics.ARC_COUNTER_CLOCKWISE, 90, 90 + 360*counterVal/S_DATA.getRepetitionInterval());
	 	}
	 	
	 	function onShow(){
	 		if(S_TIMER.isNotRunning(TIMER.REFRESH_VIEW)){
		 	    S_TIMER.schedule(TIMER.REFRESH_VIEW, {
					:period=>S_DATA.getRefreshPeriod(),
					:callback=>method(:refreshView_callback), 
					:repeat=>true});
			}
			
			if(S_TIMER.isNotRunning(TIMER.REP_TIME)){
				if(S_TIMER.isPaused(TIMER.REP_TIME)){
					S_TIMER.resume(TIMER.REP_TIME);
				} else {
					S_TIMER.schedule(TIMER.REP_TIME, {
						:period=>S_DATA.getRepetitionInterval(),
						:callback=>method(:signal_Exercise_goRest), 
						:repeat=>false});
				}
			}
			
			if(!showedExerciseNumber){
				LOAD("ExerciseNumberView", exerciseNumberView, exerciseNumberDelegate);
			}
	 	}
	 	
	 	function onHide(){
	 		S_TIMER.remove(TIMER.REFRESH_VIEW);
	 	}
	 	
		function refreshView_callback() {
			WatchUi.requestUpdate();
		} 
	}
	
	class ExerciseDelegate extends Common.Delegate {
	
		function initialize(){
	        Delegate.initialize();
	    }
	    
	    function onSelect(){
	    	LOG("Exercise","onSelect()");
			signal_Exercise_pause();
	        return true;
	    }
	    
	    function onBack(){
	    	LOG("Exercise","signal_Exercise_reset()");
			signal_Exercise_reset();
			return true;
	    }
	}
	
	class ExerciseNumberView extends WatchUi.View {
		
		function initialize(){
	 		View.initialize();
	 	}
	 	
	 	function onLayout(dc){
	 		setLayout(Rez.Layouts.ExerciseNumber(dc));
	 	}
	 	
	 	function onShow(){
	 		showedExerciseNumber = true;
	 		S_DATA.addExercise();
	 		S_TIMER.schedule(TIMER.EXERCISE_NUMBER, {
				:period=>S_DATA.getExerciseNumberDisappearPeriod(),
				:callback=>method(:exerciseNumberTimeout_callback), 
				:repeat=>false});
	 	}
	 	
	 	function onUpdate(dc){
	 		var exerciseNumber = View.findDrawableById("exerciseNumber");
			exerciseNumber.setText(S_DATA.getExercise().toString());
	 	
			View.onUpdate(dc);
	 	}
	 	
	 	function exerciseNumberTimeout_callback(){
	 		UNLOAD("ExerciseNumberView");
	 	}
	}
}