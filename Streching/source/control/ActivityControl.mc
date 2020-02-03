using Toybox.ActivityRecording;

class ActivityControl
{
	var session = null;
	
	function start(){
        session = ActivityRecording.createSession({:name=>ACTIVITY_NAME,
        										:sport=>ACTIVITY_SPORT,
        										:subSport=>ACTIVITY_SUB_SPORT});
        session.start();
	}
	
	function stop(){
		session.stop();
		session.save();
		session = null;
	}
	
	function pause(){
		session.stop();
	}
	
	function resume(){
		session.start();
	}
	
	function isRecording(){
		if(session != null){
			return session.isRecording();
		} else {
			return false;
		}
	}
	
	function lap(){
		session.addLap();
	}
	
	function discard(){
		session.discard();
		session = null;
	}
	
}