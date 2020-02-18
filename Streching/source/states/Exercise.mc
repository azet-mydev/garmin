using Toybox.WatchUi;
using Toybox.Graphics;

module Exercise {

	var exerciseNumberView;
	var exerciseNumberDelegate;
	
	var showedExerciseNumber = false;

	class ExerciseDelegate extends WatchUi.BehaviorDelegate {
	
		function initialize(){
	        BehaviorDelegate.initialize();
	    }
	    
	    function onSelect(){
			S_ACTIVITY.pause();
			S_TIMER.pause(TIMER.REP_TIME);
			S_NOTIFY.signal(NOTIFY.STOP);
	        S_SM.transition(SM.SUMMARY);
	        return true;
	    }
	    
	    function onBack(){
	        S_TIMER.reset(TIMER.REP_TIME);
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
			dc.drawArc(dc.getWidth()/2, dc.getHeight()/2, dc.getWidth()/2, Graphics.ARC_COUNTER_CLOCKWISE, 90, 90 + 360*counterVal/REP_PERIOD);
	 	}
	 	
	 	function onShow(){
	 	    S_TIMER.schedule(TIMER.REFRESH_VIEW, {
				:period=>REFRESH_PERIOD,
				:callback=>method(:refreshView_callback), 
				:repeat=>true});
				
			if(!S_TIMER.resume(TIMER.REP_TIME) && !S_TIMER.isRunning(TIMER.REP_TIME)){											 
		        S_TIMER.schedule(TIMER.REP_TIME, {
					:period=>REP_PERIOD,
					:callback=>method(:repTime_callback), 
					:repeat=>false});
			}
			
			if(!showedExerciseNumber){
				WatchUi.pushView(exerciseNumberView, exerciseNumberDelegate, SCREEN_TRANSITION);
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
			S_DATA.exerciseNumber++; 	
	 		S_TIMER.schedule(TIMER.EXERCISE_NUMBER, {
				:period=>EXERCISE_NUMBER_PERIOD,
				:callback=>method(:exerciseNumberTimeout_callback), 
				:repeat=>false});
	 	}
	 	
	 	function onUpdate(dc){
	 		var exerciseNumber = View.findDrawableById("exerciseNumber");
			exerciseNumber.setText(S_DATA.exerciseNumber.toString());
	 	
			View.onUpdate(dc);
	 	}
	 	
	 	function exerciseNumberTimeout_callback(){
	 		WatchUi.popView(SCREEN_TRANSITION);
	 	}
	}
}