using Toybox.WatchUi;

class SummaryDelegate extends WatchUi.BehaviorDelegate {

	function initialize(){
        BehaviorDelegate.initialize();
    }
    
    function onSelect(){
    	S_ACTIVITY.resume();
        S_SM.transition(SM.SELECT);
        S_NOTIFY.signal(NOTIFY.START);
        return true;
    }
    
    function onBack(){
    	S_ACTIVITY.stop();
    	return false;
    }
}