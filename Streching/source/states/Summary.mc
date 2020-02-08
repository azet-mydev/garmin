using Toybox.WatchUi;

module Summary {
	
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
	
	class SummaryMenuDelegate extends WatchUi.Menu2InputDelegate {
	
	    function initialize() {
	        Menu2InputDelegate.initialize();
	    }
	
	    function onSelect(item) {
	        if (item.getId() == :Continue){
	            S_ACTIVITY.resume();
	            S_NOTIFY.signal(NOTIFY.START);
	            S_SM.transition(S_SM.getHistory(-2));
	        } else if (item.getId() == :Save){
	            S_ACTIVITY.stop();
	        	S_NOTIFY.signal(NOTIFY.STOP);
	        	System.exit();
	        } else if (item.getId() == :Discard){
	        	S_ACTIVITY.discard();
	        	S_NOTIFY.signal(NOTIFY.STOP);
	        	System.exit();
	        }
	    }
	    
	    function onBack(){
	    	S_SM.transition(SM.SUMMARY);
	    }
	}
	 
	class SummaryView extends WatchUi.View {
	 	
		function initialize(){
			View.initialize();
		}
	 	
		function onShow(){
			if(S_SM.getHistory(-1) != SM.SUMMENU){
				S_TIMER.schedule(TIMER.SUMMENU_APPEAR, {
					:period => SUMMENU_APPEAR_PERIOD,
					:callback => method(:summaryMenu_callback),
					:repeat => false});
			}
		}
	 	
		function onUpdate(dc){
			dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
			dc.clear(); 
			var x = dc.getWidth() / 2;
			var y = dc.getHeight() / 2 - dc.getFontHeight(Graphics.FONT_MEDIUM);
			dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
			dc.drawText(x, y, Graphics.FONT_MEDIUM, "SummaryView", Graphics.TEXT_JUSTIFY_CENTER);
					
			var heartRate = Sensor.getInfo().heartRate;
			y += dc.getFontHeight(Graphics.FONT_MEDIUM);        
			dc.drawText(x, y, Graphics.FONT_MEDIUM, heartRate, Graphics.TEXT_JUSTIFY_CENTER);
		}
	 	
		function summaryMenu_callback(){
			S_SM.transition(SM.SUMMENU);
		}
	}
	
	class SumMenuView extends Rez.Menus.SumMenu {
	
		var showMenuTitleIndex = 0;
	
		function initialize(){
			Rez.Menus.SumMenu.initialize();
		}
		
		function onShow(){
			Rez.Menus.SumMenu.onShow();
			S_TIMER.schedule(TIMER.SUMMMENU_TITLE_CHANGE, {
				:period => SUMMMENU_TITLE_CHANGE_PERIOD,
				:callback => method(:showMenuTitle_callback),
				:repeat => true});
			showMenuTitle_callback();
		}
		
		function onHide(){
			Rez.Menus.SumMenu.onHide();
			S_TIMER.remove(TIMER.SUMMMENU_TITLE_CHANGE);
		}
		
		function showMenuTitle_callback(){
			var info = Activity.getActivityInfo();
			var value;
			switch (showMenuTitleIndex % 3) {
				case 0: {
					var seconds = info.elapsedTime/1000;
					value = Lang.format("$1$:$2$", [seconds/60.toNumber(), (seconds % 60).format("%02d")]);
					break;
				}
				case 1:
					value = info.calories.toString() + " cal";
					break;
				case 2:
					value = info.averageHeartRate.toString();
					break;
			}
			showMenuTitleIndex++;
			
			self.setTitle(value);
			WatchUi.requestUpdate();
		}
	}
}