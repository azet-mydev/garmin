using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Sensor;
using Toybox.System;

class StretchingApp extends Application.AppBase {
	
	var stateMachineConfig;

    function initialize() {
        AppBase.initialize();
        Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
        
        stateMachineConfig = {
        	SM.INITIAL => {:view => new InitialView(), :delegate => new InitialDelegate()},
        	SM.EXERCISE => {:view => new ExerciseView(), :delegate => new ExerciseDelegate()},
        	SM.REST => {:view => new RestView(), :delegate => new RestDelegate()},
        	SM.SUMMARY => {:view => new SummaryView(), :delegate => new SummaryDelegate()},
        	SM.SUMMENU => {:view => new SumMenuView(), :delegate => new SummaryMenuDelegate()}}; 
        
        S_SM.init(stateMachineConfig);
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