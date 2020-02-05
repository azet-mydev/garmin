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
		$.s.get(S.TIMER).add(TimerSrvc.REP_TIME,{
													:period=>REP_PERIOD,
													:callback=>method(:repTime_callback), 
													:repeat=>false
												});
		$.s.get(S.SM).transition(SmSrvc.BACK);
		$.s.get(S.NOTIFY).signal(NotifySrvc.LAP);
	}
	
	function repTime_callback() {
		$.s.get(S.TIMER).add(TimerSrvc.REP_PAUSE_TIME, {});
		$.s.get(S.SM).transition(SmSrvc.EXERCISE_TIMEOUT);
		$.s.get(S.NOTIFY).signal(NotifySrvc.TIMEOUT);
	}
}