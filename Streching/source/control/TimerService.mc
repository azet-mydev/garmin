using Toybox.Timer;

class TimerService{

	var periods = {};
	var counters = {};
	var callbacks = {};
	
	var timer = new Timer.Timer();
	
	var period = 0;
	

	function start(){
		timer.start(method(:timeOut), TIMER_PERIOD, true);
	}
	
	function timeOut(){
		for( var i = 0; i < periods.keys().size(); i += 1 ) {
			var key = periods.keys()[i];
			var val = counters.get(key);
			val--;
			if(val==0){
				callbacks.get(key).invoke();
				counters.put(key, periods.get(key));
			}else{
				counters.put(key, val);
			}
		}
	}
	
	function registerCallback(timerName, period, callback){
		periods.put(timerName, period);
		counters.put(timerName, period);
		callbacks.put(timerName, callback);
	}
	
	function getCounter(key){
		return counters.get(key);
	}

}