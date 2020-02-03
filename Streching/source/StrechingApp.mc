using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Sensor;

//Global variables
var s;

class StrechingApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
        Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);
		
		// Initialize services
		var activitySrvc = new ActivitySrvc();
		var smSrvc = new SmSrvc();
		var timerSrvc = new TimerSrvc();
		var notifySrvc = new NotifySrvc();

	    var services = {
			S.ACTIVITY => activitySrvc,
			S.SM => smSrvc,
			S.TIMER => timerSrvc,
			S.NOTIFY => notifySrvc
		};
        s = new S(services);
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return $.s.get(S.SM).getInit();
    }
}