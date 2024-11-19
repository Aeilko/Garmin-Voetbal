import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

using Toybox.Application.Storage;

class voetbalApp extends Application.AppBase {

    static const TEAMS = [197, 1118];

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
        for(var i = 0; i < voetbalApp.TEAMS.size(); i++){
            var team = voetbalApp.TEAMS[i] as Number;

            // Match data
            var url = Properties.getValue("teamAPI") + "?team=" + team;
            var params = {};
            var options = {
                :method => Communications.HTTP_REQUEST_METHOD_GET,
                :context => {:team => team,},
            };
            var responseCallback = method(:receiveData);
            Communications.makeWebRequest(url, params, options, responseCallback);
        }
    }

    function receiveData(responseCode as Number, data as Dictionary?, context as Lang.Object) as Void {
        if (responseCode == 200) {
            var res = {};
            if(data.hasKey("game")){
                res.put("game", data["game"]);
            }
            if(data.hasKey("statistics")){
                res.put("stats", data["statistics"]);
            }
            Storage.setValue(context[:team], res);
            WatchUi.requestUpdate();
        }
        else {
            System.println("Something went wrong while receiving data");
            System.println("Context: " + context);
            System.println("Response: " + responseCode);
            System.println("Data: " + data);
        }
    }
}

function getApp() as voetbalApp {
    return Application.getApp() as voetbalApp;
}