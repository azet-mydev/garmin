using Toybox.WatchUi;

class RestDelegate extends WatchUi.BehaviorDelegate {

	function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
		S_ACTIVITY.pause();
		S_TIMER.pause(TimerSrvc.REP_PAUSE_TIME);
		S_NOTIFY.signal(NotifySrvc.STOP);
        S_SM.transition(SmSrvc.SELECT);
        return true;
    }
    
    function onBack() {
		S_ACTIVITY.lap();
		S_TIMER.remove(TimerSrvc.REP_PAUSE_TIME);
		S_NOTIFY.signal(NotifySrvc.LAP);
		S_SM.transition(SmSrvc.BACK);
		return true;
    } 
}