using Toybox.WatchUi;

class InitialDelegate extends CommonDelegate{

	function initialize() {
        CommonDelegate.initialize();
    }
    
    function onSelect() {
        $.s.get(S.ACTIVITY).start();
        $.s.get(S.TIMER).start();
        $.s.get(S.TIMER).registerCallback(TimerSrvc.REFRESH_VIEW, REFRESH_PERIOD, method(:refreshView_callback), true);
        $.s.get(S.TIMER).registerCallback(TimerSrvc.REP_TIME, REP_PERIOD, method(:repTime_callback), false);
        $.s.get(S.SM).transition(SmSrvc.SELECT);
        $.s.get(S.NOTIFY).signal(NotifySrvc.START);
        return true;
    }
    
    function refreshView_callback() {
		WatchUi.requestUpdate();
	}  
}