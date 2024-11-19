import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

using Toybox.Application.Storage;
using Toybox.Time;
using Toybox.Time.Gregorian;

class statsView extends WatchUi.View {

	private var teamID as Number;

	function initialize(teamID as Number) {
		self.teamID = teamID;
		View.initialize();
	}

	// Load your resources here
	function onLayout(dc as Dc) as Void {
		// Basic layout
		setLayout(Rez.Layouts.StatsLayout(dc));

		// Load data
		updateText();
	}

	// Called when this View is brought to the foreground. Restore
	// the state of this View and prepare it to be shown. This includes
	// loading resources into memory.
	function onShow() as Void {
	}

	// Update the view
	function onUpdate(dc as Dc) as Void {
		// Call the parent onUpdate function to redraw the layout
		updateText();
		View.onUpdate(dc);
	}

	// Called when this View is removed from the screen. Save the
	// state of this View here. This includes freeing resources from
	// memory.
	function onHide() as Void {
	}

	private function updateText(){
		var team = (Storage.getValue(teamID) as Dictionary);
		if (team != null){
			var game = team["stats"] as Dictionary;
			if (game != null){
				var s = (game["stats"] as Dictionary);

				var opponent = (game["opponent"] as String);
				opponent = opponent + " " + (game["away"] ? "(U)" : "(T)");
				var oppView = (findDrawableById("TextOpponent") as WatchUi.Text);
				oppView.setText(opponent);

				for(var i = 0; i < s.keys().size(); i+=1){
					var key = s.keys()[i];
					var val = s.get(key) as Dictionary;
					
					var homeStat = (findDrawableById("Stat" + key + "Home") as WatchUi.Text);
					var awayStat = (findDrawableById("Stat" + key + "Away") as WatchUi.Text);
					homeStat.setText("" + val["home"]);
					awayStat.setText("" + val["away"]);
				}
			}
		}
	}
}
