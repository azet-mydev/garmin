//TODO: Should be moved to class level and be private (circular dependency issue)

//Views
var startView = new StartView();
var exerciseView = new ExerciseView();

//Delegates
var startExerciseDelegate = new StartExerciseDelegate();
var startedExerciseDelegate = new StartedExerciseDelegate();

class StateMachine {

	enum {
		NOT_STARTED,
		STARTED
	}
	
	enum {
		START,
		STOP
	}
	
	function transition(state, action){
		switch(state) {
			case NOT_STARTED: {
				notStarted(action);
				break;
			}
			case STARTED: {
				started(action);
				break;
			}
		}
	}
	
	private function notStarted(action){
		switch(action) {
			case START: {
				WatchUi.switchToView(exerciseView, startedExerciseDelegate, WatchUi.SLIDE_IMMEDIATE);
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
				WatchUi.switchToView(startView, startExerciseDelegate, WatchUi.SLIDE_IMMEDIATE);
				break;
			}
		}
	}
}