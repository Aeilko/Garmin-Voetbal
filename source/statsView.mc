import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

using Toybox.Application.Storage;
using Toybox.Time;
using Toybox.Time.Gregorian;

class statsView extends WatchUi.View {

	private var _teamID as Number;

	function initialize(teamID as Number) {
		View.initialize();
		self._teamID = teamID;
	}

	// Load your resources here
	function onLayout(dc as Dc) as Void {
		// Basic layout
		setLayout(Rez.Layouts.StatsLayout(dc));

		// Custom background color
		var bg = findDrawableById("Background") as CustomBackground;
		bg.setColor(voetbalApp.TEAM_COLORS[self._teamID]);
	}

	// Called when this View is brought to the foreground. Restore
	// the state of this View and prepare it to be shown. This includes
	// loading resources into memory.
	function onShow() as Void {
	}

	// Update the view
	function onUpdate(dc as Dc) as Void {
		// Set texts before drawing layout
		updateText();

		// Call the parent onUpdate function to redraw the layout
		View.onUpdate(dc);
	}

	// Called when this View is removed from the screen. Save the
	// state of this View here. This includes freeing resources from
	// memory.
	function onHide() as Void {
	}

	private function updateText(){
		var team = (Storage.getValue(self._teamID) as Dictionary);
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

					System.println(val);
					
					var homeStat = (findDrawableById("Stat" + key + "Home") as WatchUi.Text);
					var awayStat = (findDrawableById("Stat" + key + "Away") as WatchUi.Text);
					homeStat.setText("" + val["home"]);
					awayStat.setText("" + val["away"]);
				}
			}
		}
	}
}
