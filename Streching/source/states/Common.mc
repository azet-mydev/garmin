using Toybox.WatchUi;

module Common {

	class Delegate extends WatchUi.BehaviorDelegate {
	
		var settingsMenuDelegate = new SettingsMenuDelegate();
	
		function initialize() {
		    BehaviorDelegate.initialize();
		}
		
		function onMenu() {
			var settingsMenuView = new WatchUi.Menu2({:title=>Rez.Strings.settings});
		    for( var i = 0; i < S_DATA.cfg.keys().size(); i += 1 ) {
		    	var cfgKey = S_DATA.cfg.keys()[i];
		    	var cfg = S_DATA.cfg.get(cfgKey);
		    	settingsMenuView.addItem(new ToggleMenuItem(cfg.get(:name), null, cfgKey, cfg.get(:value), {}));
		    }
		    WatchUi.pushView(settingsMenuView, settingsMenuDelegate, SCREEN_TRANSITION);
		    return true;
		}
	}
	
	class SettingsMenuDelegate extends WatchUi.Menu2InputDelegate {
	
	    function initialize() {
	        Menu2InputDelegate.initialize();
	    }
	    
	    function onSelect(item) {
	    	S_DATA.cfg.get(item.getId()).put(:value, item.isEnabled());
		}
	}
}