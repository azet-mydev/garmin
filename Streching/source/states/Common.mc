using Toybox.Application;
using Toybox.Graphics;
using Toybox.System;
using Toybox.WatchUi;

module Common {

	class Delegate extends WatchUi.BehaviorDelegate {
	
		var settingsMenuDelegate = new SettingsMenuDelegate();
	
		function initialize() {
		    BehaviorDelegate.initialize();
		}
		
		function onMenu() {
			LOG("Delegate","Invoking onMenu()");
		
			var settingsMenuView = new WatchUi.Menu2({:title=>Rez.Strings.settings});
		    for( var i = 0; i < S_DATA.cfg.keys().size(); i += 1 ) {
		    	var cfgKey = S_DATA.cfg.keys()[i];
		    	var cfgName = S_DATA.cfg.get(cfgKey).get(:name);
		    	var cfgValue = S_DATA.cfg.get(cfgKey).get(:value);
				
				if(cfgValue instanceof Toybox.Lang.Boolean){		    	
		    		settingsMenuView.addItem(new ToggleMenuItem(cfgName, null, cfgKey, cfgValue, {}));
		    	}else if (cfgValue instanceof Toybox.Lang.Number){
		    		settingsMenuView.addItem(new MenuItem(cfgName, null, cfgKey, {}));
		    	}
		    }
		    LOAD("SettingsMenuView", settingsMenuView, settingsMenuDelegate);
		    return true;
		}
		
		function onBack(){
			LOG("Delegate","Invoking onBack()");
			BehaviorDelegate.onBack();
		}
		
		function onNextMode(){
			LOG("Delegate","Invoking onNextMode()");
			BehaviorDelegate.onNextMode();
		}
		
		function onNextPage(){
			LOG("Delegate","Invoking onNextPage()");
			BehaviorDelegate.onNextPage();
		}
		
		function onPreviousMode(){
			LOG("Delegate","Invoking onPreviousMode()");
			BehaviorDelegate.onPreviousMode();
		}
		
		function onPreviousPage(){
			LOG("Delegate","Invoking onPreviousPage()");
			BehaviorDelegate.onPreviousPage();
		}
		
		function onSelect(){
			LOG("Delegate","Invoking onSelect()");
			BehaviorDelegate.onSelect();
		}
	}
	
	class SettingsMenuDelegate extends WatchUi.Menu2InputDelegate {
	
	    function initialize() {
	        Menu2InputDelegate.initialize();
	    }
	    
	    function onSelect(item) {
	    	LOG("SettingsMenuDelegate","Invoking onSelect()");
	    	
	    	if(S_DATA.cfg.get(item.getId()).get(:value) instanceof Toybox.Lang.Boolean) {
	    		S_DATA.cfg.get(item.getId()).put(:value, item.isEnabled());
	    	}else if(S_DATA.cfg.get(item.getId()).get(:name) == Rez.Strings.interval){
	    		LOAD("IntervalPicker", new IntervalPicker(), new IntervalPickerDelegate());
	    	}
		}
	}
	
	class IntervalPicker extends WatchUi.Picker {
		function initialize() {
			var title = new WatchUi.Text({:text=>Rez.Strings.interval, :font=>Graphics.FONT_MEDIUM, :locX=>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, :color=>Graphics.COLOR_WHITE});
			
			var factories = new [3];
			factories[0] = new NumberPickerFactory(0, 99, 1, "%2d");
			factories[1] = new WatchUi.Text({:text=>":", :font=>Graphics.FONT_NUMBER_MEDIUM, :locX =>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_CENTER, :color=>Graphics.COLOR_WHITE});
			factories[2] = new NumberPickerFactory(0, 59, 1, "%d");
			
			var defaults = new [factories.size()];
			defaults[0] = (S_DATA.cfg.get(CFG.REPETITION_INTERVAL).get(:value) / 60).toNumber();
			defaults[2] = S_DATA.cfg.get(CFG.REPETITION_INTERVAL).get(:value) % 60;
			
			Picker.initialize({:title=>title, :pattern=>factories, :defaults=>defaults});
		}
		
	    function onUpdate(dc) {
	        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
	        dc.clear();
	        Picker.onUpdate(dc);
	    }
	}
	
	class IntervalPickerDelegate extends WatchUi.PickerDelegate {
	
		function initialize() {
	        PickerDelegate.initialize();
	    }
	
	    function onCancel() {
	    	LOG("IntervalPickerDelegate","Invoking onCancel()");
	    	
	        UNLOAD("IntervalPicker");
	    }
	
	    function onAccept(values) {
	    	LOG("IntervalPickerDelegate","Invoking onAccept()");
	    
	    	var interval =  values[0]*60+values[2];
	    	S_DATA.cfg.get(CFG.REPETITION_INTERVAL).put(:value, interval);
	    	
	    	LOG("IntervalPickerDelegate", "Changed repetition interval period, new value:" + interval);
	    	
	        UNLOAD("IntervalPicker");
		}
	}
	
	class NumberPickerFactory extends WatchUi.PickerFactory {
	    var start;
	    var stop;
	    var increment;
	    var format;

	    function initialize(start, stop, increment, format) {
	        PickerFactory.initialize();
	
	        self.start = start;
	        self.stop = stop;
	        self.increment = increment;
	        self.format = format;
	    }
	
	    function getDrawable(index, selected) {
	        return new WatchUi.Text( { :text=>getValue(index).format(format),:font=>Graphics.FONT_NUMBER_MEDIUM, :locX =>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_CENTER, :color=>Graphics.COLOR_WHITE } );
	    }

	    function getIndex(value) {
	        var index = (value / increment) - start;
	        return index;
	    }
	
	    function getValue(index) {
	        return start + (index * increment);
	    }
	
	    function getSize() {
	        return ( stop - start ) / increment + 1;
	    }
	}
}