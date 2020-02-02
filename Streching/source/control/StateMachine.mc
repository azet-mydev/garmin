//TODO: Should be moved to class level and be private (circular dependency issue)

//Views
var initialView = new InitialView();
var exerciseView = new ExerciseView();

//Delegates
var startExerciseDelegate = new StartExerciseDelegate();
var startedExerciseDelegate = new StartedExerciseDelegate();

class StateMachine {

	enum {
		INITIAL,
		STARTED
	}
	
	enum {
		START,
		STOP
	}
	
	var currentState = INITIAL;
	
	function transition(action){
		switch(currentState) {
			case INITIAL: {
				initial(action);
				break;
			}
			case STARTED: {
				started(action);
				break;
			}
		}
	}
	
	private function initial(action){
		switch(action) {
			case START: {
				WatchUi.switchToView(exerciseView, startedExerciseDelegate, WatchUi.SLIDE_IMMEDIATE);
				currentState=STARTED;
				break;
			}
			case STOP: {
				
				break;
			}
		}
	}
	
	private function started(action){
		switch(action) {
			case START: {
				
				break;
			}
			case STOP: {
				WatchUi.switchToView(initialView, startExerciseDelegate, WatchUi.SLIDE_IMMEDIATE);
				currentState=INITIAL;
				break;
			}
		}
	}
}