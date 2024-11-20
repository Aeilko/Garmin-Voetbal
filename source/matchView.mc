import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

using Toybox.Application.Storage;
using Toybox.Time;
using Toybox.Time.Gregorian;

class matchView extends TeamTextView {

	function initialize(teamID as Number) {
		TeamTextView.initialize(teamID);
	}

	protected function getLayout(dc as Dc) {
		return Rez.Layouts.MatchLayout(dc);
	}

	protected function updateText(){
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
