using Toybox.ActivityRecording;
using Toybox.WatchUi;

class ActivityService
{
	var session = null;
	
	function start(){
        session = ActivityRecording.createSession({:name=>WatchUi.loadResource( Rez.Strings.AppName ),
        										:sport=>ActivityRecording.SPORT_TRAINING,
        										:subSport=>ActivityRecording.SUB_SPORT_FLEXIBILITY_TRAINING});
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
		if(S_DATA.isLapOn()){
			session.addLap();
		}
	}
	
	function discard(){
		session.discard();
		session = null;
	}
	
}