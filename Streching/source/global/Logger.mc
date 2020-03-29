using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.System;
using Toybox.Lang;

function LOG(name, msg){
	var timestamp = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
	System.println(Lang.format(
	    "$1$-$2$-$3$ $4$:$5$:$6$-$7$  $8$ $9$",
	    [
	        timestamp.year,//.format("%04d"),
	        timestamp.month,//.format("%02d"),
	        timestamp.day.format("%02d"),
	        timestamp.hour.format("%02d"),
	        timestamp.min.format("%02d"),
	        timestamp.sec.format("%02d"),
	        System.getTimer().format("%08d"),
	        (name.toUpper() + "                ").substring(0, 15),
	        msg
	    ]
	));
}