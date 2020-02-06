using Toybox.WatchUi;

class InitialDelegate extends WatchUi.BehaviorDelegate{

	function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
        S_ACTIVITY.start();
        S_SM.transition(SM.SELECT);
        S_NOTIFY.signal(NOTIFY.START);
        return true;
    }
}