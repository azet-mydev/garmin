using Toybox.WatchUi;

class SummaryDelegate extends WatchUi.BehaviorDelegate {

	function initialize(){
        BehaviorDelegate.initialize();
    }
    
    function onSelect(){
    	S_ACTIVITY.resume();
        S_NOTIFY.signal(NOTIFY.START);
        S_SM.transition(S_SM.getHistory(-1));
        return true;
    }
    
    function onBack(){
    	S_SM.transition(SM.SUMMENU);
    	return true;
    }
}