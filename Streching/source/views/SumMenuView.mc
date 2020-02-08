using Toybox.Activity;

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