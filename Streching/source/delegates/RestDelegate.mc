using Toybox.WatchUi;

class RestDelegate extends WatchUi.BehaviorDelegate {

	function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
		S_ACTIVITY.pause();
		S_TIMER.pause(TIMER.REP_PAUSE_TIME);
		S_NOTIFY.signal(NOTIFY.STOP);
        S_SM.transition(SM.SUMMARY);
        return true;
    }
    
    function onBack() {
		S_ACTIVITY.lap();
		S_TIMER.remove(TIMER.REP_PAUSE_TIME);
		S_NOTIFY.signal(NOTIFY.LAP);
		S_SM.transition(SM.EXERCISE);
		return true;
    } 
}