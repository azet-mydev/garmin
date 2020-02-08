class SM {

	enum {
		INITIAL,
		EXERCISE,
		REST,
		SUMMARY
	}
}

class StateMachineService {

	var config;
	var stateIndex = -1;
	var stateHistory = {};
	
	function init(config){
		self.config = config;
	}
	
	function saveHistory(newState){
		stateIndex++;
		stateHistory.put(stateIndex, newState);
	}
	
	function getHistory(index){
		return stateHistory.get(stateIndex + index);
	}

	function transition(newState){
		if(newState<0){
			newState = getHistory(newState);
		}
		
		saveHistory(newState);
		
		var view = config.get(newState).get(:view);
		var delegate = config.get(newState).get(:delegate);
		WatchUi.switchToView(view, delegate, SCREEN_TRANSITION);
		
		return [view, delegate];
	}
}