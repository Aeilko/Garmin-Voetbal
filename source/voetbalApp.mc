import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

using Toybox.Application.Storage;

class voetbalApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        requestData();
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        var loop = new WatchUi.ViewLoop(new voetbalViewLoop(), {:wrap => true, :color => Graphics.COLOR_WHITE});
        return [ loop, new ViewLoopDelegate(loop) ];
    }

    function onStorageChanged() as Void {
        System.println("Storage changed! Requesting update");
        WatchUi.requestUpdate();
    }

    // HTTPS handling
    function requestData() as Void {
        // Match data
        var url = Properties.getValue("teamAPI");
        var params = {};
        var options = {
            :method => Communications.HTTP_REQUEST_METHOD_GET,
        };
        var responseCallback = method(:receiveData);
        Communications.makeWebRequest(url, params, options, responseCallback);
    }

    function receiveData(responseCode as Number, data as Dictionary?) as Void {
        if (responseCode == 200) {
            if(data.hasKey("game")){
                Storage.setValue("game", data["game"]);
            }
            if(data.hasKey("statistics")){
                Storage.setValue("stats", data["statistics"]);
            }
            WatchUi.requestUpdate();
        }
        else {
            System.println("Something went wrong while receiving data");
            System.println("Response: " + responseCode);
            System.println("Data: " + data);
        }
    }
}

function getApp() as voetbalApp {
    return Application.getApp() as voetbalApp;
}