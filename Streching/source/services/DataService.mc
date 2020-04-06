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
		S_ACTIVITY.reportActivityTime(S_UTILITY.formatCounter(exerciseTime + restTime + pauseTime).substring(0, 7));
		S_ACTIVITY.reportExerciseTime(S_UTILITY.formatCounter(exerciseTime).substring(0, 7));
		S_ACTIVITY.reportRestTime(S_UTILITY.formatCounter(restTime).substring(0, 7));
		S_ACTIVITY.reportPauseTime(S_UTILITY.formatCounter(pauseTime).substring(0, 7));
		
		LOG("DataService", "Shut down, done!");
	}
	
	////////////////////////////////////////////////////
	////////////////////// SETTINGS ////////////////////
	////////////////////////////////////////////////////
	
	function getRepetitionInterval(){
		return Application.Properties.getValue("repetitionInterval");	
	}
	
	function setRepetitionInterval(value){
		Application.Properties.setValue("repetitionInterval", value);
	}
	
	function isLapOn(){
		return Application.Properties.getValue("lapOn");
	}
	
	function setLapOn(value){
		Application.Properties.setValue("lapOn", value);
	}
	
	function isSoundOn(){
		return Application.Properties.getValue("soundOn");
	}
	
	function setSoundOn(value){
		Application.Properties.setValue("soundOn", value);
	}
	
	function isBacklightOn(){
		return Application.Properties.getValue("backlightOn");
	}
	
	function setBacklightOn(value){
		Application.Properties.setValue("backlightOn", value);
	}
	
	function isVibrationOn(){
		return Application.Properties.getValue("vibrationOn");
	}
	
	function setVibrationOn(value){
		Application.Properties.setValue("vibrationOn", value);
	}
	
	////////////////////////////////////////////////////
	////////////////////// CONST ///////////////////////
	////////////////////////////////////////////////////
	
	function getAppVersion(){
		return Application.Properties.getValue("appVersion");
	}
	
	function getBaseTimePeriod(){
		return Application.Properties.getValue("baseTimePeriod");
	}

	function getRefreshPeriod(){
		return Application.Properties.getValue("refreshPeriod");
	}

	function getNotifyLightOffPeriod(){
		return Application.Properties.getValue("notifyLightOffPeriod");
	}
	
	function getSummaryMenuAppearPeriod(){
		return Application.Properties.getValue("summaryMenuAppearPeriod");
	}
	
	function getSummaryMenuTitleSlideChangePeriod(){
		return Application.Properties.getValue("summaryMenuTitleSlideChangePeriod");
	}
	
	function getExerciseNumberDisappearPeriod(){
		return Application.Properties.getValue("exerciseNumberDisappearPeriod");
	}
	
}