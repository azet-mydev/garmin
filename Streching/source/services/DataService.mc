class DataService{
	
	//Data
	var exerciseNumber = 0;
	
	function getExerciseNumber(){
		return exerciseNumber;
	}
	
	function setExerciseNumber(value){
		exerciseNumber = value;
	}
	
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
}