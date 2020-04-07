class ConfigService{

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
	
	function isLoggingOn(){
		return Application.Properties.getValue("loggingOn");
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