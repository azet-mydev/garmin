class DataService{
	
	////////////////////////////////////////////////////
	////////////////////// DATA ////////////////////////
	////////////////////////////////////////////////////

	var exercise = 0;
	var exerciseTime = 0;
	var restTime = 0;
	var pauseTime = 0;
	
	function addExercise(){
		exercise++;
	}
	
	function getExercise(){
		return exercise;
	}
	
	function getActivityTime(){
		return exerciseTime + restTime;
	}
	
	function addExerciseTime(value){
		exerciseTime = exerciseTime + value;
	}
	
	function addRestTime(value){
		restTime = restTime + value;
	}
	
	function addPauseTime(value){
		pauseTime = pauseTime + value;
	}
	
	function writeToActivity(){
		LOG("DataService", "Re-writing data to fit file");
		
		S_ACTIVITY.reportNumberOfExercises(exercise.toString());
		S_ACTIVITY.reportActivityTime(S_UTILITY.formatCounter(getActivityTime()).substring(0, 7));
		S_ACTIVITY.reportExerciseTime(S_UTILITY.formatCounter(exerciseTime).substring(0, 7));
		S_ACTIVITY.reportRestTime(S_UTILITY.formatCounter(restTime).substring(0, 7));
		S_ACTIVITY.reportPauseTime(S_UTILITY.formatCounter(pauseTime).substring(0, 7));
		
		LOG("DataService", "Shut down, done!");
	}
}