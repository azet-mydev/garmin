class CFG {

	enum {
		REPETITION_INTERVAL,
		ACTIVITY_LAP,
		ACTIVITY_SOUND,
		ACTIVITY_BACKLIGHT,
		ACTIVITY_VIBRATION
	}
}

class DataService{

	//ToDo: Define keys used in here for better visibility
	
	var cfg;
	
	function init(cfg){
		self.cfg = cfg;
	}
	
	//Data
	var exerciseNumber = 0;
}