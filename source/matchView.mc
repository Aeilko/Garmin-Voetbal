import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

using Toybox.Application.Storage;
using Toybox.Time;
using Toybox.Time.Gregorian;

class matchView extends WatchUi.View {

	private var _teamID as Number;

	function initialize(teamID as Number) {
		View.initialize();
		self._teamID = teamID;
	}

	// Load your resources here
	function onLayout(dc as Dc) as Void {
		// Basic layout
		setLayout(Rez.Layouts.MatchLayout(dc));

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
			var game = team["game"] as Dictionary;
			if (game != null){
				if (game["in_progress"]){
					var upcomingView = (findDrawableById("TextUpcoming") as WatchUi.Text);
					upcomingView.setText("Momenteel bezig");

					var opponent = (game["opponent"] as String);
					opponent = opponent + " " + (game["away"] ? "(U)" : "(T)");
					var oppView = (findDrawableById("TextOpponent") as WatchUi.Text);
					oppView.setText(opponent);

					var score = game["score"] as Dictionary;
					var scoreTxt = "" + score["home"] + " - " + score["away"] + " (" + game["minute"] + "')";
					var timeView = (findDrawableById("TextTime") as WatchUi.Text);
					timeView.setText(scoreTxt);
				}
				else{
					var upcomingView = (findDrawableById("TextUpcoming") as WatchUi.Text);
					upcomingView.setText("Komende wedstrijd");

					var opponent = (game["opponent"] as String);
					opponent = opponent + " " + (game["away"] ? "(U)" : "(T)");
					var oppView = (findDrawableById("TextOpponent") as WatchUi.Text);
					oppView.setText(opponent);

					var ko = (game["kick_off"] as Number);
					var time = new Time.Moment(ko);
					var date = Gregorian.info(time, Time.FORMAT_SHORT);
					var dow = Gregorian.info(time, Time.FORMAT_MEDIUM).day_of_week;
					var timeView = (findDrawableById("TextTime") as WatchUi.Text);
					timeView.setText(Lang.format("$1$ $2$/$3$ $4$:$5$", [dow, date.day.format("%02d"), date.month.format("%02d"), date.hour.format("%02d"), date.min.format("%02d")]));
				}
			}
			else{
				var upcomingView = (findDrawableById("TextUpcoming") as WatchUi.Text);
				upcomingView.setText("Komende wedstrijd");

				var oppView = (findDrawableById("TextOpponent") as WatchUi.Text);
				oppView.setText("Onbekend");

				var timeView = (findDrawableById("TextTime") as WatchUi.Text);
				timeView.setText("");
			}
		}
	}
}
