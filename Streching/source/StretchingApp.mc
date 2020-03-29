using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Sensor;

class StretchingApp extends Application.AppBase {
	
    function initialize() {
        AppBase.initialize();
        Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
        
        //ToDo: Add default values for those confings in Const.mc
        var settingsConfig = {
        	CFG.REPETITION_INTERVAL => {:name=>Rez.Strings.interval, :value=>DEFAULT_REPETITION_INTERVAL},
			CFG.ACTIVITY_LAP => {:name=>Rez.Strings.lap, :value=>false},
			CFG.ACTIVITY_SOUND => {:name=>Rez.Strings.sound, :value=>false},
			CFG.ACTIVITY_BACKLIGHT => {:name=>Rez.Strings.backlight, :value=>true},
			CFG.ACTIVITY_VIBRATION => {:name=>Rez.Strings.vibration, :value=>true}};
		S_DATA.init(settingsConfig);
		
		var stateMachineConfig = {
        	SM.INITIAL => {:view => new Initial.InitialView(), :delegate => new Initial.InitialDelegate()},
        	SM.EXERCISE => {:view => new Exercise.ExerciseView(), :delegate => new Exercise.ExerciseDelegate()},
        	SM.REST => {:view => new Rest.RestView(), :delegate => new Rest.RestDelegate()},
        	SM.SUMMARY => {:view => new Summary.SummaryView(), :delegate => new Summary.SummaryDelegate()}}; 
        S_SM.init(stateMachineConfig);
        
        LOG("StretchingApp", "Starting application");
    }

    function onStart(state) {
    }

    function onStop(state) {
    	S_TIMER.shutdown();
    }

    function getInitialView() {
        return S_SM.transition(SM.INITIAL);
    }
}