using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.Sensor;

class UtilityService{

	function formatCounter(counter){
		var counterMins = counter/60.toNumber();
        var counterSecs = counter % 60;  
		return Lang.format("$1$:$2$", [counterMins, counterSecs.format("%02d")]);
	}
	
	function formatTimeNow(){
		var timeNow = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
		return Lang.format("$1$:$2$", [timeNow.hour,timeNow.min.format("%02d")]);
	}
	
	function formatCalories(){
		
	}
	
	function formatNullableData(value){
		if (value != null){
			value.toString();
		}
		return "--";
	}
	
	function formatNullableData2(value, suffix){
		return formatNullableData(value)+suffix;
	}
}