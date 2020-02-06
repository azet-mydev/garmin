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
				break;
			}
			case NOTIFY.STOP: {
				stop();
				vibrate();
				break;
			}
			case NOTIFY.LAP: {
				lap();
				vibrate();
				break;
			}
			case NOTIFY.TIMEOUT: {
				timeout();
				vibrate();
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
}