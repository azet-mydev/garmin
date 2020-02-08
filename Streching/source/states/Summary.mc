using Toybox.WatchUi;

module Summary {

	var summaryMenuDelegate;
	var summaryMenuView;
	var discardDialogDelegate;
	var discardDialogView;
	
	var showedSummaryMenu = false;
	
	function showSummaryMenu(){
		WatchUi.pushView(summaryMenuView, summaryMenuDelegate, SCREEN_TRANSITION);
	}
	
	class SummaryDelegate extends WatchUi.BehaviorDelegate {
	
		function initialize(){
	        BehaviorDelegate.initialize();
	    }
	    
	    function onSelect(){
	    	S_ACTIVITY.resume();
	        S_NOTIFY.signal(NOTIFY.START);
	        showedSummaryMenu = false;
	        S_SM.transition(S_SM.getHistory(-1));
	        return true;
	    }
	    
	    function onBack(){
	    	showSummaryMenu();
	    	return true;
	    }
	}
	 
	class SummaryView extends WatchUi.View {
	 	
		function initialize(){
			View.initialize();
			summaryMenuDelegate = new SummaryMenuDelegate();
			summaryMenuView = new SummaryMenuView();
			discardDialogDelegate = new DiscardDialogDelegate();
			discardDialogView = new Rez.Menus.DiscardMenu();
		}
	 	
		function onShow(){
			if(!showedSummaryMenu){
				S_TIMER.schedule(TIMER.SUMMENU_APPEAR, {
					:period => SUMMENU_APPEAR_PERIOD,
					:callback => method(:showSummaryMenu),
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
	}
	
	class SummaryMenuDelegate extends WatchUi.Menu2InputDelegate {
	
	    function initialize() {
	        Menu2InputDelegate.initialize();
	    }
	    
	    function onSelect(item) {
	        if (item.getId() == :Continue){
	            S_ACTIVITY.resume();
	            S_NOTIFY.signal(NOTIFY.START);
	            showedSummaryMenu = false;
	            S_SM.transition(S_SM.getHistory(-1));
	        } else if (item.getId() == :Save){
	            S_ACTIVITY.stop();
	        	S_NOTIFY.signal(NOTIFY.STOP);
	        	System.exit();
	        } else if (item.getId() == :Discard){
				WatchUi.pushView(discardDialogView, discardDialogDelegate, SCREEN_TRANSITION);
	        }
	    }
	}
	
	class SummaryMenuView extends Rez.Menus.SummaryMenu {
	
		var showMenuTitleIndex;
	
		function initialize(){
			Rez.Menus.SummaryMenu.initialize();
		}
		
		function onShow(){
			Rez.Menus.SummaryMenu.onShow();
			
			showedSummaryMenu = true;
			showMenuTitleIndex = 0;
			
			S_TIMER.schedule(TIMER.SUMMMENU_TITLE_CHANGE, {
				:period => SUMMMENU_TITLE_CHANGE_PERIOD,
				:callback => method(:rollOverMenuTitile),
				:repeat => true});
			rollOverMenuTitile();
		}
		
		function onHide(){
			Rez.Menus.SummaryMenu.onHide();
			
			S_TIMER.remove(TIMER.SUMMMENU_TITLE_CHANGE);
		}
		
		function rollOverMenuTitile(){
			var info = Activity.getActivityInfo();
			var value;
			switch (showMenuTitleIndex % 3) {
				case 0: {
					var seconds = info.elapsedTime/1000;
					value = Lang.format("$1$:$2$", [seconds/60.toNumber(), (seconds % 60).format("%02d")]);
					break;
				}
				case 1: {
					if (info.calories!=null){
						value = info.calories.toString() + " cal";
					} else {
						value = "0 cal";
					}
					break;
				}
				case 2: {
					if(info.averageHeartRate!=null){
						value = info.averageHeartRate.toString();
					}else {
						value = "X";
					}
					break;
				}
			}
			showMenuTitleIndex++;
			
			self.setTitle(value);
			WatchUi.requestUpdate();
		}
	}
	
	class DiscardDialogDelegate extends WatchUi.Menu2InputDelegate {
	
	    function onResponse(value) {
	        if (value == WatchUi.CONFIRM_YES) {

	        }
	    }
	    
	   	function initialize() {
	        Menu2InputDelegate.initialize();
	    }
	    
	    function onSelect(item) {
	        if (item.getId() == :Yes){
	        	S_ACTIVITY.discard();
	        	S_NOTIFY.signal(NOTIFY.STOP);
	        	System.exit();
	        } else if(item.getId() == :No){
	        	WatchUi.popView(SCREEN_TRANSITION);
	        }
	    }
	}
}