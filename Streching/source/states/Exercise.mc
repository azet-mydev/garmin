using Toybox.WatchUi;
using Toybox.Graphics;

module Exercise {

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
			hr.setText(S_UTILITY.formatData(Sensor.getInfo().heartRate));
			
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
				
			if(!S_TIMER.resume(TIMER.REP_TIME)){											 
		        S_TIMER.schedule(TIMER.REP_TIME, {
					:period=>REP_PERIOD,
					:callback=>method(:repTime_callback), 
					:repeat=>false});
			}
	 	}
	 	
	 	function onHide(){
	 		S_TIMER.remove(TIMER.REFRESH_VIEW);
	 	}
	 	
	 	function repTime_callback() {
			S_NOTIFY.signal(NOTIFY.TIMEOUT);
			S_SM.transition(SM.REST);
		}
		
		function refreshView_callback() {
			WatchUi.requestUpdate();
		} 
	}
}