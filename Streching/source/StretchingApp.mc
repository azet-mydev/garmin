using Toybox.Application;
using Toybox.Sensor;
using Toybox.System;

class StretchingApp extends Application.AppBase{
	
    function initialize(){
    	LOG("StretchingApp", "Starting application: " + S_CONFIG.getAppVersion());
    	LOG("StretchingApp", "partNumber: " + System.getDeviceSettings().partNumber);
    	LOG("StretchingApp", "firmwareVersion: " + System.getDeviceSettings().firmwareVersion);
    	LOG("StretchingApp", "monkeyVersion: " + System.getDeviceSettings().monkeyVersion);
    	LOG("StretchingApp", "systemLanguage: " + System.getDeviceSettings().systemLanguage);
    	LOG("StretchingApp", "uniqueIdentifier: " + System.getDeviceSettings().uniqueIdentifier);
    	
        AppBase.initialize();
        Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
		
		var stateMachineConfig = {
        	SM.INITIAL => {:view => new Initial.InitialView(), :delegate => new Initial.InitialDelegate()},
        	SM.EXERCISE => {:view => new Exercise.ExerciseView(), :delegate => new Exercise.ExerciseDelegate()},
        	SM.REST => {:view => new Rest.RestView(), :delegate => new Rest.RestDelegate()},
        	SM.SUMMARY => {:view => new Summary.SummaryView(), :delegate => new Summary.SummaryDelegate()}}; 
        S_SM.init(stateMachineConfig);
    }

    function onStart(state){
    	LOG("StretchingApp", "Application started!");
    }

    function onStop(state){
    	LOG("StretchingApp", "Shuting down application");
    	
    	S_TIMER.shutdown();
    	
    	LOG("StretchingApp", "Shut down successful, exit!");
    }

    function getInitialView(){
        return S_SM.transition(SM.INITIAL);
    }

    function onSettingsChanged(){
    	LOG("StretchingApp", "Changed settings via Garmin Connect");
    }
}