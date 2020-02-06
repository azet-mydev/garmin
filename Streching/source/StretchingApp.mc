using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Sensor;

class StretchingApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
        Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
        
        S_SM.init(
        	new InitialView(),
			new ExerciseView(),
			new RestView(),
			new SummaryView(),
			new InitialDelegate(),
			new ExerciseDelegate(),
			new RestDelegate(),
			new SummaryDelegate(),
			SM.INITIAL
		);
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    	S_TIMER.shutdown();
    }

    // Return the initial view of your application here
    function getInitialView() {
        return S_SM.getInit();
    }
}