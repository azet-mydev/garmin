using Toybox.ActivityRecording;

class ActivityControl
{

	//Config
	const ACTIVITY_NAME = "Stretching";
	const ACTIVITY_SPORT = ActivityRecording.SPORT_FITNESS_EQUIPMENT;
	const ACTIVITY_SUB_SPORT = ActivityRecording.SUB_SPORT_STRENGTH_TRAINING;
	
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
		//TODO: to be implemented
	}
	
}