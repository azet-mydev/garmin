using Toybox.WatchUi;

class RestDelegate extends WatchUi.BehaviorDelegate {

	function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
		$.s.get(S.ACTIVITY).pause();
		$.s.get(S.TIMER).pause(TimerSrvc.REP_PAUSE_TIME);
		$.s.get(S.NOTIFY).signal(NotifySrvc.STOP);
        $.s.get(S.SM).transition(SmSrvc.SELECT);
        return true;
    }
    
    function onBack() {
		$.s.get(S.ACTIVITY).lap();
		$.s.get(S.TIMER).remove(TimerSrvc.REP_PAUSE_TIME);
		$.s.get(S.NOTIFY).signal(NotifySrvc.LAP);
		$.s.get(S.SM).transition(SmSrvc.BACK);
		return true;
    } 
}