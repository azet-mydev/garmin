class CFG {

	enum {
		ACTIVITY_LAP,
		ACTIVITY_SOUND,
		ACTIVITY_BACKLIGHT,
		ACTIVITY_VIBRATION
	}
}

class DataService{

	var cfg;
	
	function init(cfg){
		self.cfg = cfg;
	}
	
	//Data
	var exerciseNumber = 0;
}