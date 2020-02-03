//TODO: Should be moved to class level and be private (circular dependency issue)


class SmSrvc {

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
	
	//Views
	private var initialView = new InitialView();
	private var exerciseView = new ExerciseView();
	private var restView = new RestView();
	private var summaryView = new SummaryView(); 

	//Delegates
	private var initialDelegate = new InitialDelegate();
	private var exerciseDelegate = new ExerciseDelegate();
	private var restDelegate = new RestDelegate();
	private var summaryDelegate = new SummaryDelegate();
	
	private var currentState = INITIAL;
	private var previousState = null;
	
	function transition(action){
		switch(currentState) {
			case INITIAL: {
				initial(action);
				break;
			}
			case EXERCISE: {
				exercise(action);
				break;
			}
			case REST: {
				resting(action);
				break;
			}
			case SUMMARY: {
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
			case SELECT: {
				moveState(EXERCISE);
				break;
			}
		}
	}
	
	private function exercise(action){
		switch(action) {
			case SELECT: {
				moveState(SUMMARY);
				break;
			}
			case EXERCISE_TIMEOUT: {
				moveState(REST);
				break;	
			}
		}
	}
	
	private function resting(action){
		switch(action) {
			case BACK: {
				moveState(EXERCISE);
				break;
			}
			case SELECT: {
				moveState(SUMMARY);
				break;
			}
		}
	}
	
	private function summary(action){
		switch(action) {
			case SELECT: {
				moveState(previousState);
				break;
			}
		}
	}
	
	private function moveState(newState){
		previousState = currentState;
		currentState = newState;
		
		switch(newState) {
			case INITIAL: {
				WatchUi.switchToView(initialView, initialDelegate, SCREEN_TRANSITION);
				break;
			}
			case EXERCISE: {
				WatchUi.switchToView(exerciseView, exerciseDelegate, SCREEN_TRANSITION);
				break;
			}
			case REST: {
				WatchUi.switchToView(restView, restDelegate, SCREEN_TRANSITION);
				break;
			}
			case SUMMARY: {
				WatchUi.switchToView(summaryView, summaryDelegate, SCREEN_TRANSITION);
				break;
			}
		}
	}
}