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

    var vibrateData = [
        new Attention.VibeProfile(  25, 100 ),
        new Attention.VibeProfile(  50, 100 ),
        new Attention.VibeProfile(  75, 100 ),
        new Attention.VibeProfile( 100, 100 ),
        new Attention.VibeProfile(  75, 100 ),
        new Attention.VibeProfile(  50, 100 ),
        new Attention.VibeProfile(  25, 100 )
      ];

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
		if(S_DATA.cfg_activityVibration){
		    Attention.vibrate(vibrateData);
	    }
	}
	
	private function stop(){
		if(S_DATA.cfg_activitySound){
			Attention.playTone(Attention.TONE_STOP);
		}
	}
	
	private function start(){
		if(S_DATA.cfg_activitySound){
			Attention.playTone(Attention.TONE_START);
		}
	}
	
	private function lap(){
		if(S_DATA.cfg_activitySound){
			Attention.playTone(Attention.TONE_LAP);
		}
	}
	
	private function timeout(){
		if(S_DATA.cfg_activitySound){
			Attention.playTone(Attention.TONE_LOUD_BEEP);
		}
	}
	
	private function blink(){
		if(S_DATA.cfg_activityBacklight){
			Attention.backlight(true);
			if(S_TIMER.isRunning(TIMER.NOTIFY_LIGHT_OFF)){
				S_TIMER.remove(TIMER.NOTIFY_LIGHT_OFF);
			}
			S_TIMER.schedule(TIMER.NOTIFY_LIGHT_OFF, {
				:period => NOTIFY_LIGHT_OFF_PERIOD,
				:callback => method(:notifyLightOff_callback),
				:repeat => false});	
		}
	}
	
	function notifyLightOff_callback(){
		Attention.backlight(false);
	}
}