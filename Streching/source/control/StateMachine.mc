//TODO: Should be moved to class level and be private (circular dependency issue)

//Views
var initialView = new InitialView();
var exerciseView = new ExerciseView();
var restView = new RestView();
var summaryView = new SummaryView(); 

//Delegates
var initialDelegate = new InitialDelegate();
var exerciseDelegate = new ExerciseDelegate();
var restDelegate = new RestDelegate();
var summaryDelegate = new SummaryDelegate();

class StateMachine {

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
	
	var currentState = INITIAL;
	var previousState = null;
	
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