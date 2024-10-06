import Toybox.Lang;
import Toybox.WatchUi;

class voetbalViewLoop extends ViewLoopFactory {

    private var views as Array<WatchUi.View>;
    private var delegate as WatchUi.BehaviorDelegate;

    function initialize() {
        self.views = [new matchView(), new statsView()];
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