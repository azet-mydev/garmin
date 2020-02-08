//using Toybox.WatchUi;
//using Toybox.System;
//
//class SummaryMenuDelegate extends WatchUi.Menu2InputDelegate {
//
//    function initialize() {
//        Menu2InputDelegate.initialize();
//    }
//
//    function onSelect(item) {
//        if (item.getId() == :Continue){
//            S_ACTIVITY.resume();
//            S_NOTIFY.signal(NOTIFY.START);
//            S_SM.transition(S_SM.getHistory(-2));
//        } else if (item.getId() == :Save){
//            S_ACTIVITY.stop();
//        	S_NOTIFY.signal(NOTIFY.STOP);
//        	System.exit();
//        } else if (item.getId() == :Discard){
//        	S_ACTIVITY.discard();
//        	S_NOTIFY.signal(NOTIFY.STOP);
//        	System.exit();
//        }
//    }
//    
//    function onBack(){
//    	S_SM.transition(SM.SUMMARY);
//    }
//}