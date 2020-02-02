using Toybox.WatchUi;

class StartExerciseDelegate extends WatchUi.BehaviorDelegate {

	var session = null;

	function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
        $.activityControl.start();
        $.stateMachine.transition(StateMachine.NOT_STARTED, StateMachine.START);
        return true;
    }  
}