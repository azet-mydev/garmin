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
        $.timerService.registerCallback("EXERCISE", EXERCISE_PERIOD, method(:refreshView));
        return true;
    }
    
    function refreshView() {
		WatchUi.requestUpdate();
	}  
}