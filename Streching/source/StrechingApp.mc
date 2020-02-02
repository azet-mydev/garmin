using Toybox.Application;
using Toybox.WatchUi;

//Global variables

//Control
var stateMachine = new StateMachine();
var activityControl = new ActivityControl();

class StrechingApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
        Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
//        return [ new StrechingView(), new StrechingDelegate() ];
        return [ new StartView(), new StartExerciseDelegate() ];
    }

}
