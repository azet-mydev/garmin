using Toybox.WatchUi;

class SummaryDelegate extends WatchUi.BehaviorDelegate {

	function initialize(){
        BehaviorDelegate.initialize();
    }
    
    function onSelect(){
    	$.s.get(S.ACTIVITY).resume();
        $.s.get(S.SM).transition(SmSrvc.SELECT);
        $.s.get(S.NOTIFY).signal(NotifySrvc.START);
        return true;
    }
    
    function onBack(){
    	$.s.get(S.ACTIVITY).stop();
    	$.s.get(S.TIMER).shutdown();
    	return false;
    }
}