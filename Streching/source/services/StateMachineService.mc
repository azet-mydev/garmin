class SM {

	enum {
		INITIAL,
		EXERCISE,
		REST,
		SUMMARY
	}
	
	enum {
		SELECT,
		BACK,
		EXERCISE_TIMEOUT
	}
}

class StateMachineService {
	
	//Views
	private var initialView;
	private var exerciseView;
	private var restView;
	private var summaryView; 

	//Delegates
	private var initialDelegate;
	private var exerciseDelegate;
	private var restDelegate;
	private var summaryDelegate;
	
	function init(
					_initialView,
					_exerciseView,
					_restView,
					_summaryView,
					_initialDelegate,
					_exerciseDelegate,
					_restDelegate,
					_summaryDelegate,
					_currentState
					){
		initialView = _initialView;
		exerciseView = _exerciseView;
		restView = _restView;
		summaryView = _summaryView;
		initialDelegate = _initialDelegate;
		exerciseDelegate = _exerciseDelegate;
		restDelegate = _restDelegate;
		summaryDelegate = _summaryDelegate;
		
		currentState = _currentState;
	}
	
	private var currentState;
	private var previousState;
	
	function transition(action){
		switch(currentState) {
			case SM.INITIAL: {
				initial(action);
				break;
			}
			case SM.EXERCISE: {
				exercise(action);
				break;
			}
			case SM.REST: {
				resting(action);
				break;
			}
			case SM.SUMMARY: {
				summary(action);
				break;
			}
		}
	}
	
	function getInit() {
		return [initialView, initialDelegate];
	}
	
	private function initial(action){
		switch(action) {
			case SM.SELECT: {
				moveState(SM.EXERCISE);
				break;
			}
		}
	}
	
	private function exercise(action){
		switch(action) {
			case SM.SELECT: {
				moveState(SM.SUMMARY);
				break;
			}
			case SM.EXERCISE_TIMEOUT: {
				moveState(SM.REST);
				break;	
			}
		}
	}
	
	private function resting(action){
		switch(action) {
			case SM.BACK: {
				moveState(SM.EXERCISE);
				break;
			}
			case SM.SELECT: {
				moveState(SM.SUMMARY);
				break;
			}
		}
	}
	
	private function summary(action){
		switch(action) {
			case SM.SELECT: {
				moveState(previousState);
				break;
			}
		}
	}
	
	private function moveState(newState){
		previousState = currentState;
		currentState = newState;
		
		switch(newState) {
			case SM.INITIAL: {
				WatchUi.switchToView(initialView, initialDelegate, SCREEN_TRANSITION);
				break;
			}
			case SM.EXERCISE: {
				WatchUi.switchToView(exerciseView, exerciseDelegate, SCREEN_TRANSITION);
				break;
			}
			case SM.REST: {
				WatchUi.switchToView(restView, restDelegate, SCREEN_TRANSITION);
				break;
			}
			case SM.SUMMARY: {
				WatchUi.switchToView(summaryView, summaryDelegate, SCREEN_TRANSITION);
				break;
			}
		}
	}
}