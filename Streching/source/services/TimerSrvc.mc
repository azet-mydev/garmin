using Toybox.Timer;

class TIMER {

	enum {
		REFRESH_VIEW,
		REP_TIME,
		REP_PAUSE_TIME
	}
}

class TimerService {

////////////////////////////////////////////////////
////////////////////// PUBLIC //////////////////////
////////////////////////////////////////////////////
	
	function schedule(name, options){
		options.put(:counter, 0);
		timers.put(name, options);
		start();
	}
	
	function remove(name){
		timers.remove(name);
		stop();		
	}
	
	function pause(name){
		pausedTimers.put(name, timers.get(name));
		timers.remove(name);
	}
	
	function resume(name){
		if(pausedTimers.hasKey(name)){
			timers.put(name, pausedTimers.get(name));
			pausedTimers.remove(name);
			return true;
		}
		return false;
	}
	
	function reset(name){
		timers.get(name).put(:counter,0);
	}
	
	public function getElapsedTime(name){
		return timers.get(name).get(:counter);
	}
	
	function getRemainingTime(name){
		if(timers.hasKey(name)){
			return timers.get(name).get(:period) - timers.get(name).get(:counter);
		}else {
			return 0;
		}
	}
	
	function shutdown(){
		timers = {};
		pausedTimers = {};
		baseTimer.stop();
		baseTimer = null;
	}
	
////////////////////////////////////////////////////
////////////////////// PRIVATE /////////////////////
////////////////////////////////////////////////////	
	
	private var timers = {};
	private var pausedTimers = {};
	
	private var baseTimer = new Timer.Timer();
	private var isBaseTimerOn = false;
	
	function timeOut(){
		for( var i = 0; i < timers.keys().size(); i += 1 ) {
			var name = timers.keys()[i];
			var counter = timers.get(name).get(:counter);
			var period = timers.get(name).get(:period);
			
			counter++;
			
			if(counter==period){
				var repeat = timers.get(name).get(:repeat);
				var callback = timers.get(name).get(:callback);
				
				if (callback!=null){
					callback.invoke();
				}
				if(repeat){
					timers.get(name).put(:counter,0);
				}else {
					remove(name);
				}
			}else {
				timers.get(name).put(:counter, counter);
			}
		}
	}
	
	private function start() {
		if(!isBaseTimerOn){
			baseTimer.start(method(:timeOut), BASE_TIMER_PERIOD, true);
			isBaseTimerOn = true;
		}
	}
	
	private function stop() {
		if(timers.size()==0){
			baseTimer.stop();
			isBaseTimerOn = false;
		}	
	}
}