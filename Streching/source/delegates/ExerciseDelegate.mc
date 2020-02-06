using Toybox.WatchUi;

class ExerciseDelegate extends WatchUi.BehaviorDelegate {

	function initialize(){
        BehaviorDelegate.initialize();
    }
    
    function onSelect(){
		$.s.get(S.ACTIVITY).pause();
		$.s.get(S.TIMER).pause(TimerSrvc.REP_TIME);
		$.s.get(S.NOTIFY).signal(NotifySrvc.STOP);
        $.s.get(S.SM).transition(SmSrvc.SELECT);
        return true;
    }
    
    function onBack(){
        $.s.get(S.TIMER).reset(TimerSrvc.REP_TIME);
		$.s.get(S.NOTIFY).signal(NotifySrvc.LAP);
		return true;
    }
}