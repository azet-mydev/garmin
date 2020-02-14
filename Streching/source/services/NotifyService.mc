using Toybox.Attention;

class NOTIFY {
	enum {
		START, 
		STOP,
		LAP, 
		TIMEOUT
	}
}

class NotifyService{

	function signal(action){
		switch(action) {
			case NOTIFY.START: {
				start();
				vibrate();
				blink();
				break;
			}
			case NOTIFY.STOP: {
				stop();
				vibrate();
				blink();
				break;
			}
			case NOTIFY.LAP: {
				lap();
				vibrate();
				blink();
				break;
			}
			case NOTIFY.TIMEOUT: {
				timeout();
				vibrate();
				blink();
				break;
			}
		}	
	}
	
	private function vibrate(){
	    var vibrateData = [
	            new Attention.VibeProfile(  25, 100 ),
	            new Attention.VibeProfile(  50, 100 ),
	            new Attention.VibeProfile(  75, 100 ),
	            new Attention.VibeProfile( 100, 100 ),
	            new Attention.VibeProfile(  75, 100 ),
	            new Attention.VibeProfile(  50, 100 ),
	            new Attention.VibeProfile(  25, 100 )
	          ];
	
	    Attention.vibrate(vibrateData);
	}
	
	private function stop(){
		Attention.playTone(Attention.TONE_STOP);
	}
	
	private function start(){
		Attention.playTone(Attention.TONE_START);
	}
	
	private function lap(){
		Attention.playTone(Attention.TONE_LAP);
	}
	
	private function timeout(){
		Attention.playTone(Attention.TONE_LOUD_BEEP);
	}
	
	private function blink(){
		Attention.backlight(true);
		if(S_TIMER.isRunning(TIMER.NOTIFY_LIGHT_OFF)){
			S_TIMER.remove(TIMER.NOTIFY_LIGHT_OFF);
		}
		S_TIMER.schedule(TIMER.NOTIFY_LIGHT_OFF, {
			:period => NOTIFY_LIGHT_OFF_PERIOD,
			:callback => method(:notifyLightOff_callback),
			:repeat => false});
	}
	
	function notifyLightOff_callback(){
		Attention.backlight(false);
	}
}