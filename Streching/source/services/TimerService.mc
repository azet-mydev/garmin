using Toybox.Timer;

class TIMER{

	enum{
		REFRESH_VIEW,
		REP_TIME,
		REP_PAUSE_TIME,
		NOTIFY_LIGHT_OFF,
		SUMMENU_APPEAR,
		SUMMMENU_TITLE_CHANGE,
		EXERCISE_NUMBER,
		EXERCISE_TIME,
		REST_TIME,
		PAUSE_TIME
	}
	
	function toString(name){
		switch (name){
			case TIMER.REFRESH_VIEW:
				return "REFRESH_VIEW";
			case TIMER.REP_TIME:
				return "REP_TIME";
			case TIMER.REP_PAUSE_TIME:
				return "REP_PAUSE_TIME";
			case TIMER.NOTIFY_LIGHT_OFF:
				return "NOTIFY_LIGHT_OFF";
			case TIMER.SUMMENU_APPEAR:
				return "SUMMENU_APPEAR";
			case TIMER.SUMMMENU_TITLE_CHANGE:
				return "SUMMMENU_TITLE_CHANGE";
			case TIMER.EXERCISE_NUMBER:
				return "EXERCISE_NUMBER";
			case TIMER.EXERCISE_TIME:
				return "EXERCISE_TIME";
			case TIMER.REST_TIME:
				return "REST_TIME";
			case TIMER.PAUSE_TIME:
				return "PAUSE_TIME";												
		}
	}
}

class TimerService{

////////////////////////////////////////////////////
////////////////////// PUBLIC //////////////////////
////////////////////////////////////////////////////
	
	function schedule(name, options){
		if(timers.hasKey(name)){
			LOG("TimerService", "Timer:" + TIMER.toString(name) + " already scheduled, overriding!");
		}
		
		options.put(:counter, 0);
		timers.put(name, options);
		
		LOG("TimerService", "Scheduling timer:" + TIMER.toString(name) + ", period:" + options.get(:period));
		
		start();

	}
	
	function remove(name){
		var counter = timers.get(name).get(:counter);
		timers.remove(name);
		
		LOG("TimerService", "Removing timer:" + TIMER.toString(name));
		
		stop();
		return counter;		
	}
	
	function pause(name){
		pausedTimers.put(name, timers.get(name));
		
		LOG("TimerService", "Pausing timer:" + TIMER.toString(name));
		
		timers.remove(name);
	}
	
	function resume(name){
		if(pausedTimers.hasKey(name)){
			timers.put(name, pausedTimers.get(name));
			pausedTimers.remove(name);
			
			LOG("TimerService", "Resuming timer:" + TIMER.toString(name));
			
			return true;
		}
		
		LOG("TimerService", "Not able to resume timer:" + TIMER.toString(name) +", timer not paused!");
		
		return false;
	}
	
	function reset(name, options){
		if(options.hasKey(:period)){
			LOG("TimerService", "name:" + TIMER.toString(name));
			LOG("TimerService", "period1:" + options.get(:period));
			LOG("TimerService", "size:" + timers.size());
			LOG("TimerService", "hasKey:" + timers.hasKey(name));
			LOG("TimerService", "period2:" + timers.get(name).get(:period));
			timers.get(name).put(:period, options.get(:period));
		}
		timers.get(name).put(:counter,0);
		
		LOG("TimerService", "Reseting timer:" + TIMER.toString(name) +", period:" + timers.get(name).get(:period));
	}
	
	function isRunning(name){
		return timers.hasKey(name);
	}
	
	function isNotRunning(name){
		return !timers.hasKey(name);
	}
	
	function isPaused(name){
		return pausedTimers.hasKey(name);
	}
	
	function isNotPaused(name){
		return !pausedTimers.hasKey(name);
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
		LOG("TimerService", "Shuting down timer service, no of timers:" + timers.size() +", paused timers:" + pausedTimers.size());
		
		timers = {};
		pausedTimers = {};
		baseTimer.stop();
		baseTimer = null;
		
		LOG("TimerService", "Shut down, done!");
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
			var callback = timers.get(name).get(:callback);
			var repeat = timers.get(name).get(:repeat);
			
			counter++;
			
			if(counter==period){
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
				if (period==null and callback!=null){
					callback.invoke();
				}
			}
		}
	}
	
	private function start() {
		if(!isBaseTimerOn){
			baseTimer.start(method(:timeOut), S_CONFIG.getBaseTimePeriod(), true);
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