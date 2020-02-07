using Toybox.WatchUi;

class InitialDelegate extends WatchUi.BehaviorDelegate{

	function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
        S_ACTIVITY.start();
        S_NOTIFY.signal(NOTIFY.START);
        S_SM.transition(SM.EXERCISE);
        return true;
    }
}