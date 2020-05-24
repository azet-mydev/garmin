using Toybox.WatchUi;
using Toybox.System;
using Toybox.Lang;

module Summary{

	////////////////////////////////////////////////////
	////////////////////// SIGNALS /////////////////////
	////////////////////////////////////////////////////
	
	function signal_Summary_unpause(){
		LOG("Summary","signal_Summary_unpause()");
    	S_ACTIVITY.resume();
        S_NOTIFY.signal(NOTIFY.START);
        showedSummaryMenu = false;
        
        var prevState = S_SM.getPrevious();
        
        if(prevState==SM.EXERCISE){
			S_DATA.addPauseTime(S_TIMER.remove(TIMER.PAUSE_TIME));
			S_TIMER.schedule(TIMER.EXERCISE_TIME, {:callback=>new Lang.Method(Common, :reportExcercise)});
        }else if(prevState==SM.REST){
			S_DATA.addPauseTime(S_TIMER.remove(TIMER.PAUSE_TIME));
			S_TIMER.schedule(TIMER.REST_TIME, {:callback=>new Lang.Method(Common, :reportRest)});
        }
        
        S_SM.transition(prevState);	
	}
	
	function signal_Summary_saveActivity(){
		LOG("Summary","signal_Summary_saveActivity()");
		
		S_DATA.addPauseTime(S_TIMER.remove(TIMER.PAUSE_TIME));
		S_DATA.writeToActivity();
		
		S_ACTIVITY.stop();
    	S_NOTIFY.signal(NOTIFY.STOP);
    	System.exit();
	}

	////////////////////////////////////////////////////
	////////////////////// \SIGNALS ////////////////////
	////////////////////////////////////////////////////	

	var summaryMenuDelegate;
	var summaryMenuView;
	var summaryMenuTitle;
	
	var discardDialogDelegate;
	var discardDialogView;
	
	var showedSummaryMenu = false;
	 
	class SummaryView extends WatchUi.View{
	 	
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
				:period=>S_CONFIG.getRefreshPeriod(),
				:callback=>method(:refreshView_callback), 
				:repeat=>true});
				
			if(!showedSummaryMenu){
				S_TIMER.schedule(TIMER.SUMMENU_APPEAR, {
					:period => S_CONFIG.getSummaryMenuAppearPeriod(),
					:callback => method(:showSummaryMenu),
					:repeat => false});
			}
		}
		
		function onHide(){
	 		S_TIMER.remove(TIMER.REFRESH_VIEW);
	 	}
	 	
	 	function refreshView_callback(){
			WatchUi.requestUpdate();
		} 
	 	
		function onUpdate(dc){
			var time = View.findDrawableById("time");
			time.setText(S_UTILITY.formatTimeNow());
			
			var ex = View.findDrawableById("ex");
			ex.setText(S_UTILITY.formatNullableData2(S_DATA.getExercise(), WatchUi.loadResource( Rez.Strings.Rep )));
						
			var counter = View.findDrawableById("counter");
			counter.setText(S_UTILITY.formatCounter(S_DATA.getActivityTime()));
			
			var hr = View.findDrawableById("hr");
			hr.setText(S_UTILITY.formatNullableData2(Activity.getActivityInfo().averageHeartRate, WatchUi.loadResource( Rez.Strings.Bps )));
			
			var calories = View.findDrawableById("calories");
			calories.setText(S_UTILITY.formatNullableData2(Activity.getActivityInfo().calories, WatchUi.loadResource( Rez.Strings.Cal )));
			
			View.onUpdate(dc);
		}
	}
	
	class SummaryDelegate extends Common.Delegate{
	
		function initialize(){
	        Delegate.initialize();
	    }
	    
	    function onSelect(){
	    	LOG("Summary","onSelect()");
	    	
			signal_Summary_unpause();
	        return true;
	    }
	    
	    function onBack(){
			LOG("Summary","onBack()");
    	
    		showSummaryMenu();	
	    	return true;
	    }
	}
	
	class SummaryMenuView extends Rez.Menus.SummaryMenu{
	
		var showMenuTitleIndex;
	
		function initialize(){
			Rez.Menus.SummaryMenu.initialize();
			Menu2.initialize({:title=>new SummaryMenuTitleDrawable()});
		}
		
		function onShow(){
			Rez.Menus.SummaryMenu.onShow();
			
			showedSummaryMenu = true;
			showMenuTitleIndex = 0;
			
			S_TIMER.schedule(TIMER.SUMMMENU_TITLE_CHANGE, {
				:period => S_CONFIG.getSummaryMenuTitleSlideChangePeriod(),
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
			switch (showMenuTitleIndex % 5) {
				case 0: {
					value = S_UTILITY.formatTimeNow();
					break;
				}
				case 1: {
					value = S_UTILITY.formatNullableData2(S_DATA.getExercise(), WatchUi.loadResource( Rez.Strings.Rep ));
					break;
				}
				case 2: {
					value = S_UTILITY.formatNullableData2(S_UTILITY.formatCounter(S_DATA.getActivityTime()), WatchUi.loadResource( Rez.Strings.Min ));
					break;
				}
				case 3: {
					value = S_UTILITY.formatNullableData2(Activity.getActivityInfo().calories, WatchUi.loadResource( Rez.Strings.Cal ));
					break;
				}
				case 4: {
					value = S_UTILITY.formatNullableData2(Activity.getActivityInfo().averageHeartRate, WatchUi.loadResource( Rez.Strings.Bps ));
					break;
				}
			}
			showMenuTitleIndex++;
			
			summaryMenuTitle = value;
			WatchUi.requestUpdate();
		}
	}
	
	class SummaryMenuTitleDrawable extends WatchUi.Drawable{

	    function initialize(){
	        Drawable.initialize({});
	    }
	
	    function draw(dc){
	    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
	        dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Graphics.FONT_MEDIUM, summaryMenuTitle, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
	    }
	}
	
	class SummaryMenuDelegate extends WatchUi.Menu2InputDelegate{
	
	    function initialize(){
	        Menu2InputDelegate.initialize();
	    }
	    
	    function onSelect(item){
	        if (item.getId() == :Continue){
	        	LOG("Summary","SummaryMenuDelegate.onSelect(Continue)");
				signal_Summary_unpause();
	        } else if (item.getId() == :Save){
	        	LOG("Summary","SummaryMenuDelegate.onSelect(Save)");
				signal_Summary_saveActivity();
	        } else if (item.getId() == :Discard){
	        	LOG("Summary","SummaryMenuDelegate.onSelect(Discard)");
	        	
				LOAD("DiscardDialogView", discardDialogView, discardDialogDelegate);
	        }
	    }
	}
	
	function showSummaryMenu(){
		LOAD("SummaryMenuView", summaryMenuView, summaryMenuDelegate);
	}		
		
	class DiscardDialogDelegate extends WatchUi.Menu2InputDelegate {
	
	   	function initialize(){
	        Menu2InputDelegate.initialize();
	    }
	    
	    function onSelect(item){
	        if (item.getId() == :Yes){
	        	LOG("Summary","DiscardDialogDelegate.onSelect(Yes)");
	        	
	        	S_ACTIVITY.discard();
	        	S_NOTIFY.signal(NOTIFY.STOP);
	        	System.exit();
	        } else if(item.getId() == :No){
	        	LOG("Summary","DiscardDialogDelegate.onSelect(No)");
	        	
	        	UNLOAD("DiscardDialogView");
	        }
	    }
	}
}