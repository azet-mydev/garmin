using Toybox.Timer;

class TimerSrvc {
	
	enum {
		REFRESH_VIEW,
		REP_TIME,
		REP_PAUSE_TIME
	}

	private var periods = {};
	private var counters = {};
	private var callbacks = {};
	private var timers = {};
	
	var timer = new Timer.Timer();

	function start() {
		timer.start(method(:timeOut), TIMER_PERIOD, true);
	}
	
	function stop() {
		timer.stop();
		periods = {};
		counters = {};
		callbacks = {};
		timers = {};
	}
	
	function pause() {
		timer.stop();
	}
	
	function resume() {
		start();
	}
	
	function registerCallback(timerName, period, callback, repeat){
		counters.put(timerName, period);
		callbacks.put(timerName, callback);
		
		if(repeat){
			periods.put(timerName, period);
		}
	}
	
	function registerTimer(timerName){
		timers.put(timerName, 0);
	}
	
	function getCounter(timerName){
		return counters.get(timerName);
	}
	
	function getTimer(timerName){
		return timers.get(timerName);
	}
	
	function removeTimer(timerName){
		timers.remove(timerName);
	}
	
	function timeOut(){
		for( var i = 0; i < counters.keys().size(); i += 1 ) {
			var key = counters.keys()[i];
			var val = counters.get(key);
			val--;
			if(val==0){
				callbacks.get(key).invoke();
				if(periods.hasKey(key)){
					counters.put(key, periods.get(key));
				}else {
					counters.remove(key);
					callbacks.remove(key);
				}
			}else{
				counters.put(key, val);
			}
		}
		
		for( var i = 0; i < timers.keys().size(); i += 1 ) {
			var key = timers.keys()[i];
			var val = timers.get(key);
			val++;
			timers.put(key, val);
		}
	}
}