using Toybox.WatchUi;

class StartedExerciseDelegate extends WatchUi.BehaviorDelegate {

	function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
    	$.activityControl.stop();
        $.stateMachine.transition(StateMachine.STARTED, StateMachine.STOP);
        return true;
    }
    
    function onBack() {
    	$.activityControl.stop();
    	$.stateMachine.transition(StateMachine.STARTED, StateMachine.STOP);
    	return true;
    }      
}