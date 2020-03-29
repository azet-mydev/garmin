using Toybox.ActivityRecording;
using Toybox.WatchUi;

const SCREEN_TRANSITION = WatchUi.SLIDE_IMMEDIATE;

const ACTIVITY_SPORT = ActivityRecording.SPORT_TRAINING;
const ACTIVITY_SUB_SPORT = ActivityRecording.SUB_SPORT_FLEXIBILITY_TRAINING;

const BASE_TIMER_PERIOD = 1000;
const REFRESH_PERIOD = 1;
const NOTIFY_LIGHT_OFF_PERIOD = 5;
const SUMMENU_APPEAR_PERIOD = 2;
const SUMMMENU_TITLE_CHANGE_PERIOD = 3;
const EXERCISE_NUMBER_PERIOD = 2;

//Default values
(:debug) const DEFAULT_REPETITION_INTERVAL = 5;
(:release) const DEFAULT_REPETITION_INTERVAL = 90;