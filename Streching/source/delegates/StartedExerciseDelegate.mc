using Toybox.WatchUi;

class StartedExerciseDelegate extends WatchUi.BehaviorDelegate {

	function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
    	$.activityControl.stop();
        $.stateMachine.transition(StateMachine.STOP);
        return true;
    }
    
    function onBack() {
    	$.activityControl.lap();
    	$.timerService.removeTimer(TimerService.REP_BREAK);
    	$.timerService.registerCallback(TimerService.REP_TIMEOUT, REP_PERIOD, method(:repTimeOut_callback), false);
    	return true;
    }
    
    function repTimeOut_callback() {
		$.timerService.registerTimer(TimerService.REP_BREAK);
	}        
}