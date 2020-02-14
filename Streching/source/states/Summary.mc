using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

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
			 	
	 	function onLayout(dc){
	 		setLayout(Rez.Layouts.Summary(dc));
	 	}
	 	
		function onShow(){
			S_TIMER.schedule(TIMER.REFRESH_VIEW, {
				:period=>REFRESH_PERIOD,
				:callback=>method(:refreshView_callback), 
				:repeat=>true});
				
			if(!showedSummaryMenu){
				S_TIMER.schedule(TIMER.SUMMENU_APPEAR, {
					:period => SUMMENU_APPEAR_PERIOD,
					:callback => method(:showSummaryMenu),
					:repeat => false});
			}
		}
		
		function onHide(){
	 		S_TIMER.remove(TIMER.REFRESH_VIEW);
	 	}
	 	
	 	function refreshView_callback() {
			WatchUi.requestUpdate();
		} 
	 	
		function onUpdate(dc){
			var time = View.findDrawableById("time");
			time.setText(S_UTILITY.formatTimeNow());
						
			var counterVal = Activity.getActivityInfo().timerTime/1000;
			var counter = View.findDrawableById("counter");
			counter.setText(S_UTILITY.formatCounter(counterVal));
			
			var hr = View.findDrawableById("hr");
			hr.setText(S_UTILITY.formatData2(Activity.getActivityInfo().averageHeartRate, " bps"));
			
			var calories = View.findDrawableById("calories");
			calories.setText(S_UTILITY.formatData2(Activity.getActivityInfo().calories, " C"));
			
			View.onUpdate(dc);
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
					var seconds = info.timerTime/1000;
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
						value = info.averageHeartRate.toString() + " bps";
					}else {
						value = "X bps";
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