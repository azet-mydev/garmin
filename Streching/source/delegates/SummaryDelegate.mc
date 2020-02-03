using Toybox.WatchUi;

class SummaryDelegate extends WatchUi.BehaviorDelegate {

	function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
    	$.activityControl.resume();
    	$.timerService.resume();
        $.stateMachine.transition(StateMachine.SELECT);
        return true;
    }
}