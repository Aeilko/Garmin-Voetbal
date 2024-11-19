import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class voetbalMenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) as Void {
        System.println(item.getLabel());
    }

}