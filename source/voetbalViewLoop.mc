import Toybox.Lang;
import Toybox.WatchUi;

class voetbalViewLoop extends ViewLoopFactory {

	private var views as Array<WatchUi.View>;
	private var delegate as WatchUi.BehaviorDelegate;

	function initialize() {
		// Get teams from settings
		var teams = Application.Properties.getValue("teams") as Array;

		// Workaround for defaults not being set
		if(teams == null){
			teams = [{"teamID" => 197}, {"teamID" => 1118}]; // Set default value, PSV and Oranje
			Application.Properties.setValue("teams", teams);
		}

		// Add pages for each team
		self.views = [];
		for(var i = 0; i < teams.size(); i++){
			var team = teams[i] as Dictionary;
			var id = team.get("teamID") as Number;
			self.views.add(new matchView(id));
			self.views.add(new statsView(id));
		}

		// Set loop
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