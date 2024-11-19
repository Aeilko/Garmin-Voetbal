import Toybox.Lang;
import Toybox.WatchUi;

class voetbalViewLoop extends ViewLoopFactory {

    private var views as Array<WatchUi.View>;
    private var delegate as WatchUi.BehaviorDelegate;

    function initialize() {
        self.views = [];
        for(var i = 0; i < voetbalApp.TEAMS.size(); i++){
            var team = voetbalApp.TEAMS[i] as Number;
            self.views.add(new matchView(team));
            self.views.add(new statsView(team));
        }
        self.delegate = new voetbalDelegate();
        ViewLoopFactory.initialize();
    }

    function getSize(){
        return self.views.size();
    }

    function getView(page){
        return [self.views[page] as WatchUi.View, self.delegate];
    }
}