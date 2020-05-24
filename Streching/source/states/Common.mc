using Toybox.Graphics;
using Toybox.WatchUi;
using Toybox.System;

module Common{

	function reportExcercise(){
		S_ACTIVITY.reportActivityTimeline(1);
	}
	
	function reportRest(){
		S_ACTIVITY.reportActivityTimeline(0);
	}

	class Delegate extends WatchUi.BehaviorDelegate{
	
		var settingsMenuDelegate = new SettingsMenuDelegate();
	
		function initialize(){
		    BehaviorDelegate.initialize();
		}
		
		function onMenu(){
			LOG("Common","Delegate.onMenu()");
		
			var settingsMenuView = new WatchUi.Menu2({:title=>Rez.Strings.Settings});
			settingsMenuView.addItem(new WatchUi.MenuItem(Rez.Strings.RepetitionInterval, null, "repetitionInterval", {}));
			settingsMenuView.addItem(new WatchUi.ToggleMenuItem(Rez.Strings.Sound, null, "soundOn", S_CONFIG.isSoundOn(), {}));
			settingsMenuView.addItem(new WatchUi.ToggleMenuItem(Rez.Strings.Vibration, null, "vibrationOn", S_CONFIG.isVibrationOn(), {}));
			settingsMenuView.addItem(new WatchUi.ToggleMenuItem(Rez.Strings.Backlight, null, "backlightOn", S_CONFIG.isBacklightOn(), {}));
			settingsMenuView.addItem(new WatchUi.ToggleMenuItem(Rez.Strings.Lap, null, "lapOn", S_CONFIG.isLapOn(), {}));
		    LOAD("SettingsMenuView", settingsMenuView, settingsMenuDelegate);
		    return true;
		}
		
		function onBack(){
			LOG("Common","Delegate.onBack()");
			BehaviorDelegate.onBack();
		}
		
		function onNextMode(){
			LOG("Common","Delegate.onNextMode()");
			BehaviorDelegate.onNextMode();
		}
		
		function onNextPage(){
			LOG("Common","Delegate.onNextPage()");
			BehaviorDelegate.onNextPage();
		}
		
		function onPreviousMode(){
			LOG("Common","Delegate.onPreviousMode()");
			BehaviorDelegate.onPreviousMode();
		}
		
		function onPreviousPage(){
			LOG("Common","Delegate.onPreviousPage()");
			BehaviorDelegate.onPreviousPage();
		}
		
		function onSelect(){
			LOG("Common","Delegate.onSelect()");
			BehaviorDelegate.onSelect();
		}
	}
	
	class SettingsMenuDelegate extends WatchUi.Menu2InputDelegate{
	
	    function initialize(){
	        Menu2InputDelegate.initialize();
	    }
	    
	    function onSelect(item){
	    	LOG("Common","SettingsMenuDelegate.onSelect(" + item.getId() + ")");
	    	
	    	switch(item.getId()){
	    		case "repetitionInterval":
	    			LOAD("IntervalPicker", new IntervalPicker(), new IntervalPickerDelegate());
	    			break;
	    		case "soundOn":
	    			S_CONFIG.setSoundOn(item.isEnabled());
	    			break;
	    		case "vibrationOn":
	    			S_CONFIG.setVibrationOn(item.isEnabled());
	    			break;
	    		case "backlightOn":
	    			S_CONFIG.setBacklightOn(item.isEnabled());
	    			break;
	    		case "lapOn":
	    			S_CONFIG.setLapOn(item.isEnabled());
	    			break;	    				    				    				    		 
	    	}
		}
	}
	
	class IntervalPicker extends WatchUi.Picker{
		function initialize(){
			var title = new WatchUi.Text({:text=>Rez.Strings.RepetitionInterval, :font=>Graphics.FONT_MEDIUM, :locX=>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, :color=>Graphics.COLOR_WHITE});
			
			var factories = new [3];
			factories[0] = new NumberPickerFactory(0, 99, 1, "%2d");
			factories[1] = new WatchUi.Text({:text=>":", :font=>Graphics.FONT_NUMBER_MEDIUM, :locX =>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_CENTER, :color=>Graphics.COLOR_WHITE});
			factories[2] = new NumberPickerFactory(0, 59, 1, "%d");
			
			var defaults = new [factories.size()];
			defaults[0] = (S_CONFIG.getRepetitionInterval() / 60).toNumber();
			defaults[2] = S_CONFIG.getRepetitionInterval() % 60;
			
			Picker.initialize({:title=>title, :pattern=>factories, :defaults=>defaults});
		}
		
	    function onUpdate(dc){
	        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
	        dc.clear();
	        Picker.onUpdate(dc);
	    }
	}
	
	class IntervalPickerDelegate extends WatchUi.PickerDelegate{
	
		function initialize(){
	        PickerDelegate.initialize();
	    }
	
	    function onCancel(){
	    	LOG("Common","IntervalPickerDelegate.onCancel()");
	    	
	        UNLOAD("IntervalPicker");
	    }
	
	    function onAccept(values){
	    	LOG("Common","IntervalPickerDelegate.onAccept()");
	    
	    	var interval =  values[0]*60+values[2];
	    	S_CONFIG.setRepetitionInterval(interval);
	    	
	    	LOG("Common", "Changed repetition interval period, new value:" + interval);
	    	
	        UNLOAD("IntervalPicker");
		}
	}
	
	class NumberPickerFactory extends WatchUi.PickerFactory{
	    var start;
	    var stop;
	    var increment;
	    var format;

	    function initialize(start, stop, increment, format){
	        PickerFactory.initialize();
	
	        self.start = start;
	        self.stop = stop;
	        self.increment = increment;
	        self.format = format;
	    }
	
	    function getDrawable(index, selected){
	        return new WatchUi.Text( { :text=>getValue(index).format(format),:font=>Graphics.FONT_NUMBER_MEDIUM, :locX =>WatchUi.LAYOUT_HALIGN_CENTER, :locY=>WatchUi.LAYOUT_VALIGN_CENTER, :color=>Graphics.COLOR_WHITE } );
	    }

	    function getIndex(value){
	        var index = (value / increment) - start;
	        return index;
	    }
	
	    function getValue(index){
	        return start + (index * increment);
	    }
	
	    function getSize(){
	        return ( stop - start ) / increment + 1;
	    }
	}
}