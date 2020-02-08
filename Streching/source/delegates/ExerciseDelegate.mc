//using Toybox.WatchUi;
//
//class ExerciseDelegate extends WatchUi.BehaviorDelegate {
//
//	function initialize(){
//        BehaviorDelegate.initialize();
//    }
//    
//    function onSelect(){
//		S_ACTIVITY.pause();
//		S_TIMER.pause(TIMER.REP_TIME);
//		S_NOTIFY.signal(NOTIFY.STOP);
//        S_SM.transition(SM.SUMMARY);
//        return true;
//    }
//    
//    function onBack(){
//        S_TIMER.reset(TIMER.REP_TIME);
//		S_NOTIFY.signal(NOTIFY.LAP);
//		return true;
//    }
//}