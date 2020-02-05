using Toybox.Timer;

class TimerSrvc {
	
	enum {
		REFRESH_VIEW,
		REP_TIME,
		REP_PAUSE_TIME
	}
	
	//Timer structure
	enum {
		PERIOD, 
		COUNTER,
		CALLBACK,
		REPEAT
	}
	
	private var timers = {};
	
	var timer = new Timer.Timer();

	function start() {
		timer.start(method(:timeOut), TIMER_PERIOD, true);
	}
	
	function stop() {
		timers = {};
	}
	
	function pause() {
		timer.stop();
	}
	
	function resume() {
		start();
	}
	
	function add(name, options){
		options.put(:counter, 0);
		timers.put(name, options);
	}
	
	function registerTimer(timerName){
		timers.put(timerName, 0);
	}
	
	function getElapsedTime(name){
		return timers.get(name).get(:counter);
	}
	
	function getRemainingTime(name){
		if(timers.hasKey(name)){
			return timers.get(name).get(:period) - timers.get(name).get(:counter);
		}else {
			return 0;
		}
	}
	
	function removeTimer(name){
		timers.remove(name);
	}
	
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
					timers.remove(name);
				}
			}else {
				timers.get(name).put(:counter, counter);
			}
		}
	}
}