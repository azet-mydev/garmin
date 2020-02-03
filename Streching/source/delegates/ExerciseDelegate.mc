using Toybox.WatchUi;

class ExerciseDelegate extends WatchUi.BehaviorDelegate {

	function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
    	$.activityControl.pause();
    	$.timerService.pause();
        $.stateMachine.transition(StateMachine.SELECT);
        return true;
    }
}