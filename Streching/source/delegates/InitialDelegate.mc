using Toybox.WatchUi;

class InitialDelegate extends WatchUi.BehaviorDelegate {

	var session = null;

	function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
        $.activityControl.start();
        $.timerService.start();
        $.timerService.registerCallback(TimerService.REFRESH_VIEW, REFRESH_PERIOD, method(:refreshView_callback), true);
        $.timerService.registerCallback(TimerService.REP_TIME, REP_PERIOD, method(:repTime_callback), false);
        $.stateMachine.transition(StateMachine.SELECT);
        return true;
    }
    
    function refreshView_callback() {
		WatchUi.requestUpdate();
	}
	
	function repTime_callback() {
		$.timerService.registerTimer(TimerService.REP_PAUSE_TIME);
		$.stateMachine.transition(StateMachine.EXERCISE_TIMEOUT);
	}  
}