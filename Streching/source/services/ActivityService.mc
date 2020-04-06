using Toybox.ActivityRecording;
using Toybox.WatchUi;
using Toybox.FitContributor;

class ActivityService
{
	var session = null;
	
	const ACTIVITY_TIMELINE_FIELDID = 0;
	var activityTimeline;
	const NUMBER_OF_EXERCISES_FIELDID = 1;
	var numberOfExercises;
	const ACTIVITY_TIME_FIELDID = 2;
	var activityTime;
	const EXERCISE_TIME_FIELDID = 3;
	var exerciseTime;
	const REST_TIME_FIELDID = 4;
	var restTime;
	const PAUSE_TIME_FIELDID = 5;
	var pauseTime; 
	
	function start(){
        session = ActivityRecording.createSession({:name=>WatchUi.loadResource( Rez.Strings.AppName ),
        										:sport=>ActivityRecording.SPORT_TRAINING,
        										:subSport=>ActivityRecording.SUB_SPORT_FLEXIBILITY_TRAINING});
		
		activityTimeline = session.createField(WatchUi.loadResource(Rez.Strings.ActivityTimeline), ACTIVITY_TIMELINE_FIELDID, FitContributor.DATA_TYPE_UINT8, {});
		numberOfExercises = session.createField(WatchUi.loadResource(Rez.Strings.NumberOfExercises), NUMBER_OF_EXERCISES_FIELDID, FitContributor.DATA_TYPE_STRING, {:mesgType=>FitContributor.MESG_TYPE_SESSION, :count=>8});
		activityTime = session.createField(WatchUi.loadResource(Rez.Strings.ActivityTime), ACTIVITY_TIME_FIELDID, FitContributor.DATA_TYPE_STRING, {:mesgType=>FitContributor.MESG_TYPE_SESSION, :count=>8});
		exerciseTime = session.createField(WatchUi.loadResource(Rez.Strings.ExerciseTime), EXERCISE_TIME_FIELDID, FitContributor.DATA_TYPE_STRING, {:mesgType=>FitContributor.MESG_TYPE_SESSION, :count=>8});
		restTime = session.createField(WatchUi.loadResource(Rez.Strings.RestTime), REST_TIME_FIELDID, FitContributor.DATA_TYPE_STRING, {:mesgType=>FitContributor.MESG_TYPE_SESSION, :count=>8});
		pauseTime = session.createField(WatchUi.loadResource(Rez.Strings.PauseTime), PAUSE_TIME_FIELDID, FitContributor.DATA_TYPE_STRING, {:mesgType=>FitContributor.MESG_TYPE_SESSION, :count=>8});
		        										
        session.start();
	}
	
	function reportActivityTimeline(value){
		activityTimeline.setData(value);
	}
	
	function reportNumberOfExercises(value){
		LOG("ActivityService", "numberOfExercises:" + value);
		numberOfExercises.setData(value);
	}
	
	function reportActivityTime(value){
		LOG("ActivityService", "activityTime:" + value);
		activityTime.setData(value);
	}
	
	function reportExerciseTime(value){
		LOG("ActivityService", "exercisesTime:" + value);
		exerciseTime.setData(value);
	}
	
	function reportRestTime(value){
		LOG("ActivityService", "restingTime:" + value);
		restTime.setData(value);
	}
	
	function reportPauseTime(value){
		LOG("ActivityService", "pauseTime:" + value);
		pauseTime.setData(value);
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