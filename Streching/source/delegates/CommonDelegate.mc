using Toybox.WatchUi;

class CommonDelegate extends WatchUi.BehaviorDelegate {
	
	function initialize() {
        BehaviorDelegate.initialize();
    }
    
	function pauseAction(){
		$.s.get(S.ACTIVITY).pause();
    	$.s.get(S.TIMER).pause();
        $.s.get(S.SM).transition(SmSrvc.SELECT);
        $.s.get(S.NOTIFY).signal(NotifySrvc.STOP);
	}
	
	function lapAction() {
		$.s.get(S.ACTIVITY).lap();
    	$.s.get(S.TIMER).registerCallback(TimerSrvc.REP_TIME, REP_PERIOD, method(:repTime_callback), false);
		$.s.get(S.SM).transition(SmSrvc.BACK);
		$.s.get(S.NOTIFY).signal(NotifySrvc.LAP);
	}
	
	function repTime_callback() {
		$.s.get(S.TIMER).registerTimer(TimerSrvc.REP_PAUSE_TIME);
		$.s.get(S.SM).transition(SmSrvc.EXERCISE_TIMEOUT);
		$.s.get(S.NOTIFY).signal(NotifySrvc.TIMEOUT);
	}
}