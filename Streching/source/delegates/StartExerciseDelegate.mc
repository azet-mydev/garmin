using Toybox.WatchUi;

class StartExerciseDelegate extends WatchUi.BehaviorDelegate {

	var session = null;

	function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
        $.activityControl.start();
        $.stateMachine.transition(StateMachine.START);
        $.timerService.start();
        $.timerService.registerCallback(TimerService.REFRESH_VIEW, REFRESH_PERIOD, method(:refreshView_callback), true);
        $.timerService.registerCallback(TimerService.REP_TIMEOUT, REP_PERIOD, method(:repTimeOut_callback), false);
        return true;
    }
    
    function refreshView_callback() {
		WatchUi.requestUpdate();
	}
	
	function repTimeOut_callback() {
		$.timerService.registerTimer(TimerService.REP_BREAK);
	}  
}