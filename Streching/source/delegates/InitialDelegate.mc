using Toybox.WatchUi;

class InitialDelegate extends CommonDelegate{

	function initialize() {
        CommonDelegate.initialize();
    }
    
    function onSelect() {
        $.s.get(S.ACTIVITY).start();
        $.s.get(S.TIMER).start();
        $.s.get(S.TIMER).add(TimerSrvc.REFRESH_VIEW, {
        												:period=>REFRESH_PERIOD,
														:callback=>method(:refreshView_callback), 
														:repeat=>true
													 });
        $.s.get(S.TIMER).add(TimerSrvc.REP_TIME, {
        											:period=>REP_PERIOD,
													:callback=>method(:repTime_callback), 
													:repeat=>false
												 });
        $.s.get(S.SM).transition(SmSrvc.SELECT);
        $.s.get(S.NOTIFY).signal(NotifySrvc.START);
        return true;
    }
    
    function refreshView_callback() {
		WatchUi.requestUpdate();
	}  
}