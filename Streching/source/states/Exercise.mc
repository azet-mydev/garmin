using Toybox.WatchUi;
using Toybox.Graphics;

module Exercise {

	var exerciseNumberView;
	var exerciseNumberDelegate;
	
	var showedExerciseNumber = false;

	class ExerciseDelegate extends Common.Delegate {
	
		function initialize(){
	        Delegate.initialize();
	    }
	    
	    function onSelect(){
	    	LOG("ExerciseDelegate","Invoking onSelect()");
	    	
			S_ACTIVITY.pause();
			S_TIMER.pause(TIMER.REP_TIME);
			S_NOTIFY.signal(NOTIFY.STOP);
	        S_SM.transition(SM.SUMMARY);
	        return true;
	    }
	    
	    function onBack(){
	    	LOG("ExerciseDelegate","Invoking onBack()");
	    
	        S_TIMER.reset(TIMER.REP_TIME,{:period=>S_DATA.getRepetitionInterval()});
	        
			S_NOTIFY.signal(NOTIFY.LAP);
			return true;
	    }
	}
	
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
						:callback=>method(:repTime_callback), 
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
	 	
	 	function repTime_callback() {
	 		showedExerciseNumber = false;
			S_NOTIFY.signal(NOTIFY.TIMEOUT);
			S_SM.transition(SM.REST);
		}
		
		function refreshView_callback() {
			WatchUi.requestUpdate();
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
	 		S_DATA.setExerciseNumber(S_DATA.getExerciseNumber()+1);
	 		S_TIMER.schedule(TIMER.EXERCISE_NUMBER, {
				:period=>S_DATA.getExerciseNumberDisappearPeriod(),
				:callback=>method(:exerciseNumberTimeout_callback), 
				:repeat=>false});
	 	}
	 	
	 	function onUpdate(dc){
	 		var exerciseNumber = View.findDrawableById("exerciseNumber");
			exerciseNumber.setText(S_DATA.getExerciseNumber().toString());
	 	
			View.onUpdate(dc);
	 	}
	 	
	 	function exerciseNumberTimeout_callback(){
	 		UNLOAD("ExerciseNumberView");
	 	}
	}
}