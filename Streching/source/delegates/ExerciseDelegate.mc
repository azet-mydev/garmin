using Toybox.WatchUi;

class ExerciseDelegate extends WatchUi.BehaviorDelegate {

	function initialize(){
        BehaviorDelegate.initialize();
    }
    
    function onSelect(){
		S_ACTIVITY.pause();
		S_TIMER.pause(TimerSrvc.REP_TIME);
		S_NOTIFY.signal(NotifySrvc.STOP);
        S_SM.transition(SmSrvc.SELECT);
        return true;
    }
    
    function onBack(){
        S_TIMER.reset(TimerSrvc.REP_TIME);
		S_NOTIFY.signal(NotifySrvc.LAP);
		return true;
    }
}