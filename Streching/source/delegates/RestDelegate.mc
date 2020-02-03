using Toybox.WatchUi;

class RestDelegate extends CommonDelegate {

	function initialize() {
        CommonDelegate.initialize();
    }
    
    function onSelect() {
    	pauseAction();
        return true;
    }
    
    function onBack() {
		lapAction();
		return true;
    } 
}