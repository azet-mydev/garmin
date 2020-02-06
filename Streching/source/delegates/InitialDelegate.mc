using Toybox.WatchUi;

class InitialDelegate extends WatchUi.BehaviorDelegate{

	function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onSelect() {
        $.s.get(S.ACTIVITY).start();
        $.s.get(S.SM).transition(SmSrvc.SELECT);
        $.s.get(S.NOTIFY).signal(NotifySrvc.START);
        return true;
    }
}