import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

using Toybox.Application.Storage;
using Toybox.Time;
using Toybox.Time.Gregorian;

class matchView extends WatchUi.View {

	function initialize() {
		View.initialize();
	}

	// Load your resources here
	function onLayout(dc as Dc) as Void {
		// Basic layout
		setLayout(Rez.Layouts.MatchLayout(dc));

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
		var match = (Storage.getValue("match") as Dictionary);
		if (match != null){
			var game = (match["game"] as Dictionary);
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
	}
}
