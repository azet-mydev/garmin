using Toybox.WatchUi;

module Summary {

	var summaryMenuDelegate;
	var summaryMenuView;
	var discardDialogDelegate;
	var discardDialogView;
	
	var showedSummaryMenu = false;
	
	function showSummaryMenu(){
		LOAD("SummaryMenuView", summaryMenuView, summaryMenuDelegate);
	}
	
	class SummaryDelegate extends Common.Delegate {
	
		function initialize(){
	        Delegate.initialize();
	    }
	    
	    function onSelect(){
	    	LOG("SummaryDelegate","Invoking onSelect()");
	    	
	    	S_ACTIVITY.resume();
	        S_NOTIFY.signal(NOTIFY.START);
	        showedSummaryMenu = false;
	        S_SM.transition(S_SM.getHistory(-1));
	        return true;
	    }
	    
	    function onBack(){
	    	LOG("SummaryDelegate","Invoking onBack()");
	    	
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
				:period=>S_DATA.getRefreshPeriod(),
				:callback=>method(:refreshView_callback), 
				:repeat=>true});
				
			if(!showedSummaryMenu){
				S_TIMER.schedule(TIMER.SUMMENU_APPEAR, {
					:period => S_DATA.getSummaryMenuAppearPeriod(),
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
			
			var ex = View.findDrawableById("ex");
			ex.setText(S_UTILITY.formatNullableData2(S_DATA.getExerciseNumber(), WatchUi.loadResource( Rez.Strings.Ex )));
						
			var counterVal = Activity.getActivityInfo().timerTime/1000;
			var counter = View.findDrawableById("counter");
			counter.setText(S_UTILITY.formatCounter(counterVal));
			
			var hr = View.findDrawableById("hr");
			hr.setText(S_UTILITY.formatNullableData2(Activity.getActivityInfo().averageHeartRate, WatchUi.loadResource( Rez.Strings.Bps )));
			
			var calories = View.findDrawableById("calories");
			calories.setText(S_UTILITY.formatNullableData2(Activity.getActivityInfo().calories, WatchUi.loadResource( Rez.Strings.Cal )));
			
			View.onUpdate(dc);
		}
	}
	
	class SummaryMenuDelegate extends WatchUi.Menu2InputDelegate {
	
	    function initialize() {
	        Menu2InputDelegate.initialize();
	    }
	    
	    function onSelect(item) {
	        if (item.getId() == :Continue){
	        	LOG("SummaryMenuDelegate","Invoking onSelect(Continue)");
	        	
	            S_ACTIVITY.resume();
	            S_NOTIFY.signal(NOTIFY.START);
	            showedSummaryMenu = false;
	            S_SM.transition(S_SM.getHistory(-1));
	        } else if (item.getId() == :Save){
	        	LOG("SummaryMenuDelegate","Invoking onSelect(Save)");
	        	
	            S_ACTIVITY.stop();
	        	S_NOTIFY.signal(NOTIFY.STOP);
	        	System.exit();
	        } else if (item.getId() == :Discard){
	        	LOG("SummaryMenuDelegate","Invoking onSelect(Discard)");
	        	
				LOAD("DiscardDialogView", discardDialogView, discardDialogDelegate);
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
				:period => S_DATA.getSummaryMenuTitleSlideChangePeriod(),
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
			switch (showMenuTitleIndex % 4) {
				case 0: {
					value = S_UTILITY.formatTimeNow();
					break;
				}
				case 1: {
					value = S_UTILITY.formatNullableData2(S_DATA.getExerciseNumber(), WatchUi.loadResource( Rez.Strings.Ex ));
					break;
				}
				case 2: {
					value = S_UTILITY.formatNullableData2(Activity.getActivityInfo().calories, WatchUi.loadResource( Rez.Strings.Cal ));
					break;
				}
				case 3: {
					value = S_UTILITY.formatNullableData2(Activity.getActivityInfo().averageHeartRate, WatchUi.loadResource( Rez.Strings.Bps ));
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
	        	LOG("DiscardDialogDelegate","Invoking onSelect(Yes)");
	        	
	        	S_ACTIVITY.discard();
	        	S_NOTIFY.signal(NOTIFY.STOP);
	        	System.exit();
	        } else if(item.getId() == :No){
	        	LOG("DiscardDialogDelegate","Invoking onSelect(No)");
	        	
	        	UNLOAD("DiscardDialogView");
	        }
	    }
	}
}