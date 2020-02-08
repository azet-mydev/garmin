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
        	SM.INITIAL => {:view => new Initial.InitialView(), :delegate => new Initial.InitialDelegate()},
        	SM.EXERCISE => {:view => new Exercise.ExerciseView(), :delegate => new Exercise.ExerciseDelegate()},
        	SM.REST => {:view => new Rest.RestView(), :delegate => new Rest.RestDelegate()},
        	SM.SUMMARY => {:view => new Summary.SummaryView(), :delegate => new Summary.SummaryDelegate()},
        	SM.SUMMENU => {:view => new Summary.SumMenuView(), :delegate => new Summary.SummaryMenuDelegate()}}; 
        
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