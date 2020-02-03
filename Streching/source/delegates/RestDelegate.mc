using Toybox.WatchUi;

class RestDelegate extends WatchUi.BehaviorDelegate {

	function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
    	$.activityControl.pause();
    	$.timerService.pause();
        $.stateMachine.transition(StateMachine.SELECT);
        return true;
    }
    
    function onBack() {
    	$.activityControl.lap();
    	$.timerService.registerCallback(TimerService.REP_TIME, REP_PERIOD, method(:repTime_callback), false);
		$.stateMachine.transition(StateMachine.BACK);
		return true;
    }
    
    function repTime_callback() {
		$.timerService.registerTimer(TimerService.REP_PAUSE_TIME);
		$.stateMachine.transition(StateMachine.EXERCISE_TIMEOUT);
	}  
   
}