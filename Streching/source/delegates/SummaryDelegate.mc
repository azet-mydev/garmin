using Toybox.WatchUi;

class SummaryDelegate extends CommonDelegate {

	function initialize(){
        CommonDelegate.initialize();
    }
    
    function onSelect(){
    	$.s.get(S.ACTIVITY).resume();
    	$.s.get(S.TIMER).resume();
        $.s.get(S.SM).transition(SmSrvc.SELECT);
        $.s.get(S.NOTIFY).signal(NotifySrvc.START);
        return true;
    }
    
    function onBack(){
    	$.s.get(S.ACTIVITY).stop();
    	$.s.get(S.TIMER).stop();
    	return false;
    }
}